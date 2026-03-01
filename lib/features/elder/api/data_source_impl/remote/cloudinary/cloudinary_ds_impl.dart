import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:senio_care/core/result/result.dart';
import 'package:senio_care/core/safe_call/safe_call.dart';
import 'package:senio_care/features/elder/api/client/cloudinary_api_services.dart';
import 'package:senio_care/features/elder/data/data_source/remote/cloudinary/cloudinary_ds.dart';

@Injectable(as: CloudinaryDs)
class CloudinaryDsImpl implements CloudinaryDs {
  final CloudinaryApiServices _cloudinaryApiServices;
  final String _uploadPreset = 'ljfmgb3h';

  CloudinaryDsImpl(this._cloudinaryApiServices);

  @override
  Future<Result<List<String>>> uploadImages(List<File> images) {
    return safeCall(() async {
      // print('📤 Starting upload of ${images.length} image(s) to Cloudinary...');

      final futures = images.asMap().entries.map((entry) async {
        // final index = entry.key;
        final file = entry.value;

        // print('🖼️  [${index + 1}/${images.length}] Uploading: ${file.path}');

        final response = await _cloudinaryApiServices.uploadImage(
          file,
          _uploadPreset,
        );

        // print('✅ [${index + 1}/${images.length}] Uploaded successfully → ${response.secureUrl}');
        return response.secureUrl;
      }).toList();

      final urls = await Future.wait(futures);

      // print('🎉 All ${urls.length} image(s) uploaded to Cloudinary.');
      // print('🔗 URLs:');
      // for (int i = 0; i < urls.length; i++) {
      //   print('   [${i + 1}] ${urls[i]}');
      // }

      return urls;
    });
  }
}