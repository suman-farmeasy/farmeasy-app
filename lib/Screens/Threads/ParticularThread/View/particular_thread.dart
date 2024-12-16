import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Screens/Threads/Controller/like_unlike_controller.dart';
import 'package:farm_easy/Screens/Threads/ParticularThread/Controller/particular_thread_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ParticularThread extends StatefulWidget {
  ParticularThread({super.key, required this.threadId});
  int threadId;
  @override
  State<ParticularThread> createState() => _ParticularThreadState();
}

class _ParticularThreadState extends State<ParticularThread> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.threads(widget.threadId);
  }

  final isLikedController = Get.put(LikeUnlikeController());
  final controller = Get.put(ParticularThreadController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  controller.threadData.value.result
                                              ?.userImage ==
                                          ""
                                      ? SvgPicture.asset(
                                          "assets/img/Vector.svg",
                                          width: Get.width * 0.11,
                                        )
                                      : CircleAvatar(
                                          radius: 23,
                                          backgroundImage: NetworkImage(
                                              controller.threadData.value.result
                                                      ?.userImage ??
                                                  ""),
                                        ),
                                  Text(
                                    '   ${controller.threadData.value.result?.userName ?? ""}',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF61646B),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    controller.threadData.value.result
                                            ?.createdOn ??
                                        "",
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF61646B),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.more_vert_rounded,
                                      ))
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              controller.threadData.value.result?.title ?? "",
                              style: TextStyle(
                                color: AppColor.BROWN_TEXT,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          controller.threadData.value.result?.images?.length !=
                                  0
                              ? Container(
                                  height: Get.height * 0.14,
                                  child: ListView.builder(
                                      itemCount: controller.threadData.value
                                              .result?.images?.length ??
                                          0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, img) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              bottom: 10, right: 8),
                                          height: Get.height * 0.14,
                                          width: Get.width * 0.3,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(controller
                                                          .threadData
                                                          .value
                                                          .result
                                                          ?.images?[img]
                                                          .image ??
                                                      ""),
                                                  fit: BoxFit.cover)),
                                        );
                                      }),
                                )
                              : Container(),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 15, left: 10, right: 10),
                            child: Text(
                              controller.threadData.value.result?.description ??
                                  "",
                              style: GoogleFonts.poppins(
                                color: Color(0xFF61646B),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 5,
                            children: List.generate(
                                controller.threadData.value.result?.tags
                                        ?.length ??
                                    0, (tags) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Color(0x14167C0C),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  "${controller.threadData.value.result?.tags?[tags].name}",
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF044D3A),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            }),
                          ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(
                          //       vertical: 15, horizontal: 10),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       // Container(
                          //       //   width: AppDimension.w * 0.25,
                          //       //   child: Row(
                          //       //     mainAxisAlignment:
                          //       //         MainAxisAlignment.spaceBetween,
                          //       //     children: [
                          //       //       InkWell(
                          //       //         onTap: () {
                          //       //        //   int currentIndex = threads;
                          //       //           print(
                          //       //               "isLiked Status : ${controller.isLiked.value}");
                          //       //           // Toggle the like status of the thread
                          //       //           controller
                          //       //               .threadDataList[currentIndex]
                          //       //               .isLiked = !(controller
                          //       //                   .threadDataList[currentIndex]
                          //       //                   .isLiked ??
                          //       //               false);
                          //       //           // Update the like count based on the like status
                          //       //           if (controller
                          //       //                   .threadDataList[currentIndex]
                          //       //                   .isLiked ==
                          //       //               true) {
                          //       //             controller
                          //       //                 .threadDataList[currentIndex]
                          //       //                 .totalLikes++;
                          //       //           } else {
                          //       //             controller
                          //       //                 .threadDataList[currentIndex]
                          //       //                 .totalLikes--;
                          //       //           }
                          //       //           // Call the function to handle like/unlike functionality
                          //       //           isLikedController.threadId.value =
                          //       //               controller
                          //       //                   .threadDataList[currentIndex]
                          //       //                   .id!
                          //       //                   .toInt();
                          //       //           isLikedController.likeUnlikeFunc();
                          //       //           setState(() {});
                          //       //         },
                          //       //         child: controller
                          //       //                     .threadDataList[threads]
                          //       //                     .isLiked ??
                          //       //                 false
                          //       //             ? Icon(
                          //       //                 CupertinoIcons.heart_fill,
                          //       //                 color: Color(0xfffFF344A),
                          //       //                 size: 28,
                          //       //               )
                          //       //             : Icon(
                          //       //                 CupertinoIcons.heart,
                          //       //                 color: AppColor.BROWN_TEXT,
                          //       //                 size: 28,
                          //       //               ),
                          //       //       ),
                          //       //       InkWell(
                          //       //         onTap: () {
                          //       //           Get.to(() => Replies(
                          //       //                 threadId: controller
                          //       //                         .threadDataList[threads]
                          //       //                         .id
                          //       //                         ?.toInt() ??
                          //       //                     0,
                          //       //               ));
                          //       //         },
                          //       //         child: SvgPicture.asset(
                          //       //           "assets/more/chat.svg",
                          //       //           width: 22,
                          //       //         ),
                          //       //       ),
                          //       //       SvgPicture.asset(
                          //       //         "assets/more/send.svg",
                          //       //         width: 22,
                          //       //       ),
                          //       //     ],
                          //       //   ),
                          //       // ),
                          //       Container(
                          //         width: AppDimension.w * 0.25,
                          //         child: InkWell(
                          //           onTap: () {
                          //             Get.to(() => Replies(
                          //                   threadId: controller
                          //                           .threadDataList[threads].id
                          //                           ?.toInt() ??
                          //                       0,
                          //                 ));
                          //           },
                          //           child: Row(
                          //             children: [
                          //               SvgPicture.asset(
                          //                 "assets/more/reply.svg",
                          //                 width: 20,
                          //               ),
                          //               Text(
                          //                 '    Reply',
                          //                 style: GoogleFonts.poppins(
                          //                   color: AppColor.DARK_GREEN,
                          //                   fontSize: 14,
                          //                   fontWeight: FontWeight.w500,
                          //                 ),
                          //               )
                          //             ],
                          //           ),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       '    200 Views   ',
                          //       style: GoogleFonts.poppins(
                          //         color: Color(0xFF9A9A9A),
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.w400,
                          //       ),
                          //     ),
                          //     CircleAvatar(
                          //       radius: 2,
                          //       backgroundColor: Colors.grey,
                          //     ),
                          //     Text(
                          //       '   ${controller.threadDataList[threads].totalLikes} Likes   ',
                          //       style: GoogleFonts.poppins(
                          //         color: Color(0xFF9A9A9A),
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.w400,
                          //       ),
                          //     ),
                          //     CircleAvatar(
                          //       radius: 2,
                          //       backgroundColor: Colors.grey,
                          //     ),
                          //     Text(
                          //       '   ${controller.threadDataList[threads].totalReplies} Replies   ',
                          //       style: GoogleFonts.poppins(
                          //         color: Color(0xFF9A9A9A),
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.w400,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    Divider(
                      color: AppColor.GREY_BORDER,
                    )
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
