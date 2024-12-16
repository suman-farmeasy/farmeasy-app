import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/crop_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/crop_grid_calculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CropYieldCalculator extends StatefulWidget {
  const CropYieldCalculator({super.key});

  @override
  State<CropYieldCalculator> createState() => _CropYieldCalculatorState();
}

class _CropYieldCalculatorState extends State<CropYieldCalculator> {
  final cropgridCalculator = Get.put(CropGridCalculator());
  final cropController = Get.put(CropController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        cropgridCalculator.selectedCropsId.clear();
        cropgridCalculator.selectedCropsName.clear();
        cropgridCalculator.selectedCropsImages.clear();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppDimension.h * 0.08),
          child: CommonAppBar(
            isbackButton: true,
            title: 'Crop Yield Calculator',
            onBackPressed: () {
              cropgridCalculator.selectedCropsId.clear();
              cropgridCalculator.selectedCropsName.clear();
              cropgridCalculator.selectedCropsImages.clear();
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                Text(
                  "Calculate Crop Earning Yield",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Select crops(upto 3)",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 15),
                                  margin: EdgeInsets.only(bottom: 0),
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
                                        "Select Crops",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          cropgridCalculator.selectedCropsId
                                              .clear();
                                          cropgridCalculator.selectedCropsName
                                              .clear();
                                          cropgridCalculator.selectedCropsImages
                                              .clear();
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
                                Obx(() =>
                                    cropgridCalculator.selectedCropsId.isEmpty
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  "Selected Crop List",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xFF333333)),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 20,
                                                    left: 10,
                                                    right: 10),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.12,
                                                width: double.infinity,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemCount: cropgridCalculator
                                                          .selectedCropsId
                                                          .length ??
                                                      0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: Column(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  // print("ON TAP");
                                                                  // cropgridCalculator.removeCrop(cropgridCalculator.selectedCropsName[index], cropgridCalculator.selectedCropsId[index], cropgridCalculator.selectedCropsImages[index]);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.075,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.25,
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              5),
                                                                  // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      image: DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              NetworkImage(cropgridCalculator.selectedCropsImages[index] ?? ""))),
                                                                  child: Center(
                                                                    child: Row(
                                                                      children: [],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                right: 0,
                                                                top: 0,
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 10,
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xFFFF3B30),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      cropgridCalculator.removeCrop(
                                                                          cropgridCalculator.selectedCropsName[
                                                                              index],
                                                                          cropgridCalculator.selectedCropsId[
                                                                              index],
                                                                          cropgridCalculator
                                                                              .selectedCropsImages[index]);
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 18,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5.0),
                                                            child: Text(
                                                              cropgridCalculator
                                                                      .selectedCropsName[
                                                                          index]
                                                                      .toString() ??
                                                                  "",
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 10,
                                                                  color: AppColor
                                                                      .BROWN_TEXT),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15,
                                      bottom: 20,
                                      top: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select up to 3 crops you are interested in",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.BROWN_TEXT,
                                        ),
                                      ),
                                      Obx(
                                        () => Text(
                                          "${cropgridCalculator.selectedCropsId.length}/3",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.GREEN_SUBTEXT,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(() => Expanded(
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 8.0,
                                          mainAxisSpacing: 8.0,
                                          childAspectRatio: 1.1,
                                        ),
                                        itemCount: cropgridCalculator
                                                .farmerCropData.value.result
                                                ?.where((crop) =>
                                                    !cropgridCalculator
                                                        .selectedCropsId
                                                        .contains(crop.id))
                                                .length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          final crop = cropgridCalculator
                                              .farmerCropData.value.result
                                              ?.where((crop) =>
                                                  !cropgridCalculator
                                                      .selectedCropsId
                                                      .contains(crop.id))
                                              .toList()[index];

                                          if (crop == null)
                                            return SizedBox.shrink();

                                          return Column(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        cropgridCalculator
                                                            .selectCrop(
                                                          crop.name ?? "",
                                                          crop.id!.toInt(),
                                                          crop.image ?? "",
                                                        );
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.075,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                        // margin: EdgeInsets.symmetric(
                                                        //     horizontal:
                                                        //         5),
                                                        // padding: EdgeInsets.symmetric(
                                                        //     vertical:
                                                        //         10,
                                                        //     horizontal:
                                                        //         5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  crop.image ??
                                                                      ""),
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5.0),
                                                      child: Text(
                                                        crop.name ?? "",
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 10,
                                                          color: AppColor
                                                              .BROWN_TEXT,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    )),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      // controller.marketDataList(
                                      //     stateController.state.value,
                                      //     districtController.district.value,
                                      //     marketController.market.value,
                                      //     cropController.crop.value);
                                      Get.back();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 25),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.DARK_GREEN,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Proceed",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
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
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.GREY_BORDER),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Crop",
                          ),
                          Icon(Icons.keyboard_arrow_down_rounded,
                              color: AppColor.BROWN_TEXT),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(() => cropgridCalculator.selectedCropsId.isEmpty
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(
                            top: 5, bottom: 10, left: 10, right: 10),
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount:
                              cropgridCalculator.selectedCropsId.length ?? 0,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Color(0xFFFF3B30),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print("ON TAP");
                                          cropgridCalculator.removeCrop(
                                              cropgridCalculator
                                                  .selectedCropsName[index],
                                              cropgridCalculator
                                                  .selectedCropsId[index],
                                              cropgridCalculator
                                                  .selectedCropsImages[index]);
                                        },
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          color: Color(0xFFD6D6D6),
                                          dashPattern: [2, 2],
                                          radius: Radius.circular(12),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 5),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        cropgridCalculator
                                                                    .selectedCropsImages[
                                                                index] ??
                                                            ""))),
                                            child: Center(
                                              child: Row(
                                                children: [],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      cropgridCalculator
                                              .selectedCropsName[index]
                                              .toString() ??
                                          "",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: AppColor.BROWN_TEXT),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )),
                // Obx(() {
                //   return cropgridCalculator
                //               .selectedCropsName.length !=
                //           0
                //       ? Container(
                //           margin: EdgeInsets.symmetric(
                //               horizontal: 10, vertical: 10),
                //           height: 30,
                //           width: double.infinity,
                //           child: ListView.builder(
                //             itemCount: cropgridCalculator
                //                 .selectedCropsName.length,
                //             scrollDirection: Axis.horizontal,
                //             itemBuilder: (context, index) {
                //               final cropName = cropController
                //                   .selectedItems[index];
                //               final cropId = cropController
                //                   .selectedItemsId[index];
                //               return Container(
                //                 margin:
                //                     EdgeInsets.only(right: 10),
                //                 padding: EdgeInsets.symmetric(
                //                     vertical: 5, horizontal: 10),
                //                 decoration: BoxDecoration(
                //                     border: Border.all(
                //                         color: Colors.black12),
                //                     borderRadius:
                //                         BorderRadius.circular(
                //                             15)),
                //                 child: Row(
                //                   children: [
                //                     Text(
                //                       "$cropName  ",
                //                       style:
                //                           TextStyle(fontSize: 13),
                //                     ),
                //                     InkWell(
                //                       onTap: () {
                //                         cropController
                //                             .removeItem(cropName);
                //                         cropController
                //                             .removeItemId(cropId);
                //                       },
                //                       child: Icon(
                //                         Icons.close,
                //                         color: Color(0xFF61646B),
                //                         size: 18,
                //                       ),
                //                     )
                //                   ],
                //                 ),
                //               );
                //             },
                //           ),
                //         )
                //       : Container();
                // }),
                Container(
                  margin: EdgeInsets.only(bottom: 20, top: 10),
                  height: 1,
                  width: double.infinity,
                  color: Color(0xFFE3E3E3),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Land Size(Area)",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    Obx(() {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.0367,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFF044D3A).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: AppColor.DARK_GREEN),
                        ),
                        child: Row(
                          children: [
                            DropdownButton<String>(
                              alignment: Alignment.center,
                              borderRadius: BorderRadius.circular(20),
                              padding: EdgeInsets.zero,
                              underline: Container(),
                              iconEnabledColor: Colors.transparent,
                              value: cropController.selectedValue.value,
                              items: cropController.dropdownItems
                                  .map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                cropController.updateSelectedValue(newValue);
                              },
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded,
                                color: AppColor.BROWN_TEXT),
                          ],
                        ),
                      );
                    })
                  ],
                ),
                Obx(
                  () => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${cropController.sliderValue.value.toStringAsFixed(2).toString()}  ",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        cropController.selectedValue.value == null
                            ? ""
                            : cropController.selectedValue.value.toString(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  // Define min and max values based on selected unit
                  double minValue = cropController.selectedValue.value == "SQFT"
                      ? 100.0
                      : 0.0;
                  double maxValue = cropController.selectedValue.value == "SQFT"
                      ? 10000.0
                      : 100.0;
                  double step = cropController.selectedValue.value == "SQFT"
                      ? 100.0
                      : 0.5; // Step size

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Slider(
                        value: cropController.sliderValue.value,
                        min: minValue,
                        max: maxValue,
                        divisions: ((maxValue - minValue) / step)
                            .round(), // Calculate divisions
                        label:
                            cropController.sliderValue.value.toStringAsFixed(2),
                        onChanged: (double newValue) {
                          cropController.updateSliderValue(newValue);
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${minValue.toStringAsFixed(2)} ${cropController.selectedValue.value ?? ""}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF9299B5),
                            ),
                          ),
                          Text(
                            "${maxValue.toStringAsFixed(2)} ${cropController.selectedValue.value ?? ""}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF9299B5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
                Divider(
                  height: 30,
                  color: Color(0xFFE3E3E3),
                ),
                GestureDetector(
                  onTap: () {
                    cropController.cropdetailsData();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.DARK_GREEN,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Calculate",
                        style: GoogleFonts.poppins(
                          color: AppColor.DARK_GREEN,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
