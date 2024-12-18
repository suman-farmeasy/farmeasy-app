import 'package:farm_easy/utils/localization/localization_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/Constants/color_constants.dart';
import '../../../utils/Constants/image_constant.dart';
import '../../ChatGpt/View/chat_gpt_start_Screen.dart';
import '../../ChatSection/view/chat_ui.dart';
import '../../LandSection/LandDetails/View/land_details.dart';
import '../../LandSection/MyLands/View/home_screen_land.dart';
import '../../UserProfile/View/profile_view.dart';
import '../Controller/home_controller.dart';
import '../Controller/matching_farmer.dart';

class LandOwnerBodyWidget extends StatelessWidget {
  LandOwnerBodyWidget({
    super.key,
    required this.homecontroller,
  });

  final HomeController homecontroller;
  final localeController = Get.put(LocaleController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: homecontroller.prefs.getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data == "Land Owner") {
            return Obx(() {
              return homecontroller
                          .landData.value.result?.pageInfo?.totalObject !=
                      0
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Lands'.tr,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF483C32),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const HomeScreenLand());
                                // dashboardController.selectedIndex.value = 3;
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'View all'.tr,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF044D3A),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '(${homecontroller.landData.value.result?.pageInfo?.totalObject?.toInt() ?? "No land added".tr}) >',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF044D3A),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Obx(() {
                          return homecontroller.loading.value
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: homecontroller.landData.value
                                          .result?.data?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    int landId = homecontroller
                                        .landData.value.result!.data![index].id!
                                        .toInt();
                                    final matchingfarmerController = Get.put(
                                        HomeScreenMatchingFarmerController(
                                            landId),
                                        tag: landId.toString());

                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(() => LandDetails(
                                            id: homecontroller.landData.value
                                                .result!.data![index].id!
                                                .toInt()));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width: double.infinity,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFFFFF7),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          shadows: const [
                                            BoxShadow(
                                              color: Color(0x19000000),
                                              blurRadius: 24,
                                              offset: Offset(0, 2),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        homecontroller
                                                                .landData
                                                                .value
                                                                .result
                                                                ?.data?[index]
                                                                .landTitle ??
                                                            "",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColor
                                                                    .BROWN_TEXT,
                                                                fontSize: 14),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          "${homecontroller.landData.value.result?.data?[index].city ?? ""} ${homecontroller.landData.value.result?.data?[index].state ?? ""} ${homecontroller.landData.value.result?.data?[index].country ?? ""}",
                                                          style: GoogleFonts.poppins(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: const Color(
                                                                  0xFF61646B)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${homecontroller.landData.value.result?.data?[index].weatherDetails?.temperature?.toInt() ?? ""}º",
                                                            style: GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColor
                                                                    .BROWN_TEXT,
                                                                fontSize: 15),
                                                          ),
                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        "http://openweathermap.org/img/wn/${homecontroller.landData.value.result?.data?[index].weatherDetails?.imgIcon}.png"),
                                                                    fit: BoxFit
                                                                        .fill)),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.25,
                                                            child: Text(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              homecontroller
                                                                      .landData
                                                                      .value
                                                                      .result
                                                                      ?.data?[
                                                                          index]
                                                                      .weatherDetails
                                                                      ?.description ??
                                                                  "",
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColor
                                                                      .BROWN_TEXT,
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        "Min: ${homecontroller.landData.value.result?.data?[index].weatherDetails?.minTemp?.toInt() ?? ""}º / Max: ${homecontroller.landData.value.result?.data?[index].weatherDetails?.maxTemp?.toInt() ?? ""}º",
                                                        style: GoogleFonts.poppins(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: const Color(
                                                                0xFF61646B),
                                                            fontSize: 10),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: List.generate(
                                                  450 ~/ 4,
                                                  (index) => Expanded(
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 12),
                                                          color: index % 2 == 0
                                                              ? Colors
                                                                  .transparent
                                                              : AppColor
                                                                  .GREY_BORDER,
                                                          height: 1,
                                                        ),
                                                      )),
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Container(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Matching farmers for this land"
                                                          .tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColor
                                                                  .BROWN_TEXT),
                                                    ),
                                                    Obx(() => matchingfarmerController
                                                                .matchingFarmerData
                                                                .value
                                                                .result
                                                                ?.matchingFarmerList
                                                                ?.length !=
                                                            0
                                                        ? MyLandsWidget(
                                                            matchingfarmerController:
                                                                matchingfarmerController,
                                                            homecontroller:
                                                                homecontroller)
                                                        : Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  child: Lottie.asset(
                                                                      "assets/lotties/animation.json",
                                                                      height:
                                                                          100,
                                                                      width: double
                                                                          .infinity),
                                                                )
                                                              ],
                                                            ),
                                                          ))
                                                  ],
                                                ))),
                                            const Divider(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      ImageConstants.ENQUIRIES,
                                                      height: 30,
                                                    ),
                                                    Text(
                                                      'Enquiries'.tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0.15,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Partners'.tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0.15,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    CircleAvatar(
                                                      radius: 16,
                                                      backgroundColor:
                                                          AppColor.DARK_GREEN,
                                                      child: Center(
                                                        child: Text(
                                                          '${homecontroller.landData.value.result?.data?[index].totalAgriServiceProvider ?? "0"}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0.10,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        const ChatGptStartScreen());
                                                  },
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        ImageConstants.CHATGPT,
                                                        width: 30,
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                      ),
                                                      Text(
                                                        ' AI assistant',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .DARK_GREEN,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                        }),
                      ],
                    )
                  : Container();
            });
          } else {
            return Container(); // Return an empty container if user role is not "Land Owner"
          }
        } else {
          return const CircularProgressIndicator(); // Return a loading indicator while fetching user role
        }
      },
    );
  }
}

class MyLandsWidget extends StatelessWidget {
  const MyLandsWidget({
    super.key,
    required this.matchingfarmerController,
    required this.homecontroller,
  });

  final HomeScreenMatchingFarmerController matchingfarmerController;
  final HomeController homecontroller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      height: Get.height * 0.14,
      child: ListView.builder(
          itemCount: matchingfarmerController.matchingFarmerData.value.result
                  ?.matchingFarmerList?.length ??
              0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => UserProfileScreen(
                    id: matchingfarmerController.matchingFarmerData.value.result
                            ?.matchingFarmerList?[index].userId!
                            .toInt() ??
                        0,
                    userType: matchingfarmerController.matchingFarmerData.value
                            .result?.matchingFarmerList?[index].userType ??
                        ""));
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColor.GREY_BORDER),
                  boxShadow: [AppColor.BOX_SHADOW],
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => UserProfileScreen(
                            id: matchingfarmerController
                                    .matchingFarmerData
                                    .value
                                    .result
                                    ?.matchingFarmerList?[index]
                                    .userId!
                                    .toInt() ??
                                0,
                            userType: matchingfarmerController
                                    .matchingFarmerData
                                    .value
                                    .result
                                    ?.matchingFarmerList?[index]
                                    .userType ??
                                ""));
                      },
                      child: Container(
                        width: Get.width * 0.25,
                        height: Get.height * 0.16,
                        decoration: BoxDecoration(
                          color: AppColor.DARK_GREEN.withOpacity(0.1),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            topLeft: Radius.circular(18),
                          ),
                          image: matchingfarmerController
                                          .matchingFarmerData
                                          .value
                                          .result
                                          ?.matchingFarmerList?[index]
                                          .image !=
                                      null &&
                                  matchingfarmerController
                                          .matchingFarmerData
                                          .value
                                          .result
                                          ?.matchingFarmerList?[index]
                                          .image !=
                                      ""
                              ? DecorationImage(
                                  image: NetworkImage(
                                    matchingfarmerController
                                            .matchingFarmerData
                                            .value
                                            .result
                                            ?.matchingFarmerList?[index]
                                            .image! ??
                                        "",
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: matchingfarmerController
                                        .matchingFarmerData
                                        .value
                                        .result
                                        ?.matchingFarmerList?[index]
                                        .image ==
                                    null ||
                                matchingfarmerController
                                        .matchingFarmerData
                                        .value
                                        .result
                                        ?.matchingFarmerList?[index]
                                        .image ==
                                    ""
                            ? Center(
                                child: Text(
                                  matchingfarmerController
                                          .matchingFarmerData
                                          .value
                                          .result
                                          ?.matchingFarmerList?[index]
                                          .fullName![0]
                                          .toUpperCase() ??
                                      "",
                                  style: GoogleFonts.poppins(
                                    fontSize: 50,
                                    color: AppColor.DARK_GREEN,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              matchingfarmerController
                                      .matchingFarmerData
                                      .value
                                      .result
                                      ?.matchingFarmerList?[index]
                                      .fullName ??
                                  "",
                              style: GoogleFonts.poppins(
                                color: AppColor.BROWN_TEXT,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/farm/locationbrown.svg",
                                  width: 14,
                                ),
                                SizedBox(
                                  width: Get.width * 0.44,
                                  child: Text(
                                    '  ${matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].livesIn ?? ""}',
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF61646B),
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/farm/brownPort.svg",
                                  width: 14,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  height: 20,
                                  width: Get.width * 0.4,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: matchingfarmerController
                                              .matchingFarmerData
                                              .value
                                              .result!
                                              .matchingFarmerList?[index]
                                              .expertise!
                                              .length ??
                                          0,
                                      itemBuilder: (context, experties) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: const Color(0x14167C0C)),
                                          child: Center(
                                            child: Text(
                                              matchingfarmerController
                                                      .matchingFarmerData
                                                      .value
                                                      .result!
                                                      .matchingFarmerList?[
                                                          index]
                                                      .expertise![experties]
                                                      .name ??
                                                  "",
                                              style: GoogleFonts.poppins(
                                                color: AppColor.DARK_GREEN,
                                                fontSize: 8,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.05,
                                    vertical: Get.height * 0.005,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: AppColor.DARK_GREEN, width: 1),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.call,
                                        color: AppColor.DARK_GREEN,
                                        size: 15,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Contact Farmer'.tr,
                                        style: const TextStyle(
                                          color: Color(0xFF044D3A),
                                          fontSize: 9,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 0.16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
