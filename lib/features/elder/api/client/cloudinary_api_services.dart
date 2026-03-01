import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:senio_care/features/elder/api/models/response/cloudinary_response.dart';

part 'cloudinary_api_services.g.dart';

@RestApi(baseUrl: "https://api.cloudinary.com/v1_1/dxkjotbnm/")
@injectable
abstract class CloudinaryApiServices {

  @factoryMethod
  factory CloudinaryApiServices(Dio dio) = _CloudinaryApiServices;

  @POST("image/upload")
  @MultiPart()
  Future<CloudinaryResponse> uploadImage(
      @Part(name: "file") File file,
      @Part(name: "upload_preset") String preset,
      );
}