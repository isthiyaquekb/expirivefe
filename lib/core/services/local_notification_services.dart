import 'package:expirevefe/core/constant/app_string.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationServices {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onClickNotification=BehaviorSubject<String>();


  //ON TAP ON ANY NOTIFICATION
  static void onTapNotification(NotificationResponse response){
    onClickNotification.add(response.payload!);
  }


  // INITIALIZATION
  static Future init() async {
    tz.initializeTimeZones();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(onDidReceiveLocalNotification: null);

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // request notification permissions
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTapNotification,
      onDidReceiveBackgroundNotificationResponse: onTapNotification
    );
  }

  ///SIMPLE NOTIFICATION
  static Future showSimpleNotification(
      String title, String body, String payload) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            AppString.notificationChannelId, AppString.notificationChannelName,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  ///REPEATED NOTIFICATION
  static Future showRepeatedNotification(
      String title, String body, String payload) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            AppString.notificationChannelId, AppString.notificationChannelName,
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            sound: RawResourceAndroidNotificationSound("f1_notification"),
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0, title, body, RepeatInterval.everyMinute, notificationDetails,
        payload: payload);
  }

  ///SCHEDULED NOTIFICATION
  static Future showScheduleNotification(
      int hour, int minutes, String title, String body, String payload) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        AppString.notificationChannelId, AppString.notificationChannelName,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound("f1_notification"),
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0, title, body,
        checkForTime(hour,minutes),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: payload);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) => CupertinoAlertDialog(
    //       title: Text(title??''),
    //       content: Text(body??''),
    //       actions: [
    //         CupertinoDialogAction(
    //           isDefaultAction: true,
    //           child: Text('Ok'),
    //           onPressed: () async {
    //             Navigator.of(context, rootNavigator: true).pop();
    //             await Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => SecondScreen(payload),
    //               ),
    //             );
    //           },
    //         )
    //       ],
    //     ),
    //   );
  }

  static tz.TZDateTime checkForTime(int hour,int minute) {
    final tz.TZDateTime now =tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleTime=tz.TZDateTime(tz.local,now.year,now.month,now.day,hour,minute);
    if(scheduleTime.isBefore(now)){
      scheduleTime = scheduleTime.add(const Duration(days: 5));
    }
    return scheduleTime;
  }
}
