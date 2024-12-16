import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/view/recomended_land_info.dart';
import 'package:farm_easy/Screens/Threads/Controller/like_unlike_controller.dart';
import 'package:farm_easy/Screens/Threads/Controller/list_new_tags.dart';
import 'package:farm_easy/Screens/Threads/Controller/threads_controller.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/View/create_threads.dart';
import 'package:farm_easy/Screens/Threads/Replies/View/replies.dart';
import 'package:farm_easy/API/Services/network/status.dart';
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
  final tagsController = Get.put(ListNewTagsController());
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
          isbackButton: false,
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
                                  return GestureDetector(
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
                                        //controller.resetPageToFirst();
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
                              height: Get.height * 0.7,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  controller: _threadScroller,
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.threadDataList.length + 1,
                                  itemBuilder: (context, threads) {
                                    if (threads ==
                                        controller.threadDataList.length) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 25.0, top: 5),
                                          child: Text(
                                            'FarmEasy.ai',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.DARK_GREEN,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(() => Replies(
                                                    threadId: controller
                                                            .threadDataList[
                                                                threads]
                                                            .id
                                                            ?.toInt() ??
                                                        0,
                                                  ));
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
                                                              ? Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    color: AppColor
                                                                        .DARK_GREEN
                                                                        .withOpacity(
                                                                            0.2),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      controller
                                                                          .threadDataList[
                                                                              threads]
                                                                          .userName![
                                                                              0]
                                                                          .toUpperCase(),
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            20,
                                                                        color: AppColor
                                                                            .DARK_GREEN, // Text color contrasting the background
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                            "${controller.threadDataList[threads].userImage ?? ""}"),
                                                                        fit: BoxFit
                                                                            .cover),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    color: AppColor
                                                                        .DARK_GREEN
                                                                        .withOpacity(
                                                                            0.2),
                                                                  ),
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
                                                            '${controller.threadDataList[threads].createdOn ?? ""}  ',
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
                                                          GestureDetector(
                                                            onTapDown:
                                                                (TapDownDetails
                                                                    details) {
                                                              _showPopupMenu(
                                                                context,
                                                                threads,
                                                                controller
                                                                        .threadDataList[
                                                                            threads]
                                                                        .isPostedByMe ??
                                                                    true,
                                                                details,
                                                                controller
                                                                        .threadDataList[
                                                                            threads]
                                                                        .title ??
                                                                    "",
                                                                controller
                                                                    .threadDataList[
                                                                        threads]
                                                                    .id!
                                                                    .toInt(),
                                                              );
                                                            },
                                                            child: Icon(Icons
                                                                .more_vert_rounded),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 0),
                                                    child: Text(
                                                      '${controller.threadDataList[threads].title ?? ""}',
                                                      style: TextStyle(
                                                        color:
                                                            AppColor.BROWN_TEXT,
                                                        fontSize: 15,
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
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(() =>
                                                                            ImageViewPage(
                                                                              imageUrl: controller.threadDataList[threads].images?[img].image ?? "",
                                                                            ));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            bottom:
                                                                                10,
                                                                            right:
                                                                                8),
                                                                        height: Get.height *
                                                                            0.14,
                                                                        width: Get.width *
                                                                            0.3,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.black,
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            image: DecorationImage(image: NetworkImage(controller.threadDataList[threads].images?[img].image ?? ""), fit: BoxFit.cover)),
                                                                      ),
                                                                    );
                                                                  }),
                                                        )
                                                      : Container(),
                                                  controller
                                                              .threadDataList[
                                                                  threads]
                                                              .description !=
                                                          ""
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 15,
                                                                  left: 0,
                                                                  right: 0),
                                                          child: Text(
                                                            '${controller.threadDataList[threads].description ?? ""}',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: Color(
                                                                  0xFF61646B),
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(),
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
                                                            horizontal: 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width:
                                                              AppDimension.w *
                                                                  0.2,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  int currentIndex =
                                                                      threads;

                                                                  // Toggle the like status of the thread
                                                                  bool isLiked =
                                                                      controller
                                                                              .threadDataList[currentIndex]
                                                                              .isLiked ??
                                                                          false;
                                                                  controller
                                                                      .threadDataList[
                                                                          currentIndex]
                                                                      .isLiked = !isLiked;

                                                                  // Ensure totalLikes is not null and update accordingly
                                                                  int totalLikes =
                                                                      controller
                                                                              .threadDataList[currentIndex]
                                                                              .totalLikes ??
                                                                          0;

                                                                  if (!isLiked) {
                                                                    // Increment likes when the post is liked
                                                                    controller
                                                                        .threadDataList[
                                                                            currentIndex]
                                                                        .totalLikes = totalLikes + 1;
                                                                  } else {
                                                                    // Decrement likes when the post is unliked, ensuring it doesn't go below 0
                                                                    controller
                                                                        .threadDataList[
                                                                            currentIndex]
                                                                        .totalLikes = totalLikes >
                                                                            0
                                                                        ? totalLikes -
                                                                            1
                                                                        : 0;
                                                                  }
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

                                                                  // Use update() to notify GetX of changes
                                                                  controller
                                                                      .update();

                                                                  // Optionally call setState to trigger UI updates if necessary
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
                                                              GestureDetector(
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
                                                              // SvgPicture.asset(
                                                              //   "assets/more/send.svg",
                                                              //   width: 22,
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              AppDimension.w *
                                                                  0.25,
                                                          child:
                                                              GestureDetector(
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
                                                        (controller.threadDataList[threads]
                                                                        .totalLikes ??
                                                                    0) <=
                                                                1
                                                            ? '${controller.threadDataList[threads].totalLikes} Like   '
                                                            : '${controller.threadDataList[threads].totalLikes} Likes   ',
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
      floatingActionButton: GestureDetector(
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

  void _showPopupMenu(BuildContext context, int index, bool isDeleted,
      TapDownDetails details, String title, int id) async {
    final tapPosition = details.globalPosition;

    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition.dx,
        tapPosition.dy,
        tapPosition.dx + 1,
        tapPosition.dy + 1,
      ),
      items: [
        if (isDeleted)
          PopupMenuItem<String>(
            value: 'Delete',
            child: Text('Delete Post'),
          )
        else
          PopupMenuItem<String>(
            value: 'Report',
            child: Text('Report'),
          ),
      ],
    );

    if (result == 'Delete') {
      controller.showDeleteDialog(index, title, id);
    } else if (result == 'Report') {
      // Handle repost logic here
      print('Repost action triggered for index $index');
    }
  }
}
