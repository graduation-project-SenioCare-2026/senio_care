import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/elder/domain/use_case/cloudinary/upload_images_to_cloudinary_use_case.dart';
import 'cloudinary_event.dart';
import 'cloudinary_state.dart';

@injectable
class UploadCloudinaryBloc
    extends Bloc<CloudinaryEvent, UploadCloudinaryState> {
  final UploadImagesToCloudinaryUseCase _uploadUseCase;

  UploadCloudinaryBloc(this._uploadUseCase)
      : super(UploadCloudinaryState()) {

    on<UploadImagesEvent>(_uploadImages);
  }

  Future<void> _uploadImages(
      UploadImagesEvent event,
      Emitter<UploadCloudinaryState> emit,
      ) async {

    emit(state.copyWith(uploadToCloudinaryStatus: StateStatus.loading()));

    final result = await _uploadUseCase(event.images);

    switch(result) {
      case Success<List<String>>():
        emit(state.copyWith(
            uploadToCloudinaryStatus: StateStatus.success(result.data)
        ));
      case Failure<List<String>>():
        emit(state.copyWith(
            uploadToCloudinaryStatus: StateStatus.failure(result.responseException)
    ));
    }
  }
}