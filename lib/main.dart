import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
import 'package:farm_easy/Screens/SplashScreen/View/splash_screen.dart';
import 'package:farm_easy/Screens/notification_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'utils/firebase_options.dart';
import 'utils/localization/apptranslations/apptranslations.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Notification Received");
  }
}

late Box box;
void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  box = await Hive.openBox('appData');
  final getProfile = Get.put(GetProfileController());
  getProfile.getProfile();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      //Get.to(() => const MessagePage(), arguments: message);
    }
  });

  // PushNotifications.init();
  // PushNotifications.localNotiInit();

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

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

  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(const Duration(seconds: 1), () {
      //  Get.to(() => MessagePage(), arguments: message);
    });
  }
  runApp(const MyApp()
      // DevicePreview(
      //   enabled: true,
      //   tools: const [
      //     ...DevicePreview.defaultTools,
      //   ],
      //   builder: (context) => const MyApp(),
      // ),
      );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var selectedLang;
  var db = Hive.box('appData');

  @override
  void initState() {
    super.initState();
    translateLang();
  }

  void translateLang() {
    selectedLang = db.get('lang') ?? 'en';
    db.get('selectedLanguage') == 'Hindi'
        ? selectedLang = 'hi'
        : db.get('selectedLanguage') == 'English'
            ? selectedLang = 'en'
            : db.get('selectedLanguage') == 'Punjabi'
                ? selectedLang = 'pa'
                : selectedLang = 'en';
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: AppTranslations(),
            locale: Locale(selectedLang ?? 'en'),
            fallbackLocale: const Locale('en'),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('hi'),
              Locale('pa'),
            ],
            title: 'FARMEASY',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColor.DARK_GREEN),
              useMaterial3: true,
            ),
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0),
                ),
                child: widget ?? const SizedBox(),
              );
            },
            // home: OtpScreen(phoneNumber: '98765432123', countryCode: '91'));
            home: SplashScreen());
      },
    );
  }
}
