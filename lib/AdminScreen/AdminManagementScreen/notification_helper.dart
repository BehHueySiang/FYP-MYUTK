import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper{
    static final _notification =FlutterLocalNotificationsPlugin();

    static init(){
        _notification.initialize(const InitializationSettings(
          android: AndroidInitializationSettings("https://www.hsbehopper.com/MyUTK/assets/Logo/MyUTK_logo_Email.png"),
          iOS: DarwinInitializationSettings()
        ));

    }

static pushNotification({required String title, required String body})async{
  var androidDetails =  AndroidNotificationDetails(
    'Important_channel', 
    'Mychannel',
    importance: Importance.max,
    priority: Priority.high
    );
    var iosDetails = const DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
    await _notification.show(100, title, body, notificationDetails);
}



}