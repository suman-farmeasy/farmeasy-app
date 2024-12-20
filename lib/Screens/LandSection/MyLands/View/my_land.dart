import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/HomeScreen/Model/LandListResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/image_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/View/land_details.dart';
import 'package:farm_easy/Screens/LandSection/MyLands/Controller/add_image_controller.dart';
import 'package:farm_easy/Screens/LandSection/MyLands/Controller/land_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLands extends StatefulWidget {
  const MyLands({super.key});

  @override
  State<MyLands> createState() => _MyLandsState();
}

class _MyLandsState extends State<MyLands> {
  final homecontroller = Get.put(MyLandController());
  final ScrollController _landController = ScrollController();
  // final landController = Get.put(LandInfoController());
  final imageController = Get.put(ImageController());
  final addimageController = Get.put(AddImageController());
  final Set<int> processedIndices = {};
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
            isbackButton: true,
            title: 'My Lands'.tr,
          ),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return RefreshIndicator(
              onRefresh: () async {
                await homecontroller.refreshAllLanddata();
              },
              child: SingleChildScrollView(
                controller: _landController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Obx(() {
                    if (homecontroller.loading.value &&
                        homecontroller.alllandListData.isEmpty) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 30),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Currently there are no lands, you can surely see those here, once posted.'
                              .tr,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: const Color(0xFF777777)),
                        ),
                      ));
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homecontroller.alllandListData.length,
                          itemBuilder: (context, landIndex) {
                            if (!processedIndices.contains(landIndex)) {
                              homecontroller.alllandListData[landIndex].images
                                  ?.add(Images(image: ""));
                              processedIndices.add(landIndex);
                            }
                            return InkWell(
                              onTap: () {
                                Get.to(() => LandDetails(
                                    id: homecontroller
                                            .alllandListData[landIndex].id
                                            ?.toInt() ??
                                        0));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  margin: const EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFFFFF7),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.BROWN_TEXT,
                                                      fontSize: 14),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${homecontroller.alllandListData[landIndex].weatherDetails?.temperature?.toInt() ?? ""}º",
                                                      style:
                                                          GoogleFonts.poppins(
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
                                                                  "http://openweathermap.org/img/wn/${homecontroller.alllandListData[landIndex].weatherDetails?.imgIcon}.png"),
                                                              fit:
                                                                  BoxFit.fill)),
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      child: Text(
                                                        homecontroller
                                                                .alllandListData[
                                                                    landIndex]
                                                                .weatherDetails
                                                                ?.description ??
                                                            "",
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                          0xFF61646B),
                                                      fontSize: 10),
                                                )
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  gradient: AppColor
                                                      .BLUE_GREEN_GRADIENT,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 15),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SvgPicture.asset(
                                                      ImageConstants.CHATGPT,
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        ' AI Agri-assistant',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .BROWN_TEXT,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: List.generate(
                                            450 ~/ 4,
                                            (index) => Expanded(
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 12),
                                                    color: index % 2 == 0
                                                        ? Colors.transparent
                                                        : AppColor.GREY_BORDER,
                                                    height: 1,
                                                  ),
                                                )),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: AppDimension.w * 0.3,
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset(
                                                    ImageConstants.LAND,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Text(
                                                    '${"Land".tr} #${homecontroller.alllandListData[landIndex].id?.toInt() ?? ""}',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      color:
                                                          AppColor.DARK_GREEN,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 2.5,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 80,
                                                    child: Text(
                                                      "${homecontroller.alllandListData[landIndex].city ?? ""} ${homecontroller.alllandListData[landIndex].state ?? ""} ${homecontroller.alllandListData[landIndex].country ?? ""}",
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
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: AppDimension.h * 0.13,
                                            width: AppDimension.w * 0.3,
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset(
                                                    ImageConstants.AREA,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      'Area'.tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 2.5,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: AppDimension.w * 0.5,
                                                    child: Text(
                                                      homecontroller
                                                              .alllandListData[
                                                                  landIndex]
                                                              .landSize ??
                                                          "",
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
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: AppDimension.w * 0.3,
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SvgPicture.asset(
                                                    ImageConstants.CROP,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Text(
                                                    'Crop Preferences'.tr,
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      color:
                                                          AppColor.DARK_GREEN,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 2.5,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: Get.width * 0.2,
                                                    child: ListView.builder(
                                                        itemCount: homecontroller
                                                                .alllandListData[
                                                                    landIndex]
                                                                .cropToGrow
                                                                ?.length ??
                                                            0,
                                                        itemBuilder: (context,
                                                            landdata) {
                                                          return Text(
                                                            homecontroller
                                                                    .alllandListData[
                                                                        landIndex]
                                                                    .cropToGrow?[
                                                                        landdata]
                                                                    .name ??
                                                                "",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: AppColor
                                                                  .GREEN_SUBTEXT,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          );
                                                        }),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: List.generate(
                                            450 ~/ 4,
                                            (index) => Expanded(
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 12),
                                                    color: index % 2 == 0
                                                        ? Colors.transparent
                                                        : AppColor.GREY_BORDER,
                                                    height: 1,
                                                  ),
                                                )),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: AppDimension.h * 0.16,
                                          child:
                                              // homecontroller.allImages.value = [...?homecontroller.alllandListData[index].images?.map((img) => img.image).toList(), ...addimageController.images];
                                              Obx(() {
                                            return ListView.builder(
                                              itemCount: homecontroller
                                                  .alllandListData[landIndex]
                                                  .images!
                                                  .length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, imgIndex) {
                                                final imageUrl = homecontroller
                                                    .alllandListData[landIndex]
                                                    .images![imgIndex]
                                                    .image;
                                                Widget imageWidget;
                                                if (imageUrl?.trim().isEmpty ==
                                                    true) {
                                                  return GestureDetector(
                                                      onTap: () {
                                                        homecontroller.pickImage(
                                                            landIndex,
                                                            homecontroller
                                                                .alllandListData[
                                                                    landIndex]
                                                                .id!
                                                                .toInt());
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                        child: DottedBorder(
                                                            borderType:
                                                                BorderType
                                                                    .RRect,
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                            dashPattern: const [
                                                              9,
                                                              4
                                                            ],
                                                            radius: const Radius
                                                                .circular(12),
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            12)),
                                                                child:
                                                                    Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          0,
                                                                      horizontal:
                                                                          20),
                                                                  child: Center(
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        const Icon(
                                                                            Icons
                                                                                .add,
                                                                            size:
                                                                                20,
                                                                            color:
                                                                                AppColor.BROWN_TEXT),
                                                                        Text(
                                                                          "Add Land\nImages"
                                                                              .tr,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color:
                                                                                Color(0xFF333333),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ))),
                                                      ));
                                                } else {
                                                  if (imageUrl is String &&
                                                      imageUrl
                                                          .startsWith('http')) {
                                                    imageWidget = Image.network(
                                                      imageUrl,
                                                      fit: BoxFit.cover,
                                                      height:
                                                          AppDimension.h * 0.14,
                                                      width:
                                                          AppDimension.w * 0.28,
                                                    );
                                                  } else if (imageUrl
                                                      is String) {
                                                    imageWidget = Image.file(
                                                      File(imageUrl),
                                                      fit: BoxFit.cover,
                                                      height:
                                                          AppDimension.h * 0.14,
                                                      width:
                                                          AppDimension.w * 0.28,
                                                    );
                                                  } else {
                                                    imageWidget =
                                                        const SizedBox.shrink();
                                                  }
                                                  return Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: imageWidget,
                                                    ),
                                                  );
                                                }
                                              },
                                            );
                                          })),
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
                                                'Partners'.tr,
                                                style: GoogleFonts.poppins(
                                                  color: AppColor.DARK_GREEN,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
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
                                                    '${homecontroller.alllandListData[landIndex].totalAgriServiceProvider ?? "0"}',
                                                    style: GoogleFonts.poppins(
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
                                          Row(
                                            children: [
                                              Text(
                                                'Farmers'.tr,
                                                style: GoogleFonts.poppins(
                                                  color: AppColor.DARK_GREEN,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
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
                                                    '${homecontroller.alllandListData[landIndex].totalMatchingFarmer ?? "0"}',
                                                    style: GoogleFonts.poppins(
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
                                          )
                                        ],
                                      )
                                    ],
                                  ),
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
