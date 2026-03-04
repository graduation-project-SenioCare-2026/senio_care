import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/elder/api/models/request/medical_document_request.dart';
import 'package:senio_care/features/elder/domain/entity/medical_document_entity.dart';
import 'package:senio_care/features/elder/domain/use_case/cloudinary/upload_images_to_cloudinary_use_case.dart';
import 'package:senio_care/features/elder/domain/use_case/medical_documents/create_document_use_case.dart';
import 'package:senio_care/features/elder/domain/use_case/medical_documents/get_elder_documents_use_case.dart';

import 'medical_documents_event.dart';
import 'medical_documents_state.dart';

@injectable
class MedicalDocumentsBloc
    extends Bloc<MedicalDocumentsEvent, MedicalDocumentsState> {
  final UploadImagesToCloudinaryUseCase _uploadImagesUseCase;
  final CreateDocumentUseCase _createDocumentUseCase;
  final GetElderDocumentsUseCase _getElderDocumentsUseCase;

  MedicalDocumentsBloc(
      this._uploadImagesUseCase,
      this._createDocumentUseCase,
      this._getElderDocumentsUseCase,
      ) : super(const MedicalDocumentsState()) {
    on<ChangeDocumentNameEvent>(
          (e, emit) => emit(state.copyWith(documentName: e.name)),
    );

    on<PickDateEvent>((e, emit) => emit(state.copyWith(selectedDate: e.date)));

    on<SelectImagesEvent>((e, emit) {
      emit(
        state.copyWith(
          selectedImages: e.images,
          uploadProgress: List.filled(e.images.length, 0.0),
          clearError: true,
        ),
      );
    });

    on<SaveDocumentEvent>(_saveDocument);
    on<GetElderDocuments>(_getDocuments);
  }

  Future<void> _saveDocument(
      SaveDocumentEvent event,
      Emitter<MedicalDocumentsState> emit,
      ) async {
    // ── Validate state before doing anything ──────────────────────────────
    if (state.documentName.trim().isEmpty) {
      emit(state.copyWith(error: "documentNameRequired".tr()));
      return;
    }
    if (state.selectedImages.isEmpty) {
      emit(state.copyWith(error: "selectAtLeastOneImage".tr()));
      return;
    }

    // ── Step 1: Upload images to Cloudinary ───────────────────────────────
    emit(
      state.copyWith(
        isUploading: true,
        createDocumentStatus: const StateStatus.loading(),
      ),
    );

    final uploadResult = await _uploadImagesUseCase.call(state.selectedImages);

    switch (uploadResult) {
      case Failure<List<String>>():
        emit(
          state.copyWith(
            isUploading: false,
            error: uploadResult.responseException.toString(),
            createDocumentStatus: const StateStatus.initial(),
          ),
        );
        return;

      case Success<List<String>>():
        emit(
          state.copyWith(
            isUploading: false,
            uploadProgress: List.filled(state.selectedImages.length, 1.0),
          ),
        );

        // ── Step 2: Build request from BLoC state ─────────────────────────
        final request = MedicalDocumentRequest(
          elderId: ProfileManager().elder!.id!,
          documentName: state.documentName.trim(),
          date: state.selectedDate!.toIso8601String().substring(0, 10),
          images: uploadResult.data,
        );

        // ── Step 3: Create document on backend ────────────────────────────
        emit(state.copyWith(createDocumentStatus: const StateStatus.loading()));

        final createResult = await _createDocumentUseCase.call(request);

        switch (createResult) {
          case Success<MedicalDocumentEntity>():
            final updatedList = [
              ...?state.getDocumentStatus.data,
              createResult.data,
            ];

            emit(
              state.copyWith(
                createDocumentStatus: StateStatus.success(createResult.data),
                getDocumentStatus: StateStatus.success(updatedList),
                documentName: '',
                selectedDate: DateTime.now(),
                selectedImages: [],
                uploadProgress: [],
                isUploading: false,
              ),
            );

          case Failure<MedicalDocumentEntity>():
            emit(
              state.copyWith(
                createDocumentStatus: StateStatus.failure(
                  createResult.responseException,
                ),
                error: createResult.responseException.toString(),
              ),
            );
        }
    }
  }

  Future<void> _getDocuments(
      GetElderDocuments event,
      Emitter<MedicalDocumentsState> emit,
      ) async {
    emit(state.copyWith(getDocumentStatus: StateStatus.loading()));
    final result = await _getElderDocumentsUseCase.call(event.id);
    switch (result) {
      case Success<List<MedicalDocumentEntity>>():
        emit(
          state.copyWith(getDocumentStatus: StateStatus.success(result.data)),
        );
      case Failure<List<MedicalDocumentEntity>>():
        emit(
          state.copyWith(
            getDocumentStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }
}