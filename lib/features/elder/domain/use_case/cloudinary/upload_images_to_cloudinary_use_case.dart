import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/domain/repository/cloudinary/cloudinary_repo.dart';

@injectable
class UploadImagesToCloudinaryUseCase {
  final CloudinaryRepo _cloudinaryRepo;

  UploadImagesToCloudinaryUseCase(this._cloudinaryRepo);

  Future<Result<List<String>>> call(List<File> images){
    return _cloudinaryRepo.uploadImages(images);
  }

}