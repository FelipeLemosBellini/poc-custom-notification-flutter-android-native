import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:poc_local_notification/local_notification.dart';

class MainController extends ChangeNotifier {
  static const platform = MethodChannel('com.example.poc_local_notification');
  int _progress = 0;

  void initController() async {
    LocalNotificationService.init();
    if (!await Permission.notification.isGranted) {
      Permission.notification.request();
    }
  }

  void deleteNotification() {
    LocalNotificationService.cancelNotification(1234);
  }

  Future<void> showCustomNotification() async {
    try {
      print("invoke showProgressBarNotification");
      await platform.invokeMethod('showProgressBarNotification', {"progress": _progress});
    } on PlatformException catch (e) {
      print("Erro ao chamar o método nativo: ${e.message}");
    }
  }

  void simulateProgress() async {
    _progress += 10;
    await showCustomNotification();
  }
}
