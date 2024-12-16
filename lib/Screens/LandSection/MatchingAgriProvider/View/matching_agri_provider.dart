import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/LandSection/MatchingAgriProvider/Controller/agri_controller.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchingAgriProvider extends StatefulWidget {
  MatchingAgriProvider({super.key, required this.id});
  int id;
  @override
  State<MatchingAgriProvider> createState() => _MatchingAgriProviderState();
}

class _MatchingAgriProviderState extends State<MatchingAgriProvider> {
  final agriController = Get.put(AgriController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppDimension.h * 0.08),
          child: CommonAppBar(
            isbackButton: true,
            title: "Partners(#${widget.id})",
          ),
        ),
        body: SingleChildScrollView(
          child: RefreshIndicator(
              color: AppColor.DARK_GREEN,
              onRefresh: () async {
                await agriController.getAgriData(100);
              },
              child: Obx(() {
                return agriController.agriLoding.value
                    ? Center(
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
                                    return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 15),
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              decoration: BoxDecoration(
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
                                                    child: CircleAvatar(
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
                                                        "${agriController.currentDistance.value} km",
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
                                            SizedBox(height: 20),
                                            Obx(
                                              () => Slider(
                                                value: agriController
                                                    .currentDistance.value
                                                    .toDouble(),
                                                min: 100,
                                                max: 1000,
                                                divisions: (1000 - 100) ~/
                                                    50, // Calculate divisions
                                                label:
                                                    "${agriController.currentDistance.value} km",
                                                onChanged: (value) {
                                                  agriController
                                                      .updateDistance(value);
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            GestureDetector(
                                              onTap: () {
                                                agriController.getAgriData(
                                                    agriController
                                                        .currentDistance.value);

                                                setState(() {
                                                  Get.back();
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10,
                                                ),
                                                margin: EdgeInsets.symmetric(
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
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 0,
                            ),
                            height: AppDimension.h * 0.81,
                            child: ListView.builder(
                                itemCount: agriController
                                        .agriProviderData
                                        .value
                                        .result
                                        ?.matchingAgriServiceProviders
                                        ?.length ??
                                    0,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => UserProfileScreen(
                                          id: agriController
                                                  .agriProviderData
                                                  .value
                                                  .result
                                                  ?.matchingAgriServiceProviders?[
                                                      index]
                                                  .userId
                                                  ?.toInt() ??
                                              0,
                                          userType: agriController
                                                  .agriProviderData
                                                  .value
                                                  .result
                                                  ?.matchingAgriServiceProviders?[
                                                      index]
                                                  .userType ??
                                              ""));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
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
                                                  id: agriController
                                                          .agriProviderData
                                                          .value
                                                          .result
                                                          ?.matchingAgriServiceProviders?[
                                                              index]
                                                          .userId
                                                          ?.toInt() ??
                                                      0,
                                                  userType: agriController
                                                          .agriProviderData
                                                          .value
                                                          .result
                                                          ?.matchingAgriServiceProviders?[
                                                              index]
                                                          .userType ??
                                                      ""));
                                            },
                                            child: Container(
                                              width: Get.width * 0.25,
                                              height: Get.height * 0.17,
                                              decoration: BoxDecoration(
                                                color: AppColor.DARK_GREEN
                                                    .withOpacity(0.1),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(18),
                                                  topLeft: Radius.circular(18),
                                                ),
                                                image: agriController
                                                                .agriProviderData
                                                                .value
                                                                .result
                                                                ?.matchingAgriServiceProviders?[
                                                                    index]
                                                                .image !=
                                                            null &&
                                                        agriController
                                                                .agriProviderData
                                                                .value
                                                                .result
                                                                ?.matchingAgriServiceProviders?[
                                                                    index]
                                                                .image !=
                                                            ""
                                                    ? DecorationImage(
                                                        image: NetworkImage(
                                                          agriController
                                                                  .agriProviderData
                                                                  .value
                                                                  .result
                                                                  ?.matchingAgriServiceProviders?[
                                                                      index]
                                                                  .image! ??
                                                              "",
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : null, // Only apply image if it exists
                                              ),
                                              child: agriController
                                                              .agriProviderData
                                                              .value
                                                              .result
                                                              ?.matchingAgriServiceProviders?[
                                                                  index]
                                                              .image ==
                                                          null ||
                                                      agriController
                                                              .agriProviderData
                                                              .value
                                                              .result
                                                              ?.matchingAgriServiceProviders?[
                                                                  index]
                                                              .image !=
                                                          ""
                                                  ? Center(
                                                      child: Text(
                                                        agriController
                                                                .agriProviderData
                                                                .value
                                                                .result
                                                                ?.matchingAgriServiceProviders?[
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
                                                  : SizedBox(), // Show nothing if image exists
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: Text(
                                                    '${agriController.agriProviderData.value.result?.matchingAgriServiceProviders?[index].fullName ?? ""}',
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
                                                  margin: EdgeInsets.only(
                                                      bottom: 8),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/farm/locationbrown.svg",
                                                        width: 20,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        child: Text(
                                                          '  ${agriController.agriProviderData.value.result?.matchingAgriServiceProviders?[index].livesIn ?? ""}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Color(
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
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      height: 20,
                                                      width: Get.width * 0.4,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: agriController
                                                                  .agriProviderData
                                                                  .value
                                                                  .result!
                                                                  .matchingAgriServiceProviders?[
                                                                      index]
                                                                  .roles!
                                                                  .length ??
                                                              0,
                                                          itemBuilder:
                                                              (context, roles) {
                                                            return Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          5),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  color: Color(
                                                                      0x14167C0C)),
                                                              child: Center(
                                                                child: Text(
                                                                  '${agriController.agriProviderData.value.result!.matchingAgriServiceProviders?[index].roles![roles].name ?? ""}',
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
                                                  margin: EdgeInsets.only(
                                                      left: 120,
                                                      top: 10,
                                                      bottom: 10),
                                                  padding: EdgeInsets.symmetric(
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
                                                  child: Row(
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
                                                        '  Contact ',
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
