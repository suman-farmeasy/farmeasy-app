import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/LandSection/MatchingFarmer/Controller/matching_farmer_controller.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchingFarmer extends StatefulWidget {
  MatchingFarmer({super.key, required this.id});
  int id;

  @override
  State<MatchingFarmer> createState() => _MatchingFarmerState();
}

class _MatchingFarmerState extends State<MatchingFarmer> {
  final farmerController = Get.put(MatchingFarmerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppDimension.h * 0.08),
          child: CommonAppBar(
            isbackButton: true,
            title: "Matching Farmers(#${widget.id})",
          ),
        ),
        body: SingleChildScrollView(
          child: RefreshIndicator(
              color: AppColor.DARK_GREEN,
              onRefresh: () async {
                await farmerController.matchingFarmer(100);
              },
              child: Obx(() {
                return farmerController.farmerLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 15),
                                              margin: const EdgeInsets.only(
                                                  bottom: 20),
                                              decoration: const BoxDecoration(
                                                  color: AppColor.DARK_GREEN,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                    topRight:
                                                        Radius.circular(12),
                                                  )),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Distance Filter",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: const CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(
                                                        Icons.close,
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Distance",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColor
                                                            .BROWN_TEXT),
                                                  ),
                                                  Obx(() => Text(
                                                        "${farmerController.currentDistance.value} km",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColor
                                                                    .BROWN_TEXT),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Obx(
                                              () => Slider(
                                                value: farmerController
                                                    .currentDistance.value
                                                    .toDouble(),
                                                min: 100,
                                                max: 1000,
                                                divisions: (1000 - 100) ~/
                                                    50, // Calculate divisions
                                                label:
                                                    "${farmerController.currentDistance.value} km",
                                                onChanged: (value) {
                                                  farmerController
                                                      .updateDistance(value);
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            GestureDetector(
                                              onTap: () {
                                                farmerController.matchingFarmer(
                                                    farmerController
                                                        .currentDistance.value);

                                                setState(() {
                                                  Get.back();
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                ),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                decoration: ShapeDecoration(
                                                  color: AppColor.DARK_GREEN,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Apply Filter ',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ));
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/img/filter.svg"),
                                      Text(
                                        "  Distance Filter",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.BROWN_TEXT,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${farmerController.currentDistance.value.toString()} Km",
                                    style: GoogleFonts.poppins(
                                      color: AppColor.DARK_GREEN,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 0,
                            ),
                            height: AppDimension.h * 0.83,
                            child: ListView.builder(
                                itemCount: farmerController
                                        .matchingFarmerData
                                        .value
                                        .result
                                        ?.matchingFarmerList
                                        ?.length ??
                                    0,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => UserProfileScreen(
                                          id: farmerController
                                                  .matchingFarmerData
                                                  .value
                                                  .result
                                                  ?.matchingFarmerList?[index]
                                                  .userId
                                                  ?.toInt() ??
                                              0,
                                          userType: farmerController
                                                  .matchingFarmerData
                                                  .value
                                                  .result
                                                  ?.matchingFarmerList?[index]
                                                  .userType ??
                                              ""));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColor.GREY_BORDER),
                                        boxShadow: [AppColor.BOX_SHADOW],
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => UserProfileScreen(
                                                  id: farmerController
                                                          .matchingFarmerData
                                                          .value
                                                          .result
                                                          ?.matchingFarmerList?[
                                                              index]
                                                          .userId
                                                          ?.toInt() ??
                                                      0,
                                                  userType: farmerController
                                                          .matchingFarmerData
                                                          .value
                                                          .result
                                                          ?.matchingFarmerList?[
                                                              index]
                                                          .userType ??
                                                      ""));
                                            },
                                            //farmerController.farmerData
                                            child: Container(
                                              width: Get.width * 0.25,
                                              height: Get.height * 0.17,
                                              decoration: BoxDecoration(
                                                color: AppColor.DARK_GREEN
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(18),
                                                  topLeft: Radius.circular(18),
                                                ),
                                                image: farmerController
                                                                .matchingFarmerData
                                                                .value
                                                                .result
                                                                ?.matchingFarmerList?[
                                                                    index]
                                                                .image !=
                                                            null &&
                                                        farmerController
                                                                .matchingFarmerData
                                                                .value
                                                                .result
                                                                ?.matchingFarmerList?[
                                                                    index]
                                                                .image ==
                                                            ""
                                                    ? DecorationImage(
                                                        image: NetworkImage(
                                                          farmerController
                                                                  .matchingFarmerData
                                                                  .value
                                                                  .result
                                                                  ?.matchingFarmerList?[
                                                                      index]
                                                                  .image! ??
                                                              "",
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : null, // Only apply image if it exists
                                              ),
                                              child: farmerController
                                                              .matchingFarmerData
                                                              .value
                                                              .result
                                                              ?.matchingFarmerList?[
                                                                  index]
                                                              .image ==
                                                          null ||
                                                      farmerController
                                                              .matchingFarmerData
                                                              .value
                                                              .result
                                                              ?.matchingFarmerList?[
                                                                  index]
                                                              .image !=
                                                          ""
                                                  ? Center(
                                                      child: Text(
                                                        farmerController
                                                                .matchingFarmerData
                                                                .value
                                                                .result
                                                                ?.matchingFarmerList?[
                                                                    index]
                                                                .fullName![0]
                                                                .toUpperCase() ??
                                                            "",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 50,
                                                          color: AppColor
                                                              .DARK_GREEN, // Text color contrasting the background
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(), // Show nothing if image exists
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Text(
                                                    farmerController
                                                            .matchingFarmerData
                                                            .value
                                                            .result
                                                            ?.matchingFarmerList?[
                                                                index]
                                                            .fullName ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                      color:
                                                          AppColor.BROWN_TEXT,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 8),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/farm/locationbrown.svg",
                                                        width: 20,
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        child: Text(
                                                          '  ${farmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].livesIn ?? ""}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: const Color(
                                                                0xFF61646B),
                                                            fontSize: 8,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/farm/brownPort.svg",
                                                      width: 20,
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      height: 20,
                                                      width: Get.width * 0.4,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: farmerController
                                                                  .matchingFarmerData
                                                                  .value
                                                                  .result!
                                                                  .matchingFarmerList?[
                                                                      index]
                                                                  .expertise!
                                                                  .length ??
                                                              0,
                                                          itemBuilder: (context,
                                                              experties) {
                                                            return Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          5),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  color: const Color(
                                                                      0x14167C0C)),
                                                              child: Center(
                                                                child: Text(
                                                                  farmerController
                                                                          .matchingFarmerData
                                                                          .value
                                                                          .result!
                                                                          .matchingFarmerList?[
                                                                              index]
                                                                          .expertise![
                                                                              experties]
                                                                          .name ??
                                                                      "",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: AppColor
                                                                        .DARK_GREEN,
                                                                    fontSize: 8,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height:
                                                                        0.22,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 100,
                                                      top: 10,
                                                      bottom: 10),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                        width: 1),
                                                  ),
                                                  child: const Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.call,
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                        size: 22,
                                                      ),
                                                      Text(
                                                        '  Contact Farmer',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF044D3A),
                                                          fontSize: 9,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0.16,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
              })),
        ));
  }
}
