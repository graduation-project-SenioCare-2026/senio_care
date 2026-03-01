import 'dart:io';

import 'package:senio_care/core/result/result.dart';

abstract interface class CloudinaryDs {
Future<Result<List<String>>> uploadImages(List<File> images);
}