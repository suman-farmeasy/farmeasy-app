import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/utils/localization/localization_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Constants/color_constants.dart';

class HomeScreenANDROID_AppBar extends StatelessWidget {
  HomeScreenANDROID_AppBar({
    super.key,
  });

  final localeController = Get.put(LocaleController());
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.DARK_GREEN,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding:
            const EdgeInsets.only(top: 50, bottom: 10, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset(ImageConstants.WHITE_LOGO),
                ),
                Text(
                  'FarmEasy',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 3,
            ),
            const SizedBox(
              width: 2,
            ),
            GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/img/agriculture.png"),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "What is FarmEasy?".tr,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppColor.BROWN_TEXT,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "FarmEasyDescModel".tr,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "How to use FarmEasy?".tr,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppColor.BROWN_TEXT,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "useFarmEasyThisWay".tr,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 18, bottom: 30),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.DARK_GREEN,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Back".tr,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Icon(
                    CupertinoIcons.info,
                    color: Colors.white,
                    size: 17,
                  ),
                ))
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
    );
  }
}
