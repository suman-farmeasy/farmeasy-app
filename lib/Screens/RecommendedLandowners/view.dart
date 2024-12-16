import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/ChatSection/view/chat_ui.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/recommended_landowners.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendedLandowners extends StatefulWidget {
  const RecommendedLandowners({super.key});

  @override
  State<RecommendedLandowners> createState() => _RecommendedLandownersState();
}

class _RecommendedLandownersState extends State<RecommendedLandowners> {
  final recoLandowner = Get.find<RecommendedLandownersController>();
  final ScrollController _landownerScroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    print("DATA");
    _landownerScroller.addListener(() {
      if (_landownerScroller.position.pixels ==
          _landownerScroller.position.minScrollExtent) {
        recoLandowner.loadMoreData(recoLandowner.currentDistance.value);
      }
    });
    return WillPopScope(
      onWillPop: () async {
        recoLandowner.recommendedLandonwers(100);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppDimension.h * 0.08),
          child: CommonAppBar(
            isbackButton: true,
            title: 'Recommended landowners',
            onBackPressed: () {
              recoLandowner.recommendedLandonwers(100);
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 15),
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                      color: AppColor.DARK_GREEN,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      )),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Distance Filter",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.close,
                                            color: AppColor.DARK_GREEN,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Distance",
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.BROWN_TEXT),
                                      ),
                                      Obx(() => Text(
                                            "${recoLandowner.currentDistance.value} km",
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.BROWN_TEXT),
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Obx(
                                  () => Slider(
                                    value: recoLandowner.currentDistance.value
                                        .toDouble(),
                                    min: 100,
                                    max: 1000,
                                    divisions: (1000 - 100) ~/
                                        50, // Calculate divisions
                                    label:
                                        "${recoLandowner.currentDistance.value} km",
                                    onChanged: (value) {
                                      recoLandowner.updateDistance(value);
                                    },
                                  ),
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    recoLandowner.recommendedLandonwers(
                                        recoLandowner.currentDistance.value);
                                    // servicecontroller.nearbyPartnerServices(servicecontroller.currentDistance.value);
                                    setState(() {
                                      Get.back();
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: ShapeDecoration(
                                      color: AppColor.DARK_GREEN,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Apply Filter ',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                        "  Distance Filter  ",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: AppColor.BROWN_TEXT,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                return recoLandowner.farmer.value.result?.data?.length != 0
                    ? Container(
                        margin: EdgeInsets.only(bottom: 20, top: 0),
                        height: Get.height * 0.85,
                        child: ListView.builder(
                            controller: _landownerScroller,
                            itemCount: recoLandowner
                                    .farmer.value.result?.data?.length ??
                                0,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: AppColor.GREY_BORDER),
                                  boxShadow: [AppColor.BOX_SHADOW],
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => UserProfileScreen(
                                            id: recoLandowner
                                                    .farmer
                                                    .value
                                                    .result
                                                    ?.data?[index]
                                                    .userId!
                                                    .toInt() ??
                                                0,
                                            userType: recoLandowner
                                                    .farmer
                                                    .value
                                                    .result
                                                    ?.data?[index]
                                                    .userType ??
                                                ""));
                                      },
                                      child: Container(
                                        width: Get.width * 0.25,
                                        height: Get.height * 0.16,
                                        decoration: BoxDecoration(
                                          color: AppColor.DARK_GREEN
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(18),
                                            topLeft: Radius.circular(18),
                                          ),
                                          image: recoLandowner
                                                          .farmer
                                                          .value
                                                          .result
                                                          ?.data?[index]
                                                          .image !=
                                                      null &&
                                                  recoLandowner
                                                          .farmer
                                                          .value
                                                          .result
                                                          ?.data?[index]
                                                          .image !=
                                                      ""
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                    recoLandowner
                                                            .farmer
                                                            .value
                                                            .result
                                                            ?.data?[index]
                                                            .image! ??
                                                        "",
                                                  ),
                                                  fit: BoxFit.cover,
                                                )
                                              : null, // Only apply image if it exists
                                        ),
                                        child: recoLandowner.farmer.value.result
                                                        ?.data?[index].image ==
                                                    null ||
                                                recoLandowner
                                                        .farmer
                                                        .value
                                                        .result
                                                        ?.data?[index]
                                                        .image ==
                                                    ""
                                            ? Center(
                                                child: Text(
                                                  recoLandowner
                                                          .farmer
                                                          .value
                                                          .result
                                                          ?.data?[index]
                                                          .fullName![0] ??
                                                      "",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 50,
                                                    color: AppColor
                                                        .DARK_GREEN, // Text color contrasting the background
                                                    fontWeight: FontWeight.w500,
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${recoLandowner.farmer.value.result?.data?[index].fullName ?? ""}',
                                            style: GoogleFonts.poppins(
                                              color: AppColor.BROWN_TEXT,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/farm/locationbrown.svg",
                                                width: 14,
                                              ),
                                              Container(
                                                width: Get.width * 0.45,
                                                child: Text(
                                                  '  ${recoLandowner.farmer.value.result?.data?[index].livesIn ?? ""}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0xFF61646B),
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 6,
                                                left: Get.width * 0.37,
                                                bottom: 5),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: AppColor.DARK_GREEN,
                                                  width: 1),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(() => ChatScreen(
                                                      landId: 0,
                                                      enquiryId: recoLandowner
                                                              .farmer
                                                              .value
                                                              .result
                                                              ?.data?[index]
                                                              .enquiryId
                                                              ?.toInt() ??
                                                          0,
                                                      userId: recoLandowner
                                                              .farmer
                                                              .value
                                                              .result
                                                              ?.data?[index]
                                                              .userId
                                                              ?.toInt() ??
                                                          0,
                                                      userType: recoLandowner
                                                              .farmer
                                                              .value
                                                              .result
                                                              ?.data?[index]
                                                              .userType ??
                                                          "",
                                                      userFrom: recoLandowner
                                                              .farmer
                                                              .value
                                                              .result
                                                              ?.data?[index]
                                                              .livesIn ??
                                                          "",
                                                      userName: recoLandowner
                                                              .farmer
                                                              .value
                                                              .result
                                                              ?.data?[index]
                                                              .fullName ??
                                                          "",
                                                      image: recoLandowner
                                                              .farmer
                                                              .value
                                                              .result
                                                              ?.data?[index]
                                                              .image ??
                                                          "",
                                                      isEnquiryCreatedByMe:
                                                          false,
                                                      isEnquiryDisplay: false,
                                                      enquiryData: "",
                                                    ));
                                              },
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    color: AppColor.DARK_GREEN,
                                                    size: 15,
                                                  ),
                                                  Text(
                                                    '  Contact ',
                                                    style: TextStyle(
                                                      color: Color(0xFF044D3A),
                                                      fontSize: 9,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0.16,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }))
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            "There are no Landonwers",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
