import 'package:farm_easy/Utils/Constants/color_constants.dart';
import 'package:farm_easy/Utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/crop_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CropDetailsScreen extends StatefulWidget {
  const CropDetailsScreen({super.key});

  @override
  State<CropDetailsScreen> createState() => _CropDetailsScreenState();
}

class _CropDetailsScreenState extends State<CropDetailsScreen> {
  final controller = Get.put(CropController());

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final crops = controller.cropDetails.value.result ?? [];

    // Calculate net profits dynamically based on available data
    final netProfits = crops
        .map((crop) => crop.cropYield?.netProfitPercentage ?? 0.0)
        .toList();

    return DefaultTabController(
      length: crops.length,
      child: Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppDimension.h * 0.06),
          child: AppBar(
            backgroundColor: AppColor.BACKGROUND,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: AppColor.PRIMARY_GRADIENT,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: isIOS ? 50 : 40, left: 10, right: 30, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColor.BROWN_TEXT,
                        size: 20,
                      ),
                    ),
                    Text(
                      'Crop Yield',
                      style: GoogleFonts.poppins(
                        color: AppColor.BROWN_TEXT,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 0.09,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
            ),
          ),
        ),
        body: crops.isNotEmpty
            ? Column(
                children: [
                  TabBar(
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
                    tabs: List.generate(crops.length, (index) {
                      return Tab(
                        text: crops[index].name ?? "",
                      );
                    }),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: List.generate(crops.length, (index) {
                        return Obx(
                          () => controller.cropLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 15),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Color(0xFFFFFFF7),
                                            boxShadow: [AppColor.BOX_SHADOW]),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10),
                                              child: Text(
                                                "Yields",
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xFF333333),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: CircularPercentIndicator(
                                                radius: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                lineWidth: 15.0,
                                                percent:
                                                    netProfits[index] / 100,
                                                progressColor:
                                                    AppColor.LIGHT_GREEN,
                                                backgroundColor:
                                                    Color(0xFFFDCA40),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10,
                                                                horizontal: 15),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Color(
                                                                0xFFF1F5F8)),
                                                        child: Center(
                                                          child: Text(
                                                            "REVENUE",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: Color(
                                                                  0xFf61646B),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].cropYield!.revenue ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .BROWN_TEXT,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 13.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      15),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Color(
                                                                  0xFFFDCA40)),
                                                          child: Center(
                                                            child: Text(
                                                              "COST",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: AppColor
                                                                    .BROWN_TEXT,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "₹ ${crops[index].cropYield!.cost ?? ""}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: AppColor
                                                                .BROWN_TEXT,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10,
                                                                horizontal: 15),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: AppColor
                                                              .LIGHT_GREEN,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "NET PROFIT",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].cropYield!.netProfit ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .BROWN_TEXT,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 12.0),
                                                    child: Text.rich(
                                                        TextSpan(children: [
                                                      TextSpan(
                                                          text: "Disclaimer:",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .black)),
                                                      TextSpan(
                                                          text:
                                                              "All the figures that are shown in this page may differ accordingly with location, Weather conditions and other factors.",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 10,
                                                              color: Color(
                                                                  0xFF61646B))),
                                                    ])),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 20),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Color(0xFFFFFFF7),
                                            boxShadow: [AppColor.BOX_SHADOW]),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Cost of farming / acre in India",
                                              style: GoogleFonts.poppins(
                                                color: Color(0xFF333333),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.25,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Seeds",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].costOfFarmingPerAcre!.seeds ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Fertiliser",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].costOfFarmingPerAcre!.fertiliser ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Pesticides",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].costOfFarmingPerAcre!.pesticides ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Machinery",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].costOfFarmingPerAcre!.machinery ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Labour",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].costOfFarmingPerAcre!.labour ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Land rent",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].costOfFarmingPerAcre!.landRent ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Support material",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].costOfFarmingPerAcre!.supportMaterial ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Other expenses",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].costOfFarmingPerAcre!.otherExpenses ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Total",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].costOfFarmingPerAcre!.total ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 20),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 15),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Color(0xFFFFFFF7),
                                            boxShadow: [AppColor.BOX_SHADOW]),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Crop yield / acre in India",
                                              style: GoogleFonts.poppins(
                                                color: Color(0xFF333333),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.22,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Sowing month",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${crops[index].cropYieldPerAcre!.sowingSeason ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Harvest month",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${crops[index].cropYieldPerAcre!.harvestSeason ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Avg price",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].cropYieldPerAcre!.avgPrice ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Yield in kg",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        " ${crops[index].cropYieldPerAcre!.yieldInKg ?? "" "kg"}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Crop value",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].cropYieldPerAcre!.cropValue ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Expenditure",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].cropYieldPerAcre!.expenditure ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Net profit",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF61646B)
                                                              .withOpacity(0.8),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₹ ${crops[index].cropYieldPerAcre!.netProfit ?? ""}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
                  ),
                ],
              )
            : Center(
                child: Text(
                  'No Crop Data Available',
                  style: GoogleFonts.poppins(
                    color: AppColor.BROWN_TEXT,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      ),
    );
  }
}
