import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:farm_easy/Utils/Constants/color_constants.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
import 'package:farm_easy/Screens/SplashScreen/View/splash_screen.dart';
import 'package:farm_easy/Screens/notification_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Utils/firebase_options.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Notification Received");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final getProfile = Get.put(GetProfileController());
  getProfile.getProfile();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      //Get.to(() => const MessagePage(), arguments: message);
    }
  });

  // PushNotifications.init();
  // PushNotifications.localNotiInit();

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  //listen to foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foregorund");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  // for handling in terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      //  Get.to(() => MessagePage(), arguments: message);
    });
  }
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FARMEASY',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.DARK_GREEN),
          useMaterial3: true,
        ),
        //  home: SplashScreen(),
        // home: UserRegistration(
        //   userType: StringConstatnt.AGRI_PROVIDER,
        // ));
        home: SplashScreen());
  }
}
