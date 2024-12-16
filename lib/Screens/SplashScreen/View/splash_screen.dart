import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Constants/image_constant.dart';
import 'package:farm_easy/Screens/Dashboard/controller/current_location_controller.dart';
import 'package:farm_easy/Screens/SplashScreen/Controller/splashscreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashController = Get.put(SplashController());

  final locationCOntroller = Get.put(CurrentLocation());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationCOntroller.detectLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SlideTransition(
                position: splashController.animationTop,
                child: Image.asset(
                  ImageConstants.SPLASH_1,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Hero(
                        tag: 'logo',
                        child: SvgPicture.asset(
                          ImageConstants.LOGO_TEXT,
                          width: 200,
                          height: 100,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: TweenAnimationBuilder(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(seconds: 2),
                          builder: (context, double value, child) {
                            return LinearProgressIndicator(
                              minHeight: 5,
                              value: value,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.DARK_GREEN),
                            );
                          },
                          onEnd: () {
                            splashController.isLogin();
                            //  print("================================================================${splashController.isLogin()}");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SlideTransition(
                position: splashController.animationBottom,
                child: Image.asset(
                  ImageConstants.SPLASH_2,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
