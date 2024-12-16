import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/ChatGpt/View/chat_gpt_start_Screen.dart';
import 'package:farm_easy/Screens/ChatSection/view/chat_ui.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/matching_farmer.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/View/land_details.dart';
import 'package:farm_easy/Screens/LandSection/MyLands/Controller/land_list_controller.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomeScreenLand extends StatefulWidget {
  const HomeScreenLand({super.key});

  @override
  State<HomeScreenLand> createState() => _HomeScreenLandState();
}

class _HomeScreenLandState extends State<HomeScreenLand> {
  final homecontroller = Get.put(MyLandController());
  final ScrollController _landController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _landController.addListener(() {
      if (_landController.position.pixels ==
          _landController.position.maxScrollExtent) {
        homecontroller.loadMoreData();
      }
    });
    return Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppDimension.h * 0.08),
          child: CommonAppBar(
            title: '    My Lands',
          ),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return RefreshIndicator(
              onRefresh: () async {
                await homecontroller.refreshAllLanddata();
              },
              child: SingleChildScrollView(
                controller: _landController,
                physics: AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Obx(() {
                    if (homecontroller.loading.value &&
                        homecontroller.alllandListData.isEmpty) {
                      // Show full screen loading indicator if loading initially
                      return Center(
                        child: CircularProgressIndicator(
                            color: AppColor.DARK_GREEN),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: homecontroller.alllandListData.length,
                          itemBuilder: (context, landIndex) {
                            int landId = homecontroller
                                .alllandListData[landIndex].id!
                                .toInt();
                            final matchingfarmerController = Get.put(
                                HomeScreenMatchingFarmerController(landId),
                                tag: landId.toString());
                            return InkWell(
                              onTap: () {
                                Get.to(() => LandDetails(
                                    id: homecontroller
                                        .alllandListData[landIndex].id!
                                        .toInt()));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                width: double.infinity,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFFFFFF7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 24,
                                      offset: Offset(0, 2),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                homecontroller
                                                        .alllandListData[
                                                            landIndex]
                                                        .landTitle ??
                                                    "",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.BROWN_TEXT,
                                                    fontSize: 14),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                child: Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  "${homecontroller.alllandListData[landIndex].city ?? ""} ${homecontroller.alllandListData[landIndex].state ?? ""} ${homecontroller.alllandListData[landIndex].country ?? ""}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xFF61646B)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${homecontroller.alllandListData[landIndex].weatherDetails?.temperature?.toInt() ?? ""}º",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColor.BROWN_TEXT,
                                                        fontSize: 15),
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                "http://openweathermap.org/img/wn/${homecontroller.alllandListData[landIndex].weatherDetails?.imgIcon}.png"),
                                                            fit: BoxFit.fill)),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    child: Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      homecontroller
                                                              .alllandListData[
                                                                  landIndex]
                                                              .weatherDetails
                                                              ?.description ??
                                                          "",
                                                      style:
                                                          GoogleFonts.poppins(
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
                                                "Min: ${homecontroller.alllandListData[landIndex].weatherDetails?.minTemp?.toInt() ?? ""}º / Max: ${homecontroller.alllandListData[landIndex].weatherDetails?.maxTemp?.toInt() ?? ""}º",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF61646B),
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
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 12),
                                                  color: index % 2 == 0
                                                      ? Colors.transparent
                                                      : AppColor.GREY_BORDER,
                                                  height: 1,
                                                ),
                                              )),
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Container(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Matching farmers for this land",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.BROWN_TEXT),
                                            ),
                                            Obx(() =>
                                                matchingfarmerController
                                                            .matchingFarmerData
                                                            .value
                                                            .result
                                                            ?.matchingFarmerList
                                                            ?.length !=
                                                        0
                                                    ? Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                          vertical: 20,
                                                        ),
                                                        height:
                                                            Get.height * 0.14,
                                                        child: ListView.builder(
                                                            itemCount: matchingfarmerController
                                                                    .matchingFarmerData
                                                                    .value
                                                                    .result
                                                                    ?.matchingFarmerList
                                                                    ?.length ??
                                                                0,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  Get.to(() => UserProfileScreen(
                                                                      id: matchingfarmerController
                                                                              .matchingFarmerData
                                                                              .value
                                                                              .result
                                                                              ?.matchingFarmerList?[
                                                                                  index]
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
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              20),
                                                                  width:
                                                                      Get.width *
                                                                          0.8,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: AppColor
                                                                            .GREY_BORDER),
                                                                    boxShadow: [
                                                                      AppColor
                                                                          .BOX_SHADOW
                                                                    ],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            18),
                                                                  ),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Get.to(() => UserProfileScreen(
                                                                              id: matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].userId!.toInt() ?? 0,
                                                                              userType: matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].userType ?? ""));
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              Get.width * 0.25,
                                                                          height:
                                                                              Get.height * 0.16,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                AppColor.DARK_GREEN.withOpacity(0.1),
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(18),
                                                                              topLeft: Radius.circular(18),
                                                                            ),
                                                                            image: matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].image != null && matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].image != ""
                                                                                ? DecorationImage(
                                                                                    image: NetworkImage(
                                                                                      matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].image! ?? "",
                                                                                    ),
                                                                                    fit: BoxFit.cover,
                                                                                  )
                                                                                : null, // Only apply image if it exists
                                                                          ),
                                                                          child: matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].image == null || matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].image != ""
                                                                              ? Center(
                                                                                  child: Text(
                                                                                    matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].fullName![0].toUpperCase() ?? "",
                                                                                    style: GoogleFonts.poppins(
                                                                                      fontSize: 50,
                                                                                      color: AppColor.DARK_GREEN, // Text color contrasting the background
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : SizedBox(), // Show nothing if image exists
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 10),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            Text(
                                                                              '${matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].fullName ?? ""}',
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
                                                                                Container(
                                                                                  width: Get.width * 0.44,
                                                                                  child: Text(
                                                                                    '  ${matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].livesIn ?? ""}',
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: GoogleFonts.poppins(
                                                                                      color: Color(0xFF61646B),
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
                                                                                  margin: EdgeInsets.only(left: 5),
                                                                                  height: 20,
                                                                                  width: Get.width * 0.4,
                                                                                  child: ListView.builder(
                                                                                      scrollDirection: Axis.horizontal,
                                                                                      itemCount: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].expertise!.length ?? 0,
                                                                                      itemBuilder: (context, experties) {
                                                                                        return Container(
                                                                                          margin: const EdgeInsets.symmetric(horizontal: 5),
                                                                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0x14167C0C)),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              '${matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].expertise![experties].name ?? ""}',
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
                                                                            InkWell(
                                                                              onTap: () {
                                                                                Get.to(() => ChatScreen(
                                                                                      landId: homecontroller.alllandListData[index].id!.toInt(),
                                                                                      enquiryId: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].enquiryId?.toInt() ?? 0,
                                                                                      userId: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].userId?.toInt() ?? 0,
                                                                                      userType: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].userType ?? "",
                                                                                      userFrom: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].livesIn ?? "",
                                                                                      userName: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].fullName ?? "",
                                                                                      image: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].image ?? "",
                                                                                      isEnquiryCreatedByMe: false,
                                                                                      isEnquiryDisplay: false,
                                                                                      enquiryData: "",
                                                                                    ));
                                                                              },
                                                                              child: Container(
                                                                                margin: EdgeInsets.only(
                                                                                  left: 60,
                                                                                ),
                                                                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                  border: Border.all(color: AppColor.DARK_GREEN, width: 1),
                                                                                ),
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.call,
                                                                                      color: AppColor.DARK_GREEN,
                                                                                      size: 15,
                                                                                    ),
                                                                                    Text(
                                                                                      '  Contact Farmer',
                                                                                      style: TextStyle(
                                                                                        color: Color(0xFF044D3A),
                                                                                        fontSize: 9,
                                                                                        fontFamily: 'Poppins',
                                                                                        fontWeight: FontWeight.w500,
                                                                                        height: 0.16,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
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
                                                      )
                                                    : Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              child: Lottie.asset(
                                                                  "assets/lotties/animation.json",
                                                                  height: 100,
                                                                  width: double
                                                                      .infinity),
                                                            )
                                                          ],
                                                        ),
                                                      ))
                                          ],
                                        ))),
                                    Divider(),
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
                                              '  Enquiries',
                                              style: GoogleFonts.poppins(
                                                color: AppColor.DARK_GREEN,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 0.15,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Partners  ',
                                              style: GoogleFonts.poppins(
                                                color: AppColor.DARK_GREEN,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 0.15,
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 16,
                                              backgroundColor:
                                                  AppColor.DARK_GREEN,
                                              child: Center(
                                                child: Text(
                                                  '${homecontroller.alllandListData[landIndex].totalAgriServiceProvider ?? "0"}',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0.10,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => ChatGptStartScreen());
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                ImageConstants.CHATGPT,
                                                width: 30,
                                                color: AppColor.DARK_GREEN,
                                              ),
                                              Text(
                                                ' AI assistant',
                                                style: GoogleFonts.poppins(
                                                  color: AppColor.DARK_GREEN,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
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
                    }
                  }),
                ),
              ));
        }));
  }
}
