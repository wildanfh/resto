import 'dart:isolate';
import 'dart:ui';
import 'package:resto_app/api/api_service.dart';
import 'package:resto_app/main.dart';
import 'package:resto_app/model/restaurants.dart';
import 'package:resto_app/util/notification_util.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationUtil notificationUtil = NotificationUtil();
    Restaurants result = await ApiService().fetchRandomOne();
    await notificationUtil.showNotification(
      flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}