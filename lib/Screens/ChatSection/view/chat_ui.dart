

import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Screens/ChatSection/Controller/chat_controller.dart';
import 'package:farm_easy/Screens/ChatSection/Controller/message_seen_controller.dart';
import 'package:farm_easy/Screens/ChatSection/Controller/sendmessage_controller.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
   ChatScreen({super.key,  required this.landId, required this.enquiryId, required this.userId ,required this.userName, required this.userFrom, required this.userType, required this.image, required this.enquiryData, required this.isEnquiryCreatedByMe, required this.isEnquiryDisplay});
   final int landId;
   final int enquiryId;
   final int userId;
   final String userName;
   final String userType;
   final String userFrom;
   final String image;
   final bool isEnquiryDisplay;
   final String enquiryData;
   final bool isEnquiryCreatedByMe;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = Get.put(ChatController());
  final messageController = Get.put(SendMessageController());
  final ismsgseenController = Get.put(MessageSeenController());

  @override
  Widget build(BuildContext context) {
 chatController.enquiryId.value= widget.enquiryId;
 messageController.userId.value= widget.userId;
 messageController.landId.value= widget.landId;
 ismsgseenController.enquiryId.value= widget.enquiryId;
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.22),
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColor.DARK_GREEN,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 60, left: 10,right: 30),
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      Get.back();
                    }, icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,)),
                    widget.landId!=0?Text(
                      '         Enquiry Details(#${widget.landId})',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      ),
                    ):Text(
                      '         Enquiry Details',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      ),
                    ),
                  ],
                ),
              ),

              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: Get.height*0.1,
              width: double.infinity,

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap:(){
                      Get.to(()=>UserProfileScreen(id: widget.userId, userType: widget.userType,));
                    },
                    child: Container(
                      height: Get.height*0.1,
                      width: Get.width*0.23,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(widget.image)
                          )
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          widget.userName,
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width*0.7,
                        child: Text(
                          '${widget.userType} from ${widget.userFrom}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        width: Get.width*0.7,
                        child: Text(
                          widget.isEnquiryDisplay==false?"": "Enquiry created by ${widget.isEnquiryCreatedByMe== true?"you":"${widget.userName}"} at ${widget.enquiryData}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: Get.height * 0.65,
                  child: Obx(() => ListView.builder(
                     controller: chatController.scrollController,
                    shrinkWrap: true,
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    itemCount: chatController.chatData.value.result?.data?.length??0,
                    itemBuilder: (context, index) {
                      final isSeen = chatController.chatData.value.result?.data?[index].isSeen;
                      final displayIndex = chatController.chatData.value.result!.data!.length - 1 - index;
                      final message =chatController.chatData.value.result!.data![displayIndex];
                      return MessageWidget(
                        message: message.mediaType==null?
                        Text("${message.content}",
                          style: GoogleFonts.poppins(
                            color: Color(0xD1484848),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),):Image.network(message.media),
                        isUser1: message.isMessageByMe == true,
                        isSeen: message.isSeen ?? false?
                        Icon(Icons.done_all_rounded, color: Colors.blue, size: 12)
                            : Icon(Icons.done_all_rounded, color: Colors.grey, size: 12),
                        time: message.created ?? "",
                      );
                    },
                  )),
                ),

              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        height: Get.height*0.06,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap:(){
                messageController.getImage(ImageSource.gallery);
              },
              child: Container(
                width: Get.width*0.13,

                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: Color(0x23044D3A),

                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0x66044D3A)),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Center(child: SvgPicture.asset("assets/logos/chatgallary.svg"),),
              ),
            ),
            Stack(
              children: [
                Container(
                    width: Get.width*0.7,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.GREEN_SUBTEXT),
                        borderRadius: BorderRadius.circular(48)
                    ),
                    child: TextFormField(

                        controller: messageController.sendMessageController.value,
                        style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.41999998688697815),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          suffix: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.black,
                          ),
                          border: InputBorder.none,
                          hintText: "Write message",
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.41999998688697815),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 0.17,
                            letterSpacing: 0.15,
                          ),

                        )

                    )),
                Positioned(
                  left:Get.width*0.57,
                  top: 1,
                  right: 0,
                  child: InkWell(
                    onTap: (){
                      print("===========${chatController.chatController.value.text}");
                      messageController.sendmessage();
                      FocusScope.of(context).unfocus();

                    },
                    child: CircleAvatar(
                      radius: 23,
                      backgroundColor: AppColor.DARK_GREEN,
                      child: SvgPicture.asset("assets/logos/send.svg"),
                    ),
                  ),
                )
              ],
            )

          ],
        ),
      ),

    );
  }
}


class MessageWidget extends StatefulWidget {
  final Widget message;
  final bool isUser1;
  final Widget isSeen;
  final String time;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.isUser1,
    required this.isSeen,
    required this.time,
  }) : super(key: key);

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  final controller = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry messagePadding = EdgeInsets.symmetric(
      horizontal: 12.0,
      vertical: 15.0,
    );
    EdgeInsetsGeometry messageMargin = EdgeInsets.symmetric(
      horizontal: 10.0,
    );

    Color messageColor;
    CrossAxisAlignment messageAlignment;
    CrossAxisAlignment timeAlignment;

    if (widget.isUser1) {
      messageColor = Color(0xFFE2FED5);
      messageAlignment = CrossAxisAlignment.end;
      timeAlignment = CrossAxisAlignment.end;
    } else {
      messageColor = Color(0x0F044D3A);
      messageAlignment = CrossAxisAlignment.start;
      timeAlignment = CrossAxisAlignment.start;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: messageAlignment == CrossAxisAlignment.end
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: timeAlignment,
            children: [
              Container (
                padding: messagePadding,
                margin: messageMargin,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                decoration: BoxDecoration(
                  color: messageColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child:  widget.message,
              ),
              Container(
                margin: EdgeInsets.only(top: 2, bottom: 15, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    widget.isUser1 ? widget.isSeen : Container(),
                    Text(
                      '    ${widget.time}',
                      style: TextStyle(
                        color: Color(0x7F484848),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

