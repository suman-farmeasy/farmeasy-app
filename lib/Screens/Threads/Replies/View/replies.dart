import 'package:farm_easy/Utils/Constants/color_constants.dart';
import 'package:farm_easy/Screens/Threads/Controller/reply_controller.dart';
import 'package:farm_easy/Screens/Threads/Replies/Controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class Replies extends StatefulWidget {
  Replies({Key? key, required this.threadId}) : super(key: key);
  int threadId;
  @override
  _RepliesState createState() => _RepliesState();
}

class _RepliesState extends State<Replies> {
  final controller = Get.put(RespliesController());
  final replyController = Get.put(ReplyController());
  @override
  Widget build(BuildContext context) {
    controller.threadId.value = widget.threadId;
    replyController.threadId.value = widget.threadId;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          controller.opacity.value;
        });
      },
      child: Scaffold(
        backgroundColor:
            AppColor.BACKGROUND.withOpacity(controller.opacity.value),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.09),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColor.DARK_GREEN,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 10, right: 30, bottom: 0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 17,
                      )),
                  Text(
                    '                      Replies',
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
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              height: Get.height * 0.76,
              child: Obx(() {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        controller.repliesData.value.result?.data?.length ?? 0,
                    controller: controller.scrollController,
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final displayIndex =
                          controller.repliesData.value.result!.data!.length -
                              index -
                              1;
                      final replies = controller
                          .repliesData.value.result!.data![displayIndex];
                      return ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(replies.userImage ?? ""),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        title: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${replies.userName ?? ""} ',
                                style: TextStyle(
                                  color: Color(0xFF484848),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: '${replies.reply ?? ""}',
                                style: TextStyle(
                                  color: Color(0xFF484848),
                                  fontSize: 11,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text(
                          "${replies.createdOn ?? ""}",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color(0xBC484848),
                          ),
                        ),
                      );
                    });
              }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: Get.width,
                height: Get.height * 0.1,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                decoration: BoxDecoration(
                  color: AppColor.BACKGROUND,
                  border: Border(
                    top: BorderSide(width: 1, color: Color(0xFFE3E3E3)),
                  ),
                ),
                child: Row(
                  children: [
                    Obx(() {
                      return controller.getProfileController.getProfileData
                                  .value.result?.image ==
                              ""
                          ? SvgPicture.asset(
                              "assets/img/Vector.svg",
                              width: Get.width * 0.11,
                            )
                          : CircleAvatar(
                              radius: 23,
                              backgroundImage: NetworkImage(
                                  "${controller.getProfileController.getProfileData.value.result?.image}"),
                            );
                    }),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Container(
                            decoration: ShapeDecoration(
                              color: AppColor.BACKGROUND,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0x66044D3A)),
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, bottom: 2),
                              child: TextField(
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                                      .withOpacity(0.41999998688697815),
                                ),
                                controller:
                                    replyController.replyController.value,
                                autocorrect: true,
                                cursorColor: Colors.grey,
                                maxLines: null,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: 5,
                                    right: 30,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      replyController.replyThread();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(13),
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF044D3A),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Reply...",
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                        .withOpacity(0.41999998688697815),
                                  ),
                                ),
                                onTap: () {
                                  controller.opacity.value;
                                },
                                onSubmitted: (value) {
                                  controller.opacity.value;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
