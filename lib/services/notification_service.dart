import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    }
  }

  Future<void> scheduleIntervalNotification({
    required Duration interval,
    required String title,
  }) async {
    if (interval.inSeconds <= 0) return;

    for (int i = 0; i < 6; i++) {
      final delay = interval * i;
      _scheduleSingleNotification(100 + i, delay, title);
    }
  }

  void _scheduleSingleNotification(int id, Duration delay, String title) {
    Timer(delay, () async {
      final prefs = await SharedPreferences.getInstance();
      final goal = prefs.getInt('dailyGoal') ?? 2000;
      final consumed = prefs.getInt('consumed') ?? 0;

      await _plugin.show(
        id,
        title,
        'Meta: $goal ml | Já ingerido: $consumed ml',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'hydration_channel',
            'Lembretes de Hidratação',
            channelDescription: 'Notificações para lembrar de beber água',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
      );
    });
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
