import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz_data.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidInit);

    await _plugin.initialize(settings);

    // ✅ السطر ده كان فيه typo - اتصلح دلوقتي
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
      await androidPlugin.requestExactAlarmsPermission();
    }
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      _toTZDateTime(scheduledDate),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'med_channel_v3',
          'Medicine Notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          visibility: NotificationVisibility.public,
        ),
      ),

      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      //matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static tz.TZDateTime _toTZDateTime(DateTime dateTime) {
    return tz.TZDateTime.from(dateTime, tz.local);
  }

  static Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  static Future<void> showInstantNotification() async {
    await _plugin.show(
      0,
      "Test Notification 🔔",
      "لو شايفة الرسالة دي يبقى كل حاجة شغالة ✔️",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test Channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  static Future<void> initFCM({
    required Function(String token) onTokenReceived,
  }) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 🔐 permission
    await messaging.requestPermission();

    // 📲 أول token
    final token = await messaging.getToken();
    if (token != null) {
      onTokenReceived(token);
    }

    // 🔄 لو التوكن اتغير
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      onTokenReceived(newToken);
    });
  }

  // لو عايزة تجيبيه في أي مكان
  static Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}