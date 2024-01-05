import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi{
  var initializationSettingsAndroid =
  AndroidInitializationSettings('logo');
  static final notification=FlutterLocalNotificationsPlugin();
  static Future notificationDetails( )async{
    return  NotificationDetails(
        android: AndroidNotificationDetails(

            'channel id',
            'channel name',
            // 'channel description',
            importance: Importance.max
            ,icon: '@mipmap/ic_launcher'      ),

        iOS: IOSNotificationDetails()
    );
  }

  static Future ShowNotification(
      {
        int id=0,
        String?  title,
        String?  body,
        String? payload

      }
      )async{
    notification.show(id, title, body,

      await notificationDetails(),payload: payload,
    );
  }
}