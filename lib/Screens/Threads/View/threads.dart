import 'dart:developer';

import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/localization/translated_text_box.dart';
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
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../CreateThreads/Controller/fetch_news.dart';
import '../Model/demoNewsdata.dart';
import '../Widgets/show_complete_news.dart';

class Threads extends StatefulWidget {
  const Threads({super.key});

  @override
  State<Threads> createState() => _ThreadsState();
}

class _ThreadsState extends State<Threads> {
  final controller = Get.put(ThreadsController());
  final tagsController = Get.put(ListNewTagsController());
  final isLikedController = Get.put(LikeUnlikeController());
  final NewsController newsController = Get.put(NewsController());

  final ScrollController _threadScroller = ScrollController();
  var db = Hive.box('appData');
  var selectedLang;
  int _selectedIndex = 0;
  final _pageController = PageController();
  final SwipeableCardSectionController _cardController =
      SwipeableCardSectionController();

  void _onToggle(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    transLateAppFunction();
    setState(() {
      _selectedIndex = 0;
    });
  }

  void transLateAppFunction() {
    db.get('selectedLanguage') == null
        ? selectedLang = 'en'
        : db.get('selectedLanguage') == 'Hindi'
            ? selectedLang = 'hi'
            : db.get('selectedLanguage') == 'English'
                ? selectedLang = 'en'
                : db.get('selectedLanguage') == 'Punjabi'
                    ? selectedLang = 'pa'
                    : selectedLang = 'en';
  }

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
          title: _selectedIndex == 0 ? 'Community'.tr : 'News'.tr,
          postButton: _selectedIndex == 0 ? true : false,
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          threads(),
          agriNews(),
        ],
      ),
      floatingActionButton: toggleSwitch(),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     ToggleSwitch(),
      //     GestureDetector(
      //       onTap: () {
      //         Get.to(() => const CreateThreads());
      //       },
      //       child: SizedBox(
      //         width: Get.width * 0.2,
      //         child: SvgPicture.asset("assets/logos/thread.svg"),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Obx agriNews() {
    return Obx(() {
      if (newsController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (newsController.newsList.isEmpty) {
        return const Center(child: Text("No news available"));
      }
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SwipeableCardsSection(
              cardHeightBottomMul: 0.7,
              cardHeightMiddleMul: 0.7,
              cardController: _cardController,
              context: context,
              items: newsController.newsList.asMap().entries.map((entry) {
                AgricultureNews newsData = entry.value;
                return AgriNewsCard(newsData: newsData, index: entry.key);
              }).toList(),
              onCardSwiped: (dir, index, widget) {
                _cardController.addItem(AgriNewsCard(
                    newsData: newsController
                        .newsList[index % newsController.newsList.length],
                    index: index));
              },
              // items: news.asMap().entries.map((entry) {
              //   AgricultureNews newsData = entry.value;
              //   return AgriNewsCard(newsData: newsData, index: entry.key);
              // }).toList(),
              // onCardSwiped: (dir, index, widget) {
              //   _cardController.addItem(
              //       AgriNewsCard(newsData: news[index % news.length], index: index));
              // },
              enableSwipeUp: true,
              enableSwipeDown: false,
            ),
          ]);
    });
  }

  LayoutBuilder threads() {
    return LayoutBuilder(builder: (context, constraints) {
      return RefreshIndicator(
          onRefresh: () async {
            controller.refreshAllThread();
          },
          child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: AppDimension.h * 0.05,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                tagsController.tagsData.value.result?.length ??
                                    0,
                            itemBuilder: (context, index) {
                              return Obx(() {
                                final isSelected = controller.tags.contains(
                                    tagsController
                                        .tagsData.value.result?[index].id);
                                return GestureDetector(
                                  onTap: () {
                                    final id = tagsController
                                            .tagsData.value.result?[index].id ??
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0x14044D3A)
                                            : const Color(0xFFFFFFF7),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color: isSelected
                                                ? const Color(0x70044D3A)
                                                : AppColor.GREY_BORDER)),
                                    child: Center(
                                      child: Text(
                                          "#${tagsController.tagsData.value.result?[index].name ?? ""}",
                                          style: GoogleFonts.poppins(
                                            color: isSelected
                                                ? const Color(0xFF044D3A)
                                                : const Color(0xFF283037),
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
                        return const Center(child: CircularProgressIndicator());
                      } else if (controller.rxRequestStatus.value ==
                          Status.ERROR) {
                        return const Text('Error fetching data');
                      } else if (controller.threadDataList.isEmpty) {
                        return const Center(child: Text('No data available'));
                      } else {
                        return RefreshIndicator(
                          onRefresh: () async {
                            controller.refreshAllThread();
                          },
                          child: SizedBox(
                            height: Get.height * 0.7,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                controller: _threadScroller,
                                shrinkWrap: true,
                                itemCount: controller.threadDataList.length + 1,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
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
                                            margin: const EdgeInsets.symmetric(
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
                                                                          .circular(
                                                                              8),
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
                                                                          FontWeight
                                                                              .w500,
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
                                                                          controller.threadDataList[threads].userImage ??
                                                                              ""),
                                                                      fit: BoxFit
                                                                          .cover),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
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
                                                            color: const Color(
                                                                0xFF61646B),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
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
                                                            color: const Color(
                                                                0xFF61646B),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
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
                                                          child: const Icon(Icons
                                                              .more_vert_rounded),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 0),
                                                  child: TranslateTextBox(
                                                    text: controller
                                                            .threadDataList[
                                                                threads]
                                                            .title ??
                                                        "",
                                                    toLanguage: selectedLang,
                                                    style: const TextStyle(
                                                      color:
                                                          AppColor.BROWN_TEXT,
                                                      fontSize: 15,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  // Text(
                                                  //   controller
                                                  //           .threadDataList[
                                                  //               threads]
                                                  //           .title ??
                                                  //       "",
                                                  //   style: const TextStyle(
                                                  //     color:
                                                  //         AppColor.BROWN_TEXT,
                                                  //     fontSize: 15,
                                                  //     fontFamily: 'Poppins',
                                                  //     fontWeight:
                                                  //         FontWeight.w500,
                                                  //     height: 0,
                                                  //   ),
                                                  // ),
                                                ),
                                                // ignore: prefer_is_empty
                                                controller
                                                            .threadDataList[
                                                                threads]
                                                            .images
                                                            ?.length !=
                                                        0
                                                    ? SizedBox(
                                                        height:
                                                            Get.height * 0.14,
                                                        child: ListView.builder(
                                                            itemCount: controller
                                                                    .threadDataList[
                                                                        threads]
                                                                    .images
                                                                    ?.length ??
                                                                0,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemBuilder:
                                                                (context, img) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  Get.to(() =>
                                                                      ImageViewPage(
                                                                        imageUrl:
                                                                            controller.threadDataList[threads].images?[img].image ??
                                                                                "",
                                                                      ));
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              10,
                                                                          right:
                                                                              8),
                                                                  height:
                                                                      Get.height *
                                                                          0.14,
                                                                  width:
                                                                      Get.width *
                                                                          0.3,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(controller.threadDataList[threads].images?[img].image ??
                                                                              ""),
                                                                          fit: BoxFit
                                                                              .cover)),
                                                                ),
                                                              );
                                                            }),
                                                      )
                                                    : Container(),
                                                controller
                                                        .threadDataList[threads]
                                                        .description!
                                                        .contains(
                                                            'Https://youtu')
                                                    ? AspectRatio(
                                                        aspectRatio: 16 / 9,
                                                        child: WebView(
                                                          initialUrl: controller
                                                              .threadDataList[
                                                                  threads]
                                                              .description!
                                                              .replaceFirst(
                                                                  "Https://",
                                                                  "https://"),
                                                          javascriptMode:
                                                              JavascriptMode
                                                                  .unrestricted,
                                                        ),
                                                      )
                                                    : controller
                                                                .threadDataList[
                                                                    threads]
                                                                .description !=
                                                            ""
                                                        ? Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10,
                                                                    bottom: 15,
                                                                    left: 0,
                                                                    right: 0),
                                                            child: Text(
                                                              controller
                                                                      .threadDataList[
                                                                          threads]
                                                                      .description ??
                                                                  "",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: const Color(
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
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8,
                                                          horizontal: 20),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0x14167C0C),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Text(
                                                        "${controller.threadDataList[threads].tags?[tags].name}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: const Color(
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
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 15,
                                                      horizontal: 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: AppDimension.w *
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
                                                                bool isLiked = controller
                                                                        .threadDataList[
                                                                            currentIndex]
                                                                        .isLiked ??
                                                                    false;
                                                                controller
                                                                    .threadDataList[
                                                                        currentIndex]
                                                                    .isLiked = !isLiked;

                                                                // Ensure totalLikes is not null and update accordingly
                                                                int totalLikes = controller
                                                                        .threadDataList[
                                                                            currentIndex]
                                                                        .totalLikes ??
                                                                    0;

                                                                if (!isLiked) {
                                                                  // Increment likes when the post is liked
                                                                  controller
                                                                          .threadDataList[
                                                                              currentIndex]
                                                                          .totalLikes =
                                                                      totalLikes +
                                                                          1;
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
                                                                setState(() {});
                                                              },
                                                              child: controller
                                                                          .threadDataList[
                                                                              threads]
                                                                          .isLiked ??
                                                                      false
                                                                  ? const Icon(
                                                                      CupertinoIcons
                                                                          .heart_fill,
                                                                      color: Color(
                                                                          0xfffff344a),
                                                                      size: 28,
                                                                    )
                                                                  : const Icon(
                                                                      CupertinoIcons
                                                                          .heart,
                                                                      color: AppColor
                                                                          .BROWN_TEXT,
                                                                      size: 28,
                                                                    ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Get.to(
                                                                    () =>
                                                                        Replies(
                                                                          threadId:
                                                                              controller.threadDataList[threads].id?.toInt() ?? 0,
                                                                        ));
                                                              },
                                                              child: SvgPicture
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
                                                      SizedBox(
                                                        width: AppDimension.w *
                                                            0.25,
                                                        child: GestureDetector(
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
                                                              SvgPicture.asset(
                                                                "assets/more/reply.svg",
                                                                width: 20,
                                                              ),
                                                              Text(
                                                                '    Reply',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: AppColor
                                                                      .DARK_GREEN,
                                                                  fontSize: 14,
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
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      (controller
                                                                      .threadDataList[
                                                                          threads]
                                                                      .totalLikes ??
                                                                  0) <=
                                                              1
                                                          ? '${controller.threadDataList[threads].totalLikes} Like   '
                                                          : '${controller.threadDataList[threads].totalLikes} Likes   ',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF9A9A9A),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    const CircleAvatar(
                                                      radius: 2,
                                                      backgroundColor:
                                                          Colors.grey,
                                                    ),
                                                    Text(
                                                      '   ${controller.threadDataList[threads].totalReplies} Replies   ',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF9A9A9A),
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
                                        const Divider(
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
    });
  }

  Align toggleSwitch() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(left: Get.width * 0.07, top: Get.height * 0.15),
        height: Get.height * 0.06,
        width: Get.width * 0.65,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xFF044D3A),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(),
            GestureDetector(
              onTap: () => _onToggle(0),
              child: AnimatedContainer(
                width: MediaQuery.of(context).size.width * 0.3,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: _selectedIndex != 0
                      ? const Color(0xFF044D3A)
                      : const Color(0xFFFFFFF0),
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Community',
                  style: TextStyle(
                    color: _selectedIndex != 0
                        ? const Color(0xFFFFFFF0)
                        : const Color(0xFF044D3A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onToggle(1),
              child: AnimatedContainer(
                width: MediaQuery.of(context).size.width * 0.3,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: _selectedIndex != 1
                      ? const Color(0xFF044D3A)
                      : const Color(0xFFFFFFF0),
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.center,
                child: Text(
                  'News',
                  style: TextStyle(
                    color: _selectedIndex != 1
                        ? const Color(0xFFFFFFF0)
                        : const Color(0xFF044D3A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
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
          const PopupMenuItem<String>(
            value: 'Delete',
            child: Text('Delete Post'),
          )
        else
          const PopupMenuItem<String>(
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

class AgriNewsCard extends StatelessWidget {
  AgriNewsCard({
    super.key,
    required this.newsData,
    required this.index,
  });

  final AgricultureNews newsData;
  int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showFullPageDialog(context, newsData, index),
      child: Container(
        margin: EdgeInsets.only(bottom: Get.height * 0.05),
        height: Get.height * 0.5,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: const Color.fromARGB(63, 0, 0, 0)),
          color: const Color(0xFFF9F9DF),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: double.infinity,
                    height: Get.height * 0.25,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        newsData.image_url,
                      ),
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.DARK_GREEN,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(6.0),
                    child: Text('By : ${newsData.source_id}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(newsData.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(newsData.description,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
