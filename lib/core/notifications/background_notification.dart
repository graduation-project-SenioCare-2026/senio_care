import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';

import 'notification_service.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    await NotificationService.init();

    return Future.value(true);
  });
}