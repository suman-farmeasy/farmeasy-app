import 'package:farm_easy/Utils/Constants/color_constants.dart';
import 'package:farm_easy/Utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Utils/CustomWidgets/Res/CommonWidget/app_appbar.dart';
import 'package:farm_easy/Screens/MarketPrices/Controller/district_filter.dart';
import 'package:farm_easy/Screens/MarketPrices/Controller/filter_controller.dart';
import 'package:farm_easy/Screens/MarketPrices/Controller/market_controller.dart';
import 'package:farm_easy/Screens/MarketPrices/Controller/market_filter.dart';
import 'package:farm_easy/Screens/MarketPrices/Controller/state_filter.dart';
import 'package:farm_easy/Screens/MarketPrices/View/crop_list.dart';
import 'package:farm_easy/Screens/MarketPrices/View/district_filter.dart';
import 'package:farm_easy/Screens/MarketPrices/View/state_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MarketPrices extends StatefulWidget {
  const MarketPrices({super.key});

  @override
  State<MarketPrices> createState() => _MarketPricesState();
}

class _MarketPricesState extends State<MarketPrices> {
  final controller = Get.put(MarketController());
  final cropController = Get.put(FilterController());
  final stateController = Get.put(StateFilterController());
  final districtController = Get.put(DistrictFilterController());
  final marketController = Get.put(MarketFilterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.08),
        child: CommonAppBar(
          title: '    Market Prices',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          "Location",
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
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => StateFilter());
                                          },
                                          child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 0),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: AppColor
                                                          .GREY_BORDER)),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.search,
                                                      color:
                                                          AppColor.BROWN_TEXT),
                                                  Obx(() => Text(stateController
                                                              .state.value ==
                                                          ""
                                                      ? "  Search State"
                                                      : "  ${stateController.state.value}"))
                                                ],
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => DistrictFilter());
                                            districtController.getStateList(
                                                stateController.state.value);
                                          },
                                          child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 0),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: AppColor
                                                          .GREY_BORDER)),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.search,
                                                      color:
                                                          AppColor.BROWN_TEXT),
                                                  Obx(() => Text(districtController
                                                              .district.value ==
                                                          ""
                                                      ? "  Search District"
                                                      : "  ${districtController.district.value}"))
                                                ],
                                              )),
                                        ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     Get.to(() => MarketFilter());
                                        //   },
                                        //   child: Container(
                                        //       margin: EdgeInsets.symmetric(
                                        //           vertical: 10, horizontal: 0),
                                        //       padding: EdgeInsets.symmetric(
                                        //           vertical: 10, horizontal: 15),
                                        //       decoration: BoxDecoration(
                                        //           borderRadius:
                                        //               BorderRadius.circular(8),
                                        //           border: Border.all(
                                        //               color: AppColor
                                        //                   .GREY_BORDER)),
                                        //       child: Row(
                                        //         crossAxisAlignment:
                                        //             CrossAxisAlignment.start,
                                        //         children: [
                                        //           Icon(Icons.search,
                                        //               color:
                                        //                   AppColor.BROWN_TEXT),
                                        //           Obx(() => Text(marketController
                                        //                       .market.value ==
                                        //                   ""
                                        //               ? "  Search market"
                                        //               : "  ${marketController.market.value}"))
                                        //         ],
                                        //       )),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        controller.marketDataList(
                                            stateController.state.value,
                                            districtController.district.value,
                                            marketController.market.value,
                                            cropController.crop.value);
                                        Get.back();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 40),
                                        height: AppDimension.h * 0.06,
                                        width: AppDimension.w * 0.85,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColor.GREY_BORDER)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Location",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF505050)),
                          ),
                          Text(
                            "       ",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF505050)),
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: AppColor.BROWN_SUBTEXT,
                            size: 18,
                          )
                        ],
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
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              "Filter",
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
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(() => CropListMarket());
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 0),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .GREY_BORDER)),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Icon(Icons.search,
                                                          color: AppColor
                                                              .BROWN_TEXT),
                                                      Obx(() => Text(cropController
                                                                  .crop.value ==
                                                              ""
                                                          ? "  Search Crop"
                                                          : "  ${cropController.crop.value}"))
                                                    ],
                                                  )),
                                            ),
                                            Center(
                                              child: InkWell(
                                                onTap: () {
                                                  controller.marketDataList(
                                                      stateController
                                                          .state.value,
                                                      districtController
                                                          .district.value,
                                                      marketController
                                                          .market.value,
                                                      cropController
                                                          .crop.value);
                                                  Get.back();
                                                },
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 40),
                                                  height: AppDimension.h * 0.06,
                                                  width: AppDimension.w * 0.85,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: AppColor.DARK_GREEN,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Proceed",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ));
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColor.GREY_BORDER)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Text(
                              cropController.crop.value == ""
                                  ? "Crops"
                                  : "${cropController.crop.value}",
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF505050)),
                            ),
                          ),
                          Text(
                            "       ",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF505050)),
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: AppColor.BROWN_SUBTEXT,
                            size: 18,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => controller.loading.value
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount:
                          controller.marketData.value.result?.length ?? 0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final commodityName = controller
                                .marketData.value.result?[index].commodity ??
                            "";
                        final cropImage =
                            controller.cropImages[commodityName] ??
                                'assets/default_image.png';

                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFFFFFF7),
                            boxShadow: [AppColor.BOX_SHADOW],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () {
                                  final imageUrl =
                                      controller.cropImages[commodityName] ??
                                          "";
                                  return Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: MediaQuery.of(context).size.height *
                                        0.11,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: imageUrl.isEmpty
                                              ? CircularProgressIndicator()
                                              : SizedBox
                                                  .shrink(), // If image URL is empty, show loading
                                        ),
                                        if (imageUrl.isNotEmpty) ...[
                                          Positioned.fill(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  10.0), // Adjust the radius as needed
                                              child: Image.network(
                                                imageUrl,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                    "assets/img/crops.jpg",
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        commodityName,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: AppColor.BROWN_TEXT,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/farm/locationbrown.svg",
                                          width: 14,
                                          color: AppColor.LIGHT_GREEN,
                                        ),
                                        Container(
                                          width: Get.width * 0.45,
                                          child: Text(
                                            "  ${controller.marketData.value.result?[index].market ?? ""}, ${controller.marketData.value.result?[index].district ?? ""}, ${controller.marketData.value.result?[index].state ?? ""}",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              color: AppColor.LIGHT_GREEN,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Rate/Quintal",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color:
                                            Color(0xFF828282).withOpacity(0.8),
                                      ),
                                    ),
                                    Text(
                                      "Min ₹${controller.marketData.value.result?[index].minPrice ?? ""} - Max ₹${controller.marketData.value.result?[index].maxPrice ?? ""}",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
