import 'package:senio_care/core/state_status/state_status.dart';

class UploadCloudinaryState {
  StateStatus<List<String>> uploadToCloudinaryStatus;

  UploadCloudinaryState({
    this.uploadToCloudinaryStatus = const StateStatus.initial(),
  });

  UploadCloudinaryState copyWith({
    StateStatus<List<String>>? uploadToCloudinaryStatus,
  }) {
    return UploadCloudinaryState(
      uploadToCloudinaryStatus:
          uploadToCloudinaryStatus ?? this.uploadToCloudinaryStatus,
    );
  }
}
