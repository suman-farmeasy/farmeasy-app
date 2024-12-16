import 'dart:convert';

import 'package:farm_easy/Screens/ChatSection/view/chat_ui.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/device_token_controller.dart';
import 'package:farm_easy/Screens/Threads/Replies/View/replies.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // request notification service
  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final token = await _firebaseMessaging.getToken();
    print("Device Token: $token");

    // Call the device token controller to hit the API with the token
    if (token != null) {
      DeviceTokenController().fcmToken(token);
    }
  }

  // initialize local notifications
  static Future localNotiInit() async {
    // initialise the plugin. app_icon needs to be added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  static void onNotificationTap(
      NotificationResponse notificationResponse) async {
    print("Notification tapped!");
    final payload = notificationResponse.payload;

    if (payload != null) {
      print("Payload: $payload");
      if (isValidJson(payload)) {
        try {
          final data = jsonDecode(payload);
          final typeCode = data['notification_type_code'];
          final landIdData = data['land_id'];
          final enquiryIdData = data['enquiry_id'];
          final isEnquiryCreatedByMeData = data['is_enquiry_created_by_me'];
          final isEnquiryDisplayeData = data['is_enquiry_display'];
          print("Notification Type Code: $typeCode");
          switch (typeCode) {
            case 'message':
              print("ENTERED");
              final landId = int.tryParse(landIdData?.toString() ?? '0') ?? 0;
              final enquiryId =
                  int.tryParse(enquiryIdData?.toString() ?? '0') ?? 0;
              final userId =
                  int.tryParse(data['sender_user_id']?.toString() ?? '0') ?? 0;
              final userName =
                  data['sender_name']?.toString() ?? 'Unknown User';
              final userFrom =
                  data['sender_lives_in']?.toString() ?? 'Unknown Location';
              final userType =
                  data['sender_user_type']?.toString() ?? 'Unknown Type';
              final image =
                  data['sender_image']?.toString() ?? 'default_image.png';

              final isEnquiryCreatedByMe = isEnquiryCreatedByMeData == 'false';
              final isEnquiryDisplay = isEnquiryDisplayeData == 'true';

              Get.to(() => ChatScreen(
                    landId: landId,
                    enquiryId: enquiryId,
                    userId: userId,
                    userName: userName,
                    userFrom: userFrom,
                    userType: userType,
                    image: image,
                    enquiryData: '',
                    isEnquiryCreatedByMe: isEnquiryCreatedByMe,
                    isEnquiryDisplay: isEnquiryDisplay,
                  ));
              break;
            case 'following':
              print("FOLLOWINF ENTERED");
              final userId =
                  int.tryParse(data['sender_user_id']?.toString() ?? '0') ?? 0;
              final userType =
                  data['sender_user_type']?.toString() ?? 'Unknown Type';
              Get.to(() => UserProfileScreen(id: userId, userType: userType));

              break;
            case 'post':
              final threadId =
                  int.tryParse(data['thread_id']?.toString() ?? '0') ?? 0;
              Get.to(() => Replies(
                    threadId: threadId,
                  ));
              print("USERIUDDDD${threadId}");
              break;
            default:
              print("Unknown notification type.");
              break;
          }
        } catch (e) {
          print("Error parsing JSON payload: $e");
        }
      } else {
        print("Payload is not JSON, assuming it's a file path.");
      }
    } else {
      print("Payload is null, nothing to open.");
    }
  }

  static bool isValidJson(String str) {
    try {
      jsonDecode(str);
    } catch (e) {
      return false;
    }
    return true;
  }

  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}
