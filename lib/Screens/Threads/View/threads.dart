import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/Threads/Controller/like_unlike_controller.dart';
import 'package:farm_easy/Screens/Threads/Controller/threads_controller.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/Controller/list_tags_controller.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/View/create_threads.dart';
import 'package:farm_easy/Screens/Threads/Replies/View/replies.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Threads extends StatefulWidget {
  const Threads({super.key});

  @override
  State<Threads> createState() => _ThreadsState();
}

class _ThreadsState extends State<Threads> {
  final controller = Get.put(ThreadsController());
  final tagsController = Get.put(ListTagsController());
  final isLikedController = Get.put(LikeUnlikeController());
  final ScrollController _threadScroller = ScrollController();
  @override
  Widget build(BuildContext context) {
    _threadScroller.addListener(() {
      if (_threadScroller.position.pixels ==
          _threadScroller.position.maxScrollExtent) {
        controller.loadMoreData();
      }
    });
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.08),
        child: CommonAppBar(
          title: '  Community',
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return RefreshIndicator(
            onRefresh: () async {
              controller.refreshAllThread();
            },
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: AppDimension.h * 0.05,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: tagsController
                                      .tagsData.value.result?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return Obx(() {
                                  final isSelected = controller.tags.contains(
                                      tagsController
                                          .tagsData.value.result?[index].id);
                                  return InkWell(
                                    onTap: () {
                                      final id = tagsController.tagsData.value
                                              .result?[index].id ??
                                          0;

                                      if (id != 0) {
                                        if (isSelected) {
                                          controller.tags.remove(id.toInt());
                                        } else {
                                          controller.tags.add(id.toInt());
                                        }
                                        controller.resetPageToFirst();
                                        controller.threadList(clearList: true);
                                        print(
                                            "Selected Values: ${controller.tags.where((id) => id != 0).toList()}");
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: isSelected
                                              ? Color(0x14044D3A)
                                              : Color(0xFFFFFFF7),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color: isSelected
                                                  ? Color(0x70044D3A)
                                                  : AppColor.GREY_BORDER)),
                                      child: Center(
                                        child: Text(
                                            "#${tagsController.tagsData.value.result?[index].name ?? ""}",
                                            style: GoogleFonts.poppins(
                                              color: isSelected
                                                  ? Color(0xFF044D3A)
                                                  : Color(0xFF283037),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ),
                                    ),
                                  );
                                });
                              }),
                        );
                      }),
                      Obx(() {
                        if (controller.loading.value &&
                            controller.threadDataList.isEmpty) {
                          return Center(child: CircularProgressIndicator());
                        } else if (controller.rxRequestStatus.value ==
                            Status.ERROR) {
                          return Text('Error fetching data');
                        } else if (controller.threadDataList.isEmpty) {
                          return Center(child: Text('No data available'));
                        } else {
                          return RefreshIndicator(
                            onRefresh: () async {
                              controller.refreshAllThread();
                            },
                            child: Container(
                              height: Get.height * 0.72,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  controller: _threadScroller,
                                  shrinkWrap: true,
                                  itemCount: controller.threadDataList.length,
                                  itemBuilder: (context, threads) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // Get.to(() => ParticularThread(
                                              //     threadId: controller
                                              //             .threadDataList[
                                              //                 threads]
                                              //             .id ??
                                              //         0));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 8,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          controller
                                                                      .threadDataList[
                                                                          threads]
                                                                      .userImage ==
                                                                  ""
                                                              ? SvgPicture
                                                                  .asset(
                                                                  "assets/img/Vector.svg",
                                                                  width:
                                                                      Get.width *
                                                                          0.11,
                                                                )
                                                              : CircleAvatar(
                                                                  radius: 23,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          "${controller.threadDataList[threads].userImage ?? ""}"),
                                                                ),
                                                          Text(
                                                            '   ${controller.threadDataList[threads].userName ?? ""}',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: Color(
                                                                  0xFF61646B),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${controller.threadDataList[threads].createdOn ?? ""}',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: Color(
                                                                  0xFF61646B),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                Icons
                                                                    .more_vert_rounded,
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    child: Text(
                                                      '${controller.threadDataList[threads].title ?? ""}',
                                                      style: TextStyle(
                                                        color:
                                                            AppColor.BROWN_TEXT,
                                                        fontSize: 14,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ),
                                                  controller
                                                              .threadDataList[
                                                                  threads]
                                                              .images
                                                              ?.length !=
                                                          0
                                                      ? Container(
                                                          height:
                                                              Get.height * 0.14,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: controller
                                                                          .threadDataList[
                                                                              threads]
                                                                          .images
                                                                          ?.length ??
                                                                      0,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          img) {
                                                                    return Container(
                                                                      margin: EdgeInsets.only(
                                                                          bottom:
                                                                              10,
                                                                          right:
                                                                              8),
                                                                      height: Get
                                                                              .height *
                                                                          0.14,
                                                                      width: Get
                                                                              .width *
                                                                          0.3,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .black,
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          image: DecorationImage(
                                                                              image: NetworkImage(controller.threadDataList[threads].images?[img].image ?? ""),
                                                                              fit: BoxFit.cover)),
                                                                    );
                                                                  }),
                                                        )
                                                      : Container(),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 15,
                                                        left: 10,
                                                        right: 10),
                                                    child: Text(
                                                      '${controller.threadDataList[threads].description ?? ""}',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            Color(0xFF61646B),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ),
                                                  Wrap(
                                                    spacing: 8,
                                                    runSpacing: 5,
                                                    children: List.generate(
                                                        controller
                                                                .threadDataList[
                                                                    threads]
                                                                .tags
                                                                ?.length ??
                                                            0, (tags) {
                                                      return Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 8,
                                                                horizontal: 20),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0x14167C0C),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        child: Text(
                                                          "${controller.threadDataList[threads].tags?[tags].name}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Color(
                                                                0xFF044D3A),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15,
                                                            horizontal: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width:
                                                              AppDimension.w *
                                                                  0.25,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  int currentIndex =
                                                                      threads;
                                                                  print(
                                                                      "isLiked Status : ${controller.isLiked.value}");
                                                                  // Toggle the like status of the thread
                                                                  controller
                                                                      .threadDataList[
                                                                          currentIndex]
                                                                      .isLiked = !(controller
                                                                          .threadDataList[
                                                                              currentIndex]
                                                                          .isLiked ??
                                                                      false);
                                                                  // Update the like count based on the like status
                                                                  if (controller
                                                                          .threadDataList[
                                                                              currentIndex]
                                                                          .isLiked ==
                                                                      true) {
                                                                    controller
                                                                        .threadDataList[
                                                                            currentIndex]
                                                                        .totalLikes++;
                                                                  } else {
                                                                    controller
                                                                        .threadDataList[
                                                                            currentIndex]
                                                                        .totalLikes--;
                                                                  }
                                                                  // Call the function to handle like/unlike functionality
                                                                  isLikedController
                                                                          .threadId
                                                                          .value =
                                                                      controller
                                                                          .threadDataList[
                                                                              currentIndex]
                                                                          .id!
                                                                          .toInt();
                                                                  isLikedController
                                                                      .likeUnlikeFunc();
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: controller
                                                                            .threadDataList[threads]
                                                                            .isLiked ??
                                                                        false
                                                                    ? Icon(
                                                                        CupertinoIcons
                                                                            .heart_fill,
                                                                        color: Color(
                                                                            0xfffFF344A),
                                                                        size:
                                                                            28,
                                                                      )
                                                                    : Icon(
                                                                        CupertinoIcons
                                                                            .heart,
                                                                        color: AppColor
                                                                            .BROWN_TEXT,
                                                                        size:
                                                                            28,
                                                                      ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Get.to(() =>
                                                                      Replies(
                                                                        threadId:
                                                                            controller.threadDataList[threads].id?.toInt() ??
                                                                                0,
                                                                      ));
                                                                },
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  "assets/more/chat.svg",
                                                                  width: 22,
                                                                ),
                                                              ),
                                                              SvgPicture.asset(
                                                                "assets/more/send.svg",
                                                                width: 22,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              AppDimension.w *
                                                                  0.25,
                                                          child: InkWell(
                                                            onTap: () {
                                                              Get.to(
                                                                  () => Replies(
                                                                        threadId:
                                                                            controller.threadDataList[threads].id?.toInt() ??
                                                                                0,
                                                                      ));
                                                            },
                                                            child: Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  "assets/more/reply.svg",
                                                                  width: 20,
                                                                ),
                                                                Text(
                                                                  '    Reply',
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: AppColor
                                                                        .DARK_GREEN,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        '    200 Views   ',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF9A9A9A),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      CircleAvatar(
                                                        radius: 2,
                                                        backgroundColor:
                                                            Colors.grey,
                                                      ),
                                                      Text(
                                                        '   ${controller.threadDataList[threads].totalLikes} Likes   ',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF9A9A9A),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      CircleAvatar(
                                                        radius: 2,
                                                        backgroundColor:
                                                            Colors.grey,
                                                      ),
                                                      Text(
                                                        '   ${controller.threadDataList[threads].totalReplies} Replies   ',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF9A9A9A),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: AppColor.GREY_BORDER,
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                )));
      }),
      floatingActionButton: InkWell(
        onTap: () {
          Get.to(() => CreateThreads());
        },
        child: Container(
          width: Get.width * 0.2,
          child: SvgPicture.asset("assets/logos/thread.svg"),
        ),
      ),
    );
  }
}
