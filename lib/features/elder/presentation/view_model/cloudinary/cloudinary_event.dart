import 'dart:io';

class CloudinaryEvent {}

class UploadImagesEvent extends CloudinaryEvent {
  final List<File> images;

  UploadImagesEvent(this.images);
}