import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Constants/image_constant.dart';
import 'package:farm_easy/Constants/string_constant.dart';
import 'package:farm_easy/Screens/Auth/EmailLogin/Controller/email_controller.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/View/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final controller = Get.put(EmailController());

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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
              Center(child: StringConstatnt.WELCOME_TO_FARMEASY),
              SizedBox(
                height: AppDimension.h * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Please enter your email',
                  style: TextStyle(
                    color: Color(0xFF483C32),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0.10,
                  ),
                ),
              ),
              SizedBox(
                height: AppDimension.h * 0.02,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.BROWN_SUBTEXT),
                ),
                child: Obx(() {
                  return TextFormField(
                    focusNode: controller.focusNode,
                    controller: controller.emailController.value,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      final lowerCaseValue = value.toLowerCase();
                      final cursorPosition =
                          controller.emailController.value.selection;

                      controller.emailController.value.value =
                          controller.emailController.value.value.copyWith(
                        text: lowerCaseValue,
                        selection: cursorPosition,
                      );
                      controller.emailFill.value = lowerCaseValue.isNotEmpty;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  );
                }),
              ),

              SizedBox(
                height: AppDimension.h * 0.01,
              ),
              // Text(
              //     'We will send you one time password to verify your email.        ',
              //     style: GoogleFonts.poppins(
              //       color: Color(0xFF757575),
              //       fontSize: 10,
              //       fontWeight: FontWeight.w500,
              //     )),
              SizedBox(
                height: AppDimension.h * 0.04,
              ),
              Center(
                child: Obx(() {
                  return controller.loading.value
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 18, horizontal: 20),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.DARK_GREEN),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            controller.emailFill.value
                                ? controller.login()
                                : Container();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 20),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: controller.emailFill.value
                                  ? AppColor.DARK_GREEN
                                  : Color(0x19044D3A),
                            ),
                            child: Center(
                              child: Text(
                                "Proceed",
                                style: GoogleFonts.poppins(
                                  color: controller.emailFill.value
                                      ? Colors.white
                                      : Color(0xFFA0A6A3),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                }),
              ),
              SizedBox(
                height: AppDimension.h * 0.03,
              ),
              Center(child: Text("or")),
              SizedBox(
                height: AppDimension.h * 0.05,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.to(() => LoginPage());
                  },
                  child: Container(
                    height: AppDimension.h * 0.07,
                    width: AppDimension.w * 0.85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.DARK_GREEN)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.call,
                          color: AppColor.DARK_GREEN,
                        ),
                        Text(
                          "     Get started with Phone Number",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
