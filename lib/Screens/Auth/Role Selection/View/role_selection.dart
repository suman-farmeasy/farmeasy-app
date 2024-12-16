import 'package:farm_easy/Utils/Constants/color_constants.dart';
import 'package:farm_easy/Utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Utils/Constants/image_constant.dart';
import 'package:farm_easy/Screens/Auth/Role%20Selection/Controller/controller.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/View/user_registration.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RoleSelection extends StatefulWidget {
  const RoleSelection({super.key});

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  final controller = Get.put(RoleSelectionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: AppDimension.h * 0.06,
          ),
          Center(
            child: SvgPicture.asset(
              ImageConstants.IMG_TEXT,
              height: AppDimension.h * 0.05,
              width: AppDimension.w * 0.7,
            ),
          ),
          SizedBox(
            height: AppDimension.h * 0.06,
          ),
          Text('What \nrole suits you?',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Color(0xFF483C32),
                fontSize: 36,
                fontWeight: FontWeight.w800,
              )),
          Container(
            height: Get.height * 0.6,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
                itemCount: controller.title.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      controller.userSelection = controller.selection[index];
                      controller.userType();
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        height: Get.height * 0.16,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(
                              0xFFE3E3E3,
                            ),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 8, left: 0),
                              child: SvgPicture.asset(
                                controller.img[index],
                                height: Get.width * 0.26,
                              ),
                            ),
                            Container(
                              width: Get.width * 0.55,
                              margin: EdgeInsets.only(left: 0, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Text(
                                      controller.title[index],
                                      style: GoogleFonts.poppins(
                                        color: AppColor.BROWN_TEXT,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      controller.subtitle[index],
                                      style: GoogleFonts.poppins(
                                        color: AppColor.BROWN_SUBTEXT,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Center(
                                child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                            ))
                          ],
                        ))),
                  );
                }),
          )
        ],
      ),
    );
  }
}
