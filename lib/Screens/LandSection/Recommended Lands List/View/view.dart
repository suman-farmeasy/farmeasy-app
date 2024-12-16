import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/recomended_land_controller.dart';
import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/view/recomended_land_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendedLandsList extends StatefulWidget {
  const RecommendedLandsList({super.key});

  @override
  State<RecommendedLandsList> createState() => _RecommendedLandsListState();
}

class _RecommendedLandsListState extends State<RecommendedLandsList> {
  final recommendedlandController = Get.put(RecommendedLandController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.08),
        child: CommonAppBar(
          isbackButton: true,
          title: 'Recommended Lands List',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                                            "${recommendedlandController.currentDistance.value} km",
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
                                    value: recommendedlandController
                                        .currentDistance.value
                                        .toDouble(),
                                    min: 100,
                                    max: 1000,
                                    divisions: (1000 - 100) ~/
                                        50, // Calculate divisions
                                    label:
                                        "${recommendedlandController.currentDistance.value} km",
                                    onChanged: (value) {
                                      recommendedlandController
                                          .updateDistance(value);
                                    },
                                  ),
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    recommendedlandController
                                        .recommendedLandData(
                                            recommendedlandController
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
              Obx(() {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recommendedlandController
                            .landData.value.result?.recommendedLands?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => RecommendedLandInfo(
                                id: recommendedlandController.landData.value
                                        .result?.recommendedLands?[index].id ??
                                    0,
                                name: recommendedlandController
                                        .landData
                                        .value
                                        .result
                                        ?.recommendedLands?[index]
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
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  color: Colors.white,
                                  boxShadow: [AppColor.BOX_SHADOW]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() {
                                    return recommendedlandController
                                                .landData
                                                .value
                                                .result
                                                ?.recommendedLands?[index]
                                                .landImages
                                                ?.length !=
                                            0
                                        ? Column(
                                            children: [
                                              Container(
                                                height: Get.height * 0.17,
                                                child: ListView.builder(
                                                    itemCount:
                                                        recommendedlandController
                                                                .landData
                                                                .value
                                                                .result
                                                                ?.recommendedLands?[
                                                                    index]
                                                                .landImages
                                                                ?.length ??
                                                            0,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, imgindex) {
                                                      return Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        height:
                                                            Get.height * 0.17,
                                                        width: Get.width * 0.34,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    "${recommendedlandController.landData.value.result?.recommendedLands?[index].landImages?[imgindex].image}"),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      );
                                                    }),
                                              ),
                                              Row(
                                                children: List.generate(
                                                    450 ~/ 4,
                                                    (index) => Expanded(
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10),
                                                            color: index % 2 ==
                                                                    0
                                                                ? Colors
                                                                    .transparent
                                                                : AppColor
                                                                    .GREY_BORDER,
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
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                            ImageConstants.LAND,
                                            height: 28,
                                            width: 28,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Land #${recommendedlandController.landData.value.result?.recommendedLands?[index].id ?? 0}",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                color: AppColor.DARK_GREEN,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                height: 2.5,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: Get.width * 0.25,
                                            child: Text(
                                              "${recommendedlandController.landData.value.result?.recommendedLands?[index].city ?? ""} ${recommendedlandController.landData.value.result?.recommendedLands?[index].state ?? ""} ${recommendedlandController.landData.value.result?.recommendedLands?[index].country ?? ""}",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                color: AppColor.GREEN_SUBTEXT,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: Get.height * 0.12,
                                        child: Column(
                                          children: List.generate(
                                            450 ~/ 10,
                                            (index) => Expanded(
                                              child: Container(
                                                color: index % 2 == 0
                                                    ? Colors.transparent
                                                    : AppColor.GREY_BORDER,
                                                width:
                                                    1, // Height changed to width
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: Get.height * 0.13,
                                        width: Get.width * 0.3,
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                ImageConstants.AREA,
                                                height: 28,
                                                width: 28,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  'Area',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.DARK_GREEN,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    height: 2.5,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: AppDimension.w * 0.5,
                                                child: Text(
                                                  "${recommendedlandController.landData.value.result?.recommendedLands?[index].landSize ?? ""}",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    color:
                                                        AppColor.GREEN_SUBTEXT,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: Get.height * 0.12,
                                        child: Column(
                                          children: List.generate(
                                            450 ~/ 10,
                                            (index) => Expanded(
                                              child: Container(
                                                // Adjusted to horizontal margin
                                                color: index % 2 == 0
                                                    ? Colors.transparent
                                                    : AppColor.GREY_BORDER,
                                                width:
                                                    1, // Height changed to width
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: Get.width * 0.3,
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SvgPicture.asset(
                                                ImageConstants.CROP,
                                                height: 28,
                                                width: 28,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  'Crop Preferences',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.DARK_GREEN,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    height: 2.5,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 40,
                                                width: Get.width * 0.2,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      recommendedlandController
                                                              .landData
                                                              .value
                                                              .result
                                                              ?.recommendedLands?[
                                                                  index]
                                                              .cropToGrow
                                                              ?.length ??
                                                          0,
                                                  itemBuilder:
                                                      (context, cropdata) {
                                                    return Text(
                                                      "${recommendedlandController.landData.value.result?.recommendedLands?[index].cropToGrow?[cropdata].name ?? ""}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: AppColor
                                                            .GREEN_SUBTEXT,
                                                        fontSize: 10,
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
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      width: double.infinity,
                                      child: DottedBorder(
                                          color: AppColor.GREY_BORDER,
                                          radius: Radius.circular(12),
                                          borderType: BorderType.RRect,
                                          dashPattern: [5, 2],
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text('Land Owner’s Purpose',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            Color(0xFF044D3A),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationColor:
                                                            AppColor.DARK_GREEN,
                                                      )),
                                                  Text(
                                                    '${recommendedlandController.landData.value.result?.recommendedLands?[index].purpose?.name ?? ""}',
                                                    style: GoogleFonts.poppins(
                                                      color: Color(0xFF044D3A),
                                                      fontSize: 12,
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
                              padding: EdgeInsets.symmetric(vertical: 15),
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  color: Color(0x38044D3A),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    ImageConstants.ENQUIRIES,
                                    width: Get.width * 0.06,
                                  ),
                                  Text(
                                    'Contact Land Owner',
                                    style: GoogleFonts.poppins(
                                      color: AppColor.DARK_GREEN,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
