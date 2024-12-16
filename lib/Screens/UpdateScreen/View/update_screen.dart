import 'dart:io';

import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: AppDimension.h * 0.07,
          ),
          SvgPicture.asset(
            ImageConstants.IMG_TEXT,
            height: AppDimension.h * 0.05,
            width: AppDimension.w * 0.7,
          ),
          SizedBox(
            height: AppDimension.h * 0.06,
          ),
          SvgPicture.asset("assets/img/update.svg"),
          SizedBox(
            height: 30,
          ),
          Text(
            "Update App",
            style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColor.BROWN_TEXT),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Center(
              child: Text(
                "Update now to enjoy a smoother, faster experience! We've made key improvements to enhance performance and fix bugs, so you can get the most out of the app. Don't miss out—upgrade today!",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.BROWN_TEXT),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: Platform.isAndroid
                ? () async {
                    await launchUrl(Uri.parse(
                        'https://play.google.com/store/apps/details?id=ai.farmeasy.codenicely'));
                  }
                : () async {
                    await launchUrl(Uri.parse(
                        'https://apps.apple.com/in/app/farmeasy-ai/id6670382864'));
                    // Handle update logic for iOS
                  },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.06,
              padding: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColor.DARK_GREEN),
              child: Center(
                child: Text(
                  'Update',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
