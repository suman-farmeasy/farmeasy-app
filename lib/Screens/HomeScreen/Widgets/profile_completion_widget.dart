import 'package:farm_easy/Screens/Auth/CompleteProfile/View/complete_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../utils/Constants/color_constants.dart';
import '../../Auth/CompleteProfile/Controller/get_profile_controller.dart';
import '../Controller/home_controller.dart';
import '../ProfielSection/Controller/profile_complete_controller.dart';

class ProfileCompletion extends StatelessWidget {
  const ProfileCompletion({
    super.key,
    required this.getProfileController,
    required this.profilePercentageController,
    required this.homecontroller,
  });

  final GetProfileController getProfileController;
  final ProfilePercentageController profilePercentageController;
  final HomeController homecontroller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          print(getProfileController.getProfileData.value.result?.userId);
          // Get.to(() => CompleteProfile());
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color(0xFFFFFFF7),
              border: Border.all(color: AppColor.BROWN_SUBTEXT),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: CircularPercentIndicator(
                  radius: MediaQuery.of(context).size.width * 0.1,
                  lineWidth: 8.0,
                  percent: (profilePercentageController
                              .profileData.value.result?.completionPercentage
                              ?.toDouble() ??
                          0.0) /
                      100,
                  startAngle: 0.0,
                  linearGradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      const Color(0xfff1f881f).withOpacity(0.8),
                      const Color(0xfffffe546).withOpacity(0.4),
                    ],
                  ),
                  center: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${profilePercentageController.profileData.value.result?.completionPercentage ?? "60"}%",
                        style: GoogleFonts.poppins(
                          color: AppColor.DARK_GREEN,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      Text(
                        "completed",
                        style: GoogleFonts.poppins(
                          color: AppColor.GREEN_SUBTEXT,
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Provide more information',
                        style: GoogleFonts.poppins(
                          color: AppColor.BROWN_TEXT,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.53,
                      child: Text(
                        'Complete your profile to receive better recommendations.',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF61646B),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 40),
                          child: TextButton(
                            onPressed: () {
                              Get.to(() => const CompleteProfile());
                            },
                            child: Text(
                              'Complete Profile',
                              style: GoogleFonts.poppins(
                                color: AppColor.DARK_GREEN,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Get.to(() => const CompleteProfile());
                            print(
                                "=======================================${await homecontroller.prefs.getUserRole()}");
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColor.DARK_GREEN,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
