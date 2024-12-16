import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Constants/image_constant.dart';
import 'package:farm_easy/Screens/Auth/EmailLogin/Controller/email_controller.dart';
import 'package:farm_easy/Screens/Auth/EmailLogin/OTP/controller/controller.dart';
import 'package:farm_easy/Screens/Auth/EmailLogin/View/email_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class EmailOtpScreen extends StatefulWidget {
  EmailOtpScreen({super.key, required this.email});
  String? email;

  @override
  State<EmailOtpScreen> createState() => _EmailOtpScreenState();
}

class _EmailOtpScreenState extends State<EmailOtpScreen> {
  EmailOtpScreenController controller = Get.put(EmailOtpScreenController());
  EmailController resendController = Get.put(EmailController());
  @override
  Widget build(BuildContext context) {
    controller.email = widget.email.toString();
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
                height: AppDimension.h * 0.04,
              ),
              Center(
                  child: Text(
                "📬 We’ve sent you an email",
                style: GoogleFonts.poppins(
                  color: AppColor.BROWN_TEXT,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )),
              SizedBox(
                height: AppDimension.h * 0.05,
              ),
              Text(
                "Please enter the OTP we sent over the email",
                style: GoogleFonts.poppins(
                  color: AppColor.BROWN_TEXT,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 0.12,
                ),
              ),
              SizedBox(
                height: AppDimension.h * 0.01,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.email}",
                    style: GoogleFonts.poppins(
                      color: AppColor.BROWN_TEXT,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 0.12,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.off(() => EmailLogin());
                      },
                      icon: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF044D3A).withOpacity(0.08)),
                        child: SvgPicture.asset(
                          ImageConstants.EDIT_BTN,
                          height: 15,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: AppDimension.h * 0.02,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
                child: Pinput(
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
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: List.generate(controller.otp.length, (index) {
              //     return Container(
              //       height: AppDimension.h * 0.07,
              //       width: AppDimension.w * 0.12,
              //       alignment: Alignment.center,
              //       child: TextFormField(
              //         controller: controller.otp[index],
              //         focusNode: controller.focusNodes[index],
              //         textAlign: TextAlign.center,
              //         keyboardType: TextInputType.number,
              //         maxLength: 1,
              //         decoration: InputDecoration(
              //           hintText: '*',
              //           hintStyle: TextStyle(color: Colors.grey.shade400),
              //           contentPadding: EdgeInsets.symmetric(vertical: 10),
              //           counter: Offstage(),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius:
              //                 BorderRadius.circular(AppDimension.w * 0.03),
              //             borderSide: BorderSide(
              //               color: Colors.grey,
              //             ),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(5),
              //             borderSide: BorderSide(
              //               color: AppColor.DARK_GREEN,
              //             ),
              //           ),
              //         ),
              //       ),
              //     );
              //   }),
              // ),
              SizedBox(
                height: AppDimension.h * 0.02,
              ),
              Obx(() {
                return Row(
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
                        ? TextButton(
                            onPressed: () {
                              resendController.login();
                            },
                            child: Text(
                              "Resend Code",
                              style: TextStyle(
                                color: AppColor.DARK_GREEN,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                              ),
                            ))
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
                );
              }),
              SizedBox(
                height: AppDimension.h * 0.2,
              ),
              Obx(
                () => controller.loading.value
                    ? Container(
                        height: AppDimension.h * 0.07,
                        width: AppDimension.w * 0.85,
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
                          if (controller.isOtpComplete.value) {
                            print("NEW PIN${controller.otpValue.value}");
                            controller.varify();
                          }
                        },
                        child: Container(
                          height: AppDimension.h * 0.07,
                          width: AppDimension.w * 0.85,
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
