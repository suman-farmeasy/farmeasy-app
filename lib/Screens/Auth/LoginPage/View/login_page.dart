import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/utils/Constants/string_constant.dart';
import 'package:farm_easy/Screens/Auth/EmailLogin/View/email_login.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/Controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(AuthController());
  String getFlagEmoji(String countryCode) {
    if (countryCode.isEmpty) return '';

    const int flagOffset = 0x1F1E6;
    const int asciiOffset = 0x41;

    final int firstChar = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
    final int secondChar = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;

    return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  }

  var isCountrySelected = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: AppDimension.h * 0.06,
              ),
              SvgPicture.asset(
                ImageConstants.IMG_TEXT,
                height: AppDimension.h * 0.05,
                width: AppDimension.w * 0.7,
              ),
              SizedBox(
                height: AppDimension.h * 0.06,
              ),
              Center(child: StringConstatnt.WELCOME_TO_FARMEASY),
              SizedBox(
                height: AppDimension.h * 0.05,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enter your phone number',
                    style: TextStyle(
                      color: Color(0xFF483C32),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                      color: Color(0xFF483C32),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppDimension.h * 0.02,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.BROWN_SUBTEXT)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "  🇮🇳 India",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF4F4F4F),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // controller.selectCountry();
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.transparent,
                        size: 40,
                      ),
                    )
                  ],
                ),
              ),
              // InkWell(
              //   onTap: () {
              //     controller.selectCountry();
              //   },
              //   child: Container(
              //     margin: EdgeInsets.symmetric(horizontal: 20),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         border: Border.all(color: AppColor.BROWN_SUBTEXT)),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Obx(() {
              //           final selectedCountry = controller.selectedCountry.value;
              //           final countryName = selectedCountry?.name;
              //           final countryCode = selectedCountry?.countryCode ?? '';
              //
              //           return selectedCountry?.name != null
              //               ? Row(
              //                   children: [
              //                     Text(
              //                       '  ${getFlagEmoji(countryCode)}  ',
              //                       style: TextStyle(fontSize: 20),
              //                     ),
              //                     Text(
              //                       countryName ?? "",
              //                       style: GoogleFonts.poppins(
              //                         color: selectedCountry != null
              //                             ? Color(0xFF4F4F4F)
              //                             : Color(0xFF757575),
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w500,
              //                         height: 0.10,
              //                       ),
              //                     ),
              //                   ],
              //                 )
              //               : Container(
              //                   margin: EdgeInsets.symmetric(vertical: 20),
              //                   child: Text(
              //                     "  Country/Region",
              //                     style: GoogleFonts.poppins(
              //                       color: selectedCountry != null
              //                           ? Color(0xFF4F4F4F)
              //                           : Color(0xFF757575),
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.w500,
              //                       height: 0.10,
              //                     ),
              //                   ),
              //                 );
              //         }),
              //         IconButton(
              //           onPressed: () {
              //             controller.selectCountry();
              //           },
              //           icon: Icon(
              //             Icons.keyboard_arrow_down_rounded,
              //             color: AppColor.BROWN_SUBTEXT,
              //             size: 40,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: AppDimension.h * 0.02,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.BROWN_SUBTEXT)),
                child: Obx(() {
                  final selectedCountry = controller.selectedCountry.value;
                  //  final countryCode = selectedCountry?.phoneCode ?? '';
                  return Row(
                    children: [
                      Center(
                        child: Container(
                          child: const Text(
                            "  +91",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0.09,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.68,
                        child: TextFormField(
                          focusNode: controller.focusNode,
                          controller: controller.phoneController.value,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            controller.isCountrySelected.value =
                                value.isNotEmpty;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone number",
                            hintStyle: GoogleFonts.poppins(
                              color: selectedCountry != null
                                  ? const Color(0xFF4F4F4F)
                                  : const Color(0xFF757575),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 0.10,
                            ),
                            // prefixText: "+${controller.countryCode.value} ",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            }
                            if (!value
                                .startsWith(controller.countryCode.value)) {
                              return 'Phone number must start with the country code';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(
                height: AppDimension.h * 0.01,
              ),
              Text('We will send you one time password to verify your number.',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF757575),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: AppDimension.h * 0.06,
              ),
              Obx(
                () => controller.loading.value
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.DARK_GREEN,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          controller.isCountrySelected.value
                              ? controller.login()
                              : Container();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: controller.isCountrySelected.value
                                ? AppColor.DARK_GREEN
                                : const Color(0x19044D3A),
                          ),
                          child: Center(
                            child: Text(
                              "Proceed",
                              style: GoogleFonts.poppins(
                                color: controller.isCountrySelected.value
                                    ? Colors.white
                                    : const Color(0xFFA0A6A3),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: AppDimension.h * 0.03,
              ),
              const Text("or"),
              SizedBox(
                height: AppDimension.h * 0.05,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const EmailLogin());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.DARK_GREEN)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        color: AppColor.DARK_GREEN,
                      ),
                      Text(
                        "     Get started with Email",
                        style: GoogleFonts.poppins(
                          color: AppColor.DARK_GREEN,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
