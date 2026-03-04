import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:senio_care/core/state_status/state_status.dart';
import 'package:senio_care/features/elder/domain/entity/medical_document_entity.dart';

class MedicalDocumentsState extends Equatable {
  final String documentName;
  final DateTime? selectedDate;
  final List<File> selectedImages;

  final List<double> uploadProgress;
  final bool isUploading;

  final StateStatus<MedicalDocumentEntity> createDocumentStatus;
  final String? error;

  final StateStatus<List<MedicalDocumentEntity>> getDocumentStatus;
  final StateStatus<String> deleteDocumentStatus;

  const MedicalDocumentsState({
    this.documentName = '',
    this.selectedDate,
    this.selectedImages = const [],
    this.uploadProgress = const [],
    this.isUploading = false,
    this.createDocumentStatus = const StateStatus.initial(),
    this.error,
    this.getDocumentStatus = const StateStatus.initial(),
    this.deleteDocumentStatus=const StateStatus.initial()
  });

  MedicalDocumentsState copyWith({
    String? documentName,
    DateTime? selectedDate,
    List<File>? selectedImages,
    List<double>? uploadProgress,
    bool? isUploading,
    StateStatus<MedicalDocumentEntity>? createDocumentStatus,
    String? error,
    bool clearError = false,
    StateStatus<List<MedicalDocumentEntity>>? getDocumentStatus,
    final StateStatus<String>? deleteDocumentStatus
  }) {
    return MedicalDocumentsState(
      documentName: documentName ?? this.documentName,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedImages: selectedImages ?? this.selectedImages,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      isUploading: isUploading ?? this.isUploading,
      createDocumentStatus: createDocumentStatus ?? this.createDocumentStatus,
      error: clearError
          ? null
          : (error ?? this.error), // ✅ preserves old error unless cleared
      getDocumentStatus: getDocumentStatus ?? this.getDocumentStatus,
      deleteDocumentStatus: deleteDocumentStatus??this.deleteDocumentStatus
    );
  }

  @override
  List<Object?> get props => [
    documentName,
    selectedDate,
    selectedImages,
    uploadProgress,
    isUploading,
    createDocumentStatus,
    error,
    getDocumentStatus,
    deleteDocumentStatus
  ];
}
