import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/Screens/ChatGpt/View/chat_gpt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatGptStartScreen extends StatefulWidget {
  const ChatGptStartScreen({super.key});

  @override
  State<ChatGptStartScreen> createState() => _ChatGptStartScreenState();
}

class _ChatGptStartScreenState extends State<ChatGptStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff343541),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.06,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    )),
                Text(" ")
              ],
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: SvgPicture.asset(
                  ImageConstants.CHATGPT,
                  color: Colors.white,
                )),
            SizedBox(
              height: Get.height * 0.23,
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Welcome to\nFarm Assistant',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
                Text(
                  'Ask anything, get yout answer',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Get.to(() => ChatGptScreen());
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.CHATGPTSENDCOLOR,
          ),
          child: Text(
            'New Query',
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}
