import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/utils/Constants/string_constant.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/Controller/auth_controller.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/OTP/controller/controller.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/View/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key, required this.phoneNumber, required this.countryCode});
  String? phoneNumber;
  String? countryCode;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  OtpScreenController controller = Get.put(OtpScreenController());
  AuthController resendController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.isOtpComplete.value = true;
  }

  @override
  Widget build(BuildContext context) {
    controller.countryCode = widget.countryCode.toString();
    controller.phoneNumber = widget.phoneNumber.toString();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Container(child: Center(child: StringConstatnt.OTP_VERIFICATION)),
              InkWell(
                onTap: () {
                  controller.generateAppHash();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Please enter the code we sent over SMS to",
                    style: GoogleFonts.poppins(
                      color: AppColor.BROWN_SUBTEXT,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 0.12,
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "+91 ${controller.phoneNumber} ",
                    style: GoogleFonts.poppins(
                      color: AppColor.BROWN_SUBTEXT,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 0.12,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.off(() => LoginPage());
                      },
                      icon: SvgPicture.asset(
                        ImageConstants.EDIT_BTN,
                        height: 20,
                      ))
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
                child: Pinput(
                  controller: controller.otpController.value,
                  focusNode: controller.focusNode,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  defaultPinTheme: PinTheme(
                    width: MediaQuery.of(context).size.width * 0.13,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF727272)),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                      width: MediaQuery.of(context).size.width * 0.13,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      textStyle: TextStyle(fontSize: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(2),
                      )),
                  submittedPinTheme: PinTheme(
                      textStyle: TextStyle(fontSize: 20),
                      width: MediaQuery.of(context).size.width * 0.13,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      )),
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) {
                    controller.otpValue.value = pin;
                    controller.isOtpComplete.value = true;
                    print(pin);
                  },
                ),
              ),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: controller.timerSecondsRemaining.value > 0,
                        child: Text(
                          "${controller.timerSecondsRemaining.value}s  ",
                          style: GoogleFonts.poppins(
                            color: AppColor.BROWN_TEXT,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 0.10,
                          ),
                        ),
                      ),
                      controller.timerFinished.value
                          ? Obx(() {
                              return InkWell(
                                onTap: controller.resendAttempts.value < 5
                                    ? () {
                                        controller.resendOtp();
                                      }
                                    : null, // Disable the button after 5 attempts
                                child: Text(
                                  controller.resendAttempts.value < 5
                                      ? "Resend OTP"
                                      : "Limit reached",
                                  style: TextStyle(
                                    color: controller.resendAttempts.value < 5
                                        ? AppColor.DARK_GREEN
                                        : AppColor
                                            .BROWN_SUBTEXT, // Change color if limit is reached
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            })
                          : Text(
                              "before you can resend",
                              style: TextStyle(
                                color: AppColor.BROWN_SUBTEXT,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 0.10,
                              ),
                            ),
                    ],
                  ),
                );
              }),
              SizedBox(
                height: AppDimension.h * 0.15,
              ),
              Obx(
                () => controller.loading.value
                    ? Container(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.DARK_GREEN,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          if (controller.isOtpComplete.value) {
                            print("NEW PIN${controller.otpValue.value}");
                            controller.verify();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: controller.isOtpComplete.value
                                ? AppColor.DARK_GREEN
                                : Color(0x19044D3A),
                          ),
                          child: Center(
                            child: Text(
                              "Verify",
                              style: GoogleFonts.poppins(
                                color: controller.isOtpComplete.value
                                    ? Colors.white
                                    : Color(0xFFA0A6A3),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
