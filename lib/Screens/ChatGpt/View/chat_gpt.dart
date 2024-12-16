import 'package:farm_easy/Utils/Constants/color_constants.dart';
import 'package:farm_easy/Utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Screens/ChatGpt/Controller/chat_gpt_controller.dart';
import 'package:farm_easy/Screens/Dashboard/view/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatGptScreen extends StatefulWidget {
  const ChatGptScreen({super.key});

  @override
  State<ChatGptScreen> createState() => _ChatGptScreenState();
}

class _ChatGptScreenState extends State<ChatGptScreen> {
  final chatgpt = Get.put(ChatGptController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.CHATGPTBACKGROUNDCOLOR,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppDimension.h * 0.08),
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.white))),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColor.CHATGPTBACKGROUNDCOLOR,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 60, left: 10, right: 30),
                child: InkWell(
                  onTap: () {
                    Get.to(() => DashBoard());
                  },
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                      ),
                      Text(
                        '      Back',
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 15.38,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              shape: const RoundedRectangleBorder(),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: Get.height * 0.77,
                  child: Obx(() {
                    return ListView.builder(
                      reverse: true,
                      itemCount: chatgpt.messages.length,
                      itemBuilder: (context, index) {
                        final reversedIndex =
                            chatgpt.messages.length - index - 1;
                        final message = chatgpt.messages[reversedIndex];
                        return Align(
                          alignment: message.isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: message.isMe
                                  ? AppColor.CHATGPTSENDCOLOR
                                  : Colors.white
                                      .withOpacity(0.20000000298023224),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              message.text,
                              style: message.isMe
                                  ? GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontSize: 15.38,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    )
                                  : GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontSize: 15.38,
                                      fontWeight: FontWeight.w600,
                                    ),
                            ),
                          ),
                        );
                      },
                    );
                  })),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 0.3)),
                child: Container(
                    width: Get.width * 0.8,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: chatgpt.messageController,
                      onChanged: (value) {},
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            chatgpt.sendMessage();
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.CHATGPTSENDCOLOR),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: SvgPicture.asset(
                              "assets/logos/chatsend.svg",
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}

class Message {
  final String text;
  final bool isMe;

  Message(this.text, {this.isMe = false});
}
