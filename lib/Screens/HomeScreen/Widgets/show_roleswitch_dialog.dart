import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Constants/color_constants.dart';
import '../../Auth/Role Selection/Controller/controller.dart';

final controller = Get.put(RoleSelectionController());

void showRoleDialog(BuildContext context, String selectedRole) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withOpacity(0.5), // Background dimming
    transitionDuration:
        const Duration(milliseconds: 300), // Smooth animation duration
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Switch Between Roles',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: Get.height * 0.5,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.title.length - 1,
                      itemBuilder: (context, index) {
                        log('Selected Role == $selectedRole');
                        log('Nedd to Selected Role == ${controller.selection}');
                        return InkWell(
                          onTap: () {
                            // controller.userSelection =
                            //     controller.selection[index];
                            // controller.userType();
                          },
                          child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              height: Get.height * 0.2,
                              width: double.infinity,
                              decoration: selectedRole ==
                                      controller.selection[index]
                                  ? BoxDecoration(
                                      color: const Color(0xFFF9F9DF),
                                      border: Border.all(
                                        color: AppColor.DARK_GREEN,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                  : BoxDecoration(
                                      border: Border.all(
                                        color: const Color(
                                          0xFFE3E3E3,
                                        ),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                              child: Center(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.only(top: 8, left: 0),
                                    child: SvgPicture.asset(
                                      controller.img[index],
                                      height: Get.width * 0.26,
                                    ),
                                  ),
                                  Container(
                                    width: Get.width * 0.3,
                                    margin:
                                        const EdgeInsets.only(left: 0, top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          controller.title[index],
                                          style: GoogleFonts.poppins(
                                            color: AppColor.BROWN_TEXT,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                            controller.subtitle[index],
                                            style: GoogleFonts.poppins(
                                              color: AppColor.BROWN_SUBTEXT,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Center(
                                      child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                  ))
                                ],
                              ))),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack, // Smooth animation curve
          ),
          child: child,
        ),
      );
    },
  );
}
