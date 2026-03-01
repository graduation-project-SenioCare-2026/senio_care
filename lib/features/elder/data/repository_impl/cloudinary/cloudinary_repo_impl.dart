import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/features/elder/data/data_source/remote/cloudinary/cloudinary_ds.dart';
import 'package:senio_care/features/elder/domain/repository/cloudinary/cloudinary_repo.dart';

@Injectable(as: CloudinaryRepo)
class CloudinaryRepoImpl implements CloudinaryRepo{
  final CloudinaryDs _cloudinaryDs;

  CloudinaryRepoImpl(this._cloudinaryDs);

  @override
  Future<Result<List<String>>> uploadImages(List<File> images) {
    return _cloudinaryDs.uploadImages(images);
  }
}