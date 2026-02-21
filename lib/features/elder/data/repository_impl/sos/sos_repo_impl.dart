import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:senio_care/features/elder/domain/repository/sos/sos_repo.dart';

@LazySingleton(as: SosRepo)
class SosRepoImpl implements SosRepo {
  @override
  Future<void> callNumber(String number) async {
    var status = await Permission.phone.request();

    if (status.isGranted) {
      await FlutterPhoneDirectCaller.callNumber(number);
    } else {
      throw Exception("Permission denied");
    }
  }
}
