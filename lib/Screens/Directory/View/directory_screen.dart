import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Constants/image_constant.dart';
import 'package:farm_easy/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/ChatSection/view/chat_ui.dart';
import 'package:farm_easy/Screens/Directory/Controller/land_owner_controller.dart';
import 'package:farm_easy/Screens/Directory/Controller/list_all_land_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/agri_provider_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/farmer_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/home_controller.dart';
import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/view/recomended_land_info.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({super.key});

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  final landownerController = Get.put(ListLandOwnerController());
  final agriController = Get.put(ListAgriProviderController());
  final landController = Get.put(ListAllLandsController());
  final homecontroller = Get.put(HomeController());
  final farmerController = Get.put(ListFarmerController());
  final ScrollController _landownerScroller = ScrollController();
  final ScrollController _agriScroller = ScrollController();
  final ScrollController _landScroller = ScrollController();
  final ScrollController _farmerScroller = ScrollController();
  @override
  Widget build(BuildContext context) {
    _landownerScroller.addListener(() {
      if (_landownerScroller.position.pixels ==
          _landownerScroller.position.maxScrollExtent) {
        landownerController.loadMoreData();
      }
    });
    _farmerScroller.addListener(() {
      if (_farmerScroller.position.pixels ==
          _farmerScroller.position.maxScrollExtent) {
        farmerController.loadMoreData();
      }
    });
    _agriScroller.addListener(() {
      if (_agriScroller.position.pixels ==
          _agriScroller.position.maxScrollExtent) {
        agriController.loadMoreData();
      }
    });
    _landScroller.addListener(() {
      if (_landScroller.position.pixels ==
          _landScroller.position.maxScrollExtent) {
        landController.loadMoreData();
      }
    });

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: AppColor.BACKGROUND,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppDimension.h * 0.08),
              child: CommonAppBar(
                isbackButton: false,
                title: '    Directory',
              ),
            ),
            body: Container(
              //  height: Get.height * 0.84,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      indicatorWeight: 3,
                      indicatorColor: AppColor.DARK_GREEN,
                      unselectedLabelStyle: GoogleFonts.poppins(
                        color: Color(0xCC044D3A),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      labelStyle: GoogleFonts.poppins(
                        color: AppColor.DARK_GREEN,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      tabs: [
                        Tab(
                          text: "Land Owners",
                        ),
                        Obx(() {
                          if (landownerController.userRole.value ==
                              "Agri Service Provider") {
                            return const Tab(
                              text: "Farmers",
                            );
                          } else if (landownerController.userRole.value ==
                              "Farmer") {
                            return const Tab(
                              text: "Farmers",
                            );
                          } else if (landownerController.userRole.value ==
                              "Land Owner") {
                            return const Tab(
                              text: "Farmers",
                            );
                          } else {
                            return Container();
                          }
                        }),
                        Tab(
                          text: " Lands",
                        ),
                      ]),
                  Expanded(
                      child: TabBarView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.GREY_BORDER),
                              ),
                              child: TextFormField(
                                controller:
                                    landownerController.searchController,
                                onChanged: (query) {
                                  landownerController.searchLandOwner(query);
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                    border: InputBorder.none,
                                    hintText: "Search for land owners",
                                    hintStyle: TextStyle(
                                      color: Color(0xCC61646B),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                    prefixIcon: GestureDetector(
                                      onTap: () async {
                                        String userRole =
                                            await landownerController.prefs
                                                .getUserRole();
                                        print("User Role: $userRole");
                                      },
                                      child: Icon(Icons.search,
                                          color: AppColor.BROWN_TEXT),
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () async {
                                        landownerController.clearSearch();
                                      },
                                      child: Icon(Icons.close,
                                          color: AppColor.BROWN_TEXT),
                                    )),
                              ),
                            ),
                            RefreshIndicator(
                              onRefresh: () async {
                                await landownerController
                                    .refreshAlllandownerdata();
                                await agriController.refreshAllagriProvider();
                                await landController.refreshAllLandData();
                                await farmerController.refreshAllFarmerData();
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height: Platform.isIOS
                                    ? MediaQuery.of(context).size.height * 0.6
                                    : MediaQuery.of(context).size.height *
                                        0.635,
                                child: Obx(() {
                                  if (landownerController.loading.value &&
                                      landownerController
                                          .landOwnerData.isEmpty) {
                                    return Container(
                                      height: 200,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  } else if (landownerController
                                          .rxRequestStatus.value ==
                                      Status.ERROR) {
                                    return Text('No data available');
                                  } else if (landownerController
                                      .landOwnerData.isEmpty) {
                                    return Text('No data available');
                                  } else {
                                    return ListView.builder(
                                        controller: _landownerScroller,
                                        itemCount: landownerController
                                            .landOwnerData.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Get.to(() => UserProfileScreen(
                                                  id: landownerController
                                                      .landOwnerData[index]
                                                      .userId!
                                                      .toInt(),
                                                  userType: landownerController
                                                          .landOwnerData[index]
                                                          .userType ??
                                                      ""));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(top: 10),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        AppColor.GREY_BORDER),
                                                boxShadow: [
                                                  AppColor.BOX_SHADOW
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(() => UserProfileScreen(
                                                          id: landownerController
                                                              .landOwnerData[
                                                                  index]
                                                              .userId!
                                                              .toInt(),
                                                          userType: landownerController
                                                                  .landOwnerData[
                                                                      index]
                                                                  .userType ??
                                                              ""));
                                                    },
                                                    child: Container(
                                                      width: Get.width * 0.25,
                                                      height: Get.height * 0.16,
                                                      decoration: BoxDecoration(
                                                        color: AppColor
                                                            .DARK_GREEN
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  18),
                                                          topLeft:
                                                              Radius.circular(
                                                                  18),
                                                        ),
                                                        image: landownerController
                                                                        .landOwnerData[
                                                                            index]
                                                                        .image !=
                                                                    null &&
                                                                landownerController
                                                                    .landOwnerData[
                                                                        index]
                                                                    .image!
                                                                    .isNotEmpty
                                                            ? DecorationImage(
                                                                image:
                                                                    NetworkImage(
                                                                  landownerController
                                                                      .landOwnerData[
                                                                          index]
                                                                      .image!,
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : null, // Only apply image if it exists
                                                      ),
                                                      child: landownerController
                                                                      .landOwnerData[
                                                                          index]
                                                                      .image ==
                                                                  null ||
                                                              landownerController
                                                                  .landOwnerData[
                                                                      index]
                                                                  .image!
                                                                  .isEmpty
                                                          ? Center(
                                                              child: Text(
                                                                landownerController.landOwnerData[index].fullName !=
                                                                            null &&
                                                                        landownerController
                                                                            .landOwnerData[
                                                                                index]
                                                                            .fullName!
                                                                            .isNotEmpty
                                                                    ? landownerController
                                                                        .landOwnerData[
                                                                            index]
                                                                        .fullName![
                                                                            0]
                                                                        .toUpperCase()
                                                                    : '',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 50,
                                                                  color: AppColor
                                                                      .DARK_GREEN, // Text color contrasting the background
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox(), // Show nothing if image exists
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0,
                                                            horizontal: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical: 10,
                                                          ),
                                                          child: Text(
                                                            '${landownerController.landOwnerData[index].fullName ?? ""}',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: AppColor
                                                                  .BROWN_TEXT,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/farm/locationbrown.svg",
                                                              width: 14,
                                                            ),
                                                            Container(
                                                              width: Get.width *
                                                                  0.45,
                                                              child: Text(
                                                                '  ${landownerController.landOwnerData[index].livesIn ?? ""}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Color(
                                                                      0xFF61646B),
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        landownerController
                                                                    .landOwnerData[
                                                                        index]
                                                                    .totalLands ==
                                                                0
                                                            ? Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            18),
                                                              )
                                                            : Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            5,
                                                                        horizontal:
                                                                            15),
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top: 10,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  color: Color(
                                                                      0x14167C0C),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    '${landownerController.landOwnerData[index].totalLands ?? 0} Lands Listed',
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColor
                                                                          .DARK_GREEN,
                                                                      fontSize:
                                                                          10,
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left:
                                                                      Get.width *
                                                                          0.37,
                                                                  bottom: 5),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 8),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            border: Border.all(
                                                                color: AppColor
                                                                    .DARK_GREEN,
                                                                width: 1),
                                                          ),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Get.to(() =>
                                                                  ChatScreen(
                                                                    landId: 0,
                                                                    enquiryId: landownerController
                                                                            .landOwnerData[index]
                                                                            .enquiryId ??
                                                                        0,
                                                                    userId: landownerController
                                                                            .landOwnerData[index]
                                                                            .userId
                                                                            ?.toInt() ??
                                                                        0,
                                                                    userType: landownerController
                                                                            .landOwnerData[index]
                                                                            .userType ??
                                                                        "",
                                                                    userFrom: landownerController
                                                                            .landOwnerData[index]
                                                                            .livesIn ??
                                                                        "",
                                                                    userName: landownerController
                                                                            .landOwnerData[index]
                                                                            .fullName ??
                                                                        "",
                                                                    image: landownerController
                                                                            .landOwnerData[index]
                                                                            .image ??
                                                                        "",
                                                                    isEnquiryCreatedByMe:
                                                                        false,
                                                                    isEnquiryDisplay:
                                                                        false,
                                                                    enquiryData:
                                                                        "",
                                                                  ));
                                                            },
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
                                                                  color: AppColor
                                                                      .DARK_GREEN,
                                                                  size: 15,
                                                                ),
                                                                Text(
                                                                  '  Contact ',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF044D3A),
                                                                    fontSize: 9,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height:
                                                                        0.16,
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
                                        });
                                  }
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        if (landownerController.userRole.value ==
                            "Agri Service Provider") {
                          return Container(
                            margin:
                                EdgeInsets.only(left: 10, right: 10, bottom: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: AppColor.GREY_BORDER),
                                  ),
                                  child: TextFormField(
                                    controller:
                                        farmerController.searchController,
                                    onChanged: (query) {
                                      farmerController.searchFarmer(query);
                                    },
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        border: InputBorder.none,
                                        hintText: "Search Farmer",
                                        hintStyle: TextStyle(
                                          color: Color(0xCC61646B),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () async {
                                            farmerController.clearSearch();
                                          },
                                          child: Icon(Icons.close,
                                              color: AppColor.BROWN_TEXT),
                                        ),
                                        prefixIcon: Icon(Icons.search,
                                            color: AppColor.BROWN_TEXT)),
                                  ),
                                ),
                                RefreshIndicator(
                                  onRefresh: () async {
                                    await landownerController
                                        .refreshAlllandownerdata();
                                    await agriController
                                        .refreshAllagriProvider();
                                    await landController.refreshAllLandData();
                                    await farmerController
                                        .refreshAllFarmerData();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: Platform.isIOS
                                        ? MediaQuery.of(context).size.height *
                                            0.6
                                        : MediaQuery.of(context).size.height *
                                            0.635,
                                    child: Obx(() {
                                      if (farmerController.loading.value &&
                                          farmerController.farmerData.isEmpty) {
                                        return Container(
                                            height: 200,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()));
                                      } else if (farmerController
                                              .rxRequestStatus.value ==
                                          Status.ERROR) {
                                        return Text('No data available');
                                      } else if (farmerController
                                          .farmerData.isEmpty) {
                                        return Text('No data available');
                                      } else {
                                        return ListView.builder(
                                            itemCount: farmerController
                                                .farmerData.length,
                                            scrollDirection: Axis.vertical,
                                            controller: _farmerScroller,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.to(() => UserProfileScreen(
                                                      id: farmerController
                                                          .farmerData[index]
                                                          .userId!
                                                          .toInt(),
                                                      userType: farmerController
                                                              .farmerData[index]
                                                              .userType ??
                                                          ""));
                                                },
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: AppColor
                                                            .GREY_BORDER),
                                                    boxShadow: [
                                                      AppColor.BOX_SHADOW
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
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(() => UserProfileScreen(
                                                              id: farmerController
                                                                  .farmerData[
                                                                      index]
                                                                  .userId!
                                                                  .toInt(),
                                                              userType: farmerController
                                                                      .farmerData[
                                                                          index]
                                                                      .userType ??
                                                                  ""));
                                                        },
                                                        child: Container(
                                                          width:
                                                              Get.width * 0.25,
                                                          height:
                                                              Get.height * 0.16,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColor
                                                                .DARK_GREEN
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(18),
                                                              topLeft: Radius
                                                                  .circular(18),
                                                            ),
                                                            image: farmerController
                                                                            .farmerData[
                                                                                index]
                                                                            .image !=
                                                                        null &&
                                                                    farmerController
                                                                        .farmerData[
                                                                            index]
                                                                        .image!
                                                                        .isNotEmpty
                                                                ? DecorationImage(
                                                                    image:
                                                                        NetworkImage(
                                                                      farmerController
                                                                          .farmerData[
                                                                              index]
                                                                          .image!,
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : null, // Only apply image if it exists
                                                          ),
                                                          child: farmerController
                                                                          .farmerData[
                                                                              index]
                                                                          .image ==
                                                                      null ||
                                                                  farmerController
                                                                      .farmerData[
                                                                          index]
                                                                      .image!
                                                                      .isEmpty
                                                              ? Center(
                                                                  child: Text(
                                                                    farmerController.farmerData[index].fullName !=
                                                                                null &&
                                                                            farmerController
                                                                                .farmerData[
                                                                                    index]
                                                                                .fullName!
                                                                                .isNotEmpty
                                                                        ? farmerController
                                                                            .farmerData[index]
                                                                            .fullName![0]
                                                                            .toUpperCase()
                                                                        : '',
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      fontSize:
                                                                          50,
                                                                      color: AppColor
                                                                          .DARK_GREEN, // Text color contrasting the background
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                )
                                                              : SizedBox(), // Show nothing if image exists
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 0,
                                                                horizontal: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical: 10,
                                                              ),
                                                              child: Text(
                                                                '${farmerController.farmerData[index].fullName ?? ""}',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: AppColor
                                                                      .BROWN_TEXT,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  "assets/farm/locationbrown.svg",
                                                                  width: 14,
                                                                ),
                                                                Container(
                                                                  width:
                                                                      Get.width *
                                                                          0.45,
                                                                  child: Text(
                                                                    '  ${farmerController.farmerData[index].livesIn ?? ""}',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: Color(
                                                                          0xFF61646B),
                                                                      fontSize:
                                                                          8,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Container(
                                                              height: 20,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10),
                                                              width: Get.width *
                                                                  0.43,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      itemCount:
                                                                          farmerController.farmerData[index].expertise!.length ??
                                                                              0,
                                                                      itemBuilder:
                                                                          (context,
                                                                              indexes) {
                                                                        return Container(
                                                                          margin:
                                                                              EdgeInsets.symmetric(horizontal: 5),
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 8),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(20),
                                                                              color: Color(0x14167C0C)),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              '${farmerController.farmerData[index].expertise![indexes].name ?? ""}',
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
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: Get
                                                                              .width *
                                                                          0.37,
                                                                      bottom:
                                                                          5),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                border: Border.all(
                                                                    color: AppColor
                                                                        .DARK_GREEN,
                                                                    width: 1),
                                                              ),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Get.to(() =>
                                                                      ChatScreen(
                                                                        landId:
                                                                            0,
                                                                        enquiryId:
                                                                            farmerController.farmerData[index].enquiryId?.toInt() ??
                                                                                0,
                                                                        userId:
                                                                            farmerController.farmerData[index].userId?.toInt() ??
                                                                                0,
                                                                        userType:
                                                                            farmerController.farmerData[index].userType ??
                                                                                "",
                                                                        userFrom:
                                                                            farmerController.farmerData[index].livesIn ??
                                                                                "",
                                                                        userName:
                                                                            farmerController.farmerData[index].fullName ??
                                                                                "",
                                                                        image: farmerController.farmerData[index].image ??
                                                                            "",
                                                                        isEnquiryCreatedByMe:
                                                                            false,
                                                                        isEnquiryDisplay:
                                                                            false,
                                                                        enquiryData:
                                                                            "",
                                                                      ));
                                                                },
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .call,
                                                                      color: AppColor
                                                                          .DARK_GREEN,
                                                                      size: 15,
                                                                    ),
                                                                    Text(
                                                                      '  Contact ',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFF044D3A),
                                                                        fontSize:
                                                                            9,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0.16,
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
                                            });
                                      }
                                    }),
                                  ),
                                ),
                                // Obx(() {
                                //   return farmerController.loading.value
                                //       ? Container(
                                //           height: 200,
                                //           child: Center(
                                //               child:
                                //                   CircularProgressIndicator()),
                                //         )
                                //       : SizedBox(); // Empty SizedBox when not loading
                                // }),
                              ],
                            ),
                          );
                        } else if (landownerController.userRole.value ==
                                "Farmer" ||
                            landownerController.userRole.value ==
                                "Land Owner") {
                          return Container(
                            margin:
                                EdgeInsets.only(left: 10, right: 10, bottom: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: AppColor.GREY_BORDER),
                                  ),
                                  child: TextFormField(
                                    controller:
                                        farmerController.searchController,
                                    onChanged: (query) {
                                      farmerController.searchFarmer(query);
                                    },
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        border: InputBorder.none,
                                        hintText: "Search for farmers",
                                        hintStyle: TextStyle(
                                          color: Color(0xCC61646B),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () async {
                                            farmerController.clearSearch();
                                          },
                                          child: Icon(Icons.close,
                                              color: AppColor.BROWN_TEXT),
                                        ),
                                        prefixIcon: Icon(Icons.search,
                                            color: AppColor.BROWN_TEXT)),
                                  ),
                                ),
                                RefreshIndicator(
                                  onRefresh: () async {
                                    await landownerController
                                        .refreshAlllandownerdata();
                                    await agriController
                                        .refreshAllagriProvider();
                                    await landController.refreshAllLandData();
                                    await farmerController
                                        .refreshAllFarmerData();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: Platform.isIOS
                                        ? MediaQuery.of(context).size.height *
                                            0.6
                                        : MediaQuery.of(context).size.height *
                                            0.635,
                                    child: Obx(() {
                                      if (farmerController.loading.value &&
                                          farmerController.farmerData.isEmpty) {
                                        return Container(
                                            height: 200,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()));
                                      } else if (farmerController
                                              .rxRequestStatus.value ==
                                          Status.ERROR) {
                                        return Text('No data available');
                                      } else if (farmerController
                                          .farmerData.isEmpty) {
                                        return Text('No data available');
                                      } else {
                                        return ListView.builder(
                                            itemCount: farmerController
                                                .farmerData.length,
                                            scrollDirection: Axis.vertical,
                                            controller: _farmerScroller,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.to(() => UserProfileScreen(
                                                      id: farmerController
                                                              .farmerData[index]
                                                              .userId
                                                              ?.toInt() ??
                                                          0,
                                                      userType: farmerController
                                                              .farmerData[index]
                                                              .userType ??
                                                          ""));
                                                },
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: AppColor
                                                            .GREY_BORDER),
                                                    boxShadow: [
                                                      AppColor.BOX_SHADOW
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
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(() => UserProfileScreen(
                                                              id: farmerController
                                                                      .farmerData[
                                                                          index]
                                                                      .userId
                                                                      ?.toInt() ??
                                                                  0,
                                                              userType: farmerController
                                                                      .farmerData[
                                                                          index]
                                                                      .userType ??
                                                                  ""));
                                                        },
                                                        //farmerController.farmerData
                                                        child: Container(
                                                          width:
                                                              Get.width * 0.25,
                                                          height:
                                                              Get.height * 0.16,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColor
                                                                .DARK_GREEN
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(18),
                                                              topLeft: Radius
                                                                  .circular(18),
                                                            ),
                                                            image: farmerController
                                                                            .farmerData[
                                                                                index]
                                                                            .image !=
                                                                        null &&
                                                                    farmerController
                                                                        .farmerData[
                                                                            index]
                                                                        .image!
                                                                        .isNotEmpty
                                                                ? DecorationImage(
                                                                    image:
                                                                        NetworkImage(
                                                                      farmerController
                                                                          .farmerData[
                                                                              index]
                                                                          .image!,
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : null, // Only apply image if it exists
                                                          ),
                                                          child: farmerController
                                                                          .farmerData[
                                                                              index]
                                                                          .image ==
                                                                      null ||
                                                                  farmerController
                                                                      .farmerData[
                                                                          index]
                                                                      .image!
                                                                      .isEmpty
                                                              ? Center(
                                                                  child: Text(
                                                                    farmerController.farmerData[index].fullName !=
                                                                                null &&
                                                                            farmerController
                                                                                .farmerData[
                                                                                    index]
                                                                                .fullName!
                                                                                .isNotEmpty
                                                                        ? farmerController
                                                                            .farmerData[index]
                                                                            .fullName![0]
                                                                            .toUpperCase()
                                                                        : '',
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      fontSize:
                                                                          50,
                                                                      color: AppColor
                                                                          .DARK_GREEN, // Text color contrasting the background
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                )
                                                              : SizedBox(), // Show nothing if image exists
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 0,
                                                                horizontal: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical: 10,
                                                              ),
                                                              child: Text(
                                                                '${farmerController.farmerData[index].fullName ?? ""}',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: AppColor
                                                                      .BROWN_TEXT,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  "assets/farm/locationbrown.svg",
                                                                  width: 14,
                                                                ),
                                                                Container(
                                                                  width:
                                                                      Get.width *
                                                                          0.45,
                                                                  child: Text(
                                                                    '  ${farmerController.farmerData[index].livesIn ?? ""}',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: Color(
                                                                          0xFF61646B),
                                                                      fontSize:
                                                                          8,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Container(
                                                              height: 20,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10),
                                                              width: Get.width *
                                                                  0.43,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      itemCount:
                                                                          farmerController.farmerData[index].expertise!.length ??
                                                                              0,
                                                                      itemBuilder:
                                                                          (context,
                                                                              indexes) {
                                                                        return Container(
                                                                          margin:
                                                                              EdgeInsets.symmetric(horizontal: 5),
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 8),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(20),
                                                                              color: Color(0x14167C0C)),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              '${farmerController.farmerData[index].expertise![indexes].name ?? ""}',
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
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: Get
                                                                              .width *
                                                                          0.37,
                                                                      bottom:
                                                                          5),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                border: Border.all(
                                                                    color: AppColor
                                                                        .DARK_GREEN,
                                                                    width: 1),
                                                              ),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Get.to(() =>
                                                                      ChatScreen(
                                                                        landId:
                                                                            0,
                                                                        enquiryId:
                                                                            farmerController.farmerData[index].enquiryId?.toInt() ??
                                                                                0,
                                                                        userId:
                                                                            farmerController.farmerData[index].userId?.toInt() ??
                                                                                0,
                                                                        userType:
                                                                            farmerController.farmerData[index].userType ??
                                                                                "",
                                                                        userFrom:
                                                                            farmerController.farmerData[index].livesIn ??
                                                                                "",
                                                                        userName:
                                                                            farmerController.farmerData[index].fullName ??
                                                                                "",
                                                                        image: farmerController.farmerData[index].image ??
                                                                            "",
                                                                        isEnquiryCreatedByMe:
                                                                            false,
                                                                        isEnquiryDisplay:
                                                                            false,
                                                                        enquiryData:
                                                                            "",
                                                                      ));
                                                                },
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .call,
                                                                      color: AppColor
                                                                          .DARK_GREEN,
                                                                      size: 15,
                                                                    ),
                                                                    Text(
                                                                      '  Contact ',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFF044D3A),
                                                                        fontSize:
                                                                            9,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0.16,
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
                                            });
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Lottie.asset(
                                                    "assets/lotties/animation.json",
                                                    height: 100,
                                                    width: double.infinity),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    }),
                                  ),
                                ),
                                // Obx(() {
                                //   return farmerController.loading.value
                                //       ? Center(
                                //           child:
                                //               CircularProgressIndicator())
                                //       : SizedBox(); // Empty SizedBox when not loading
                                // }),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.GREY_BORDER),
                              ),
                              child: TextFormField(
                                controller: landController.searchController,
                                onChanged: (query) {
                                  landController.searchLandsData(query);
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                    border: InputBorder.none,
                                    hintText: "Search for lands",
                                    hintStyle: TextStyle(
                                      color: Color(0xCC61646B),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () async {
                                        landController.clearSearch();
                                      },
                                      child: Icon(Icons.close,
                                          color: AppColor.BROWN_TEXT),
                                    ),
                                    prefixIcon: GestureDetector(
                                      onTap: () async {
                                        String userRole =
                                            await landownerController.prefs
                                                .getUserRole();
                                        print("User Role: $userRole");
                                      },
                                      child: Icon(Icons.search,
                                          color: AppColor.BROWN_TEXT),
                                    )),
                              ),
                            ),
                            RefreshIndicator(
                              onRefresh: () async {
                                await landownerController
                                    .refreshAlllandownerdata();
                                await agriController.refreshAllagriProvider();
                                await landController.refreshAllLandData();
                                await farmerController.refreshAllFarmerData();
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height: Platform.isIOS
                                    ? MediaQuery.of(context).size.height * 0.6
                                    : MediaQuery.of(context).size.height *
                                        0.635,
                                child: Obx(() {
                                  if (landController.loading.value &&
                                      landController.landData.isEmpty) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (landController
                                          .rxRequestStatus.value ==
                                      Status.ERROR) {
                                    return Text('No data available');
                                  } else if (landController.landData.isEmpty) {
                                    return Text('No data available');
                                  } else {
                                    return ListView.builder(
                                        controller: _landScroller,
                                        itemCount:
                                            landController.landData.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Get.to(() => RecommendedLandInfo(
                                                    id: landController
                                                            .landData[index].id
                                                            ?.toInt() ??
                                                        0,
                                                    name: landController
                                                            .landData[index]
                                                            .landOwnerName ??
                                                        "",
                                                  ));
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    top: 10,
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(20),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20)),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        AppColor.BOX_SHADOW
                                                      ]),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Obx(() {
                                                        return landController
                                                                    .landData[
                                                                        index]
                                                                    .landImages
                                                                    ?.length !=
                                                                0
                                                            ? Column(
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        Get.height *
                                                                            0.17,
                                                                    child: ListView.builder(
                                                                        itemCount: landController.landData[index].landImages?.length ?? 0,
                                                                        scrollDirection: Axis.horizontal,
                                                                        itemBuilder: (context, imgindex) {
                                                                          return Container(
                                                                            margin:
                                                                                EdgeInsets.symmetric(horizontal: 10),
                                                                            height:
                                                                                Get.height * 0.17,
                                                                            width:
                                                                                Get.width * 0.34,
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: NetworkImage("${landController.landData[index].landImages?[imgindex].image}"), fit: BoxFit.cover)),
                                                                          );
                                                                        }),
                                                                  ),
                                                                  Row(
                                                                    children: List.generate(
                                                                        450 ~/ 4,
                                                                        (index) => Expanded(
                                                                              child: Container(
                                                                                margin: EdgeInsets.symmetric(vertical: 10),
                                                                                color: index % 2 == 0 ? Colors.transparent : AppColor.GREY_BORDER,
                                                                                height: 1,
                                                                              ),
                                                                            )),
                                                                  ),
                                                                ],
                                                              )
                                                            : Container();
                                                      }),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SvgPicture.asset(
                                                                ImageConstants
                                                                    .LAND,
                                                                height: 28,
                                                                width: 28,
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 8),
                                                                child: Text(
                                                                  "Land #${landController.landData[index].id ?? 0}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: AppColor
                                                                        .DARK_GREEN,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    height: 2.5,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width:
                                                                    Get.width *
                                                                        0.25,
                                                                child: Text(
                                                                  "${landController.landData[index].city ?? ""} ${landController.landData[index].state ?? ""} ${landController.landData[index].country ?? ""}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: AppColor
                                                                        .GREEN_SUBTEXT,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Container(
                                                            height: Get.height *
                                                                0.12,
                                                            child: Column(
                                                              children:
                                                                  List.generate(
                                                                450 ~/ 10,
                                                                (index) =>
                                                                    Expanded(
                                                                  child:
                                                                      Container(
                                                                    color: index %
                                                                                2 ==
                                                                            0
                                                                        ? Colors
                                                                            .transparent
                                                                        : AppColor
                                                                            .GREY_BORDER,
                                                                    width:
                                                                        1, // Height changed to width
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: Get.height *
                                                                0.13,
                                                            width:
                                                                Get.width * 0.3,
                                                            child: Center(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    ImageConstants
                                                                        .AREA,
                                                                    height: 28,
                                                                    width: 28,
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                8),
                                                                    child: Text(
                                                                      'Area',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: AppColor
                                                                            .DARK_GREEN,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        height:
                                                                            2.5,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: AppDimension
                                                                            .w *
                                                                        0.5,
                                                                    child: Text(
                                                                      "${landController.landData[index].landSize ?? ""}",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: AppColor
                                                                            .GREEN_SUBTEXT,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: Get.height *
                                                                0.12,
                                                            child: Column(
                                                              children:
                                                                  List.generate(
                                                                450 ~/ 10,
                                                                (index) =>
                                                                    Expanded(
                                                                  child:
                                                                      Container(
                                                                    // Adjusted to horizontal margin
                                                                    color: index %
                                                                                2 ==
                                                                            0
                                                                        ? Colors
                                                                            .transparent
                                                                        : AppColor
                                                                            .GREY_BORDER,
                                                                    width:
                                                                        1, // Height changed to width
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width:
                                                                Get.width * 0.3,
                                                            child: Center(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    ImageConstants
                                                                        .CROP,
                                                                    height: 28,
                                                                    width: 28,
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                8),
                                                                    child: Text(
                                                                      'Crop Preferences',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: AppColor
                                                                            .DARK_GREEN,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        height:
                                                                            2.5,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 40,
                                                                    width:
                                                                        Get.width *
                                                                            0.2,
                                                                    child: ListView
                                                                        .builder(
                                                                      scrollDirection:
                                                                          Axis.vertical,
                                                                      itemCount:
                                                                          landController.landData[index].cropToGrow?.length ??
                                                                              0,
                                                                      itemBuilder:
                                                                          (context,
                                                                              cropdata) {
                                                                        return Text(
                                                                          "${landController.landData[index].cropToGrow?[cropdata].name ?? ""}",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            color:
                                                                                AppColor.GREEN_SUBTEXT,
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Center(
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      10),
                                                          width:
                                                              double.infinity,
                                                          child: DottedBorder(
                                                              color: AppColor
                                                                  .GREY_BORDER,
                                                              radius: Radius
                                                                  .circular(12),
                                                              borderType:
                                                                  BorderType
                                                                      .RRect,
                                                              dashPattern: [
                                                                5,
                                                                2
                                                              ],
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            10,
                                                                        horizontal:
                                                                            10),
                                                                child: Center(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                          'Land Owner’s Purpose',
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            color:
                                                                                Color(0xFF044D3A),
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            decoration:
                                                                                TextDecoration.underline,
                                                                            decorationColor:
                                                                                AppColor.DARK_GREEN,
                                                                          )),
                                                                      Text(
                                                                        '${landController.landData[index].purpose?.name ?? ""}',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              Color(0xFF044D3A),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15),
                                                  margin: EdgeInsets.only(
                                                      bottom: 20),
                                                  decoration: BoxDecoration(
                                                      color: Color(0x38044D3A),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(20),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        ImageConstants
                                                            .ENQUIRIES,
                                                        width: Get.width * 0.06,
                                                      ),
                                                      Text(
                                                        'Contact Land Owner',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .DARK_GREEN,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  }
                                }),
                              ),
                            ),
                            // Obx(() {
                            //   return landController.loading.value
                            //       ? Center(child: CircularProgressIndicator())
                            //       : SizedBox(); // Empty SizedBox when not loading
                            // }),
                          ],
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            )));
  }
}
