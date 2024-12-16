import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/view/recomended_land_info.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/utils/localization/localization_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/Constants/color_constants.dart';
import '../../../utils/Constants/dimensions_constatnts.dart';
import '../../ChatSection/view/chat_ui.dart';
import '../../Dashboard/controller/dashboard_controller.dart';
import '../../LandSection/Recommended Lands List/View/view.dart';
import '../../UserProfile/View/profile_view.dart';
import '../Controller/agri_provider_controller.dart';
import '../Controller/home_controller.dart';
import '../Controller/recomended_land_controller.dart';

class FarmerBodyWidget extends StatelessWidget {
  FarmerBodyWidget({
    super.key,
    required this.homecontroller,
    required this.agriController,
    required this.dashboardController,
    required this.recommendedlandController,
  });

  final HomeController homecontroller;
  final ListAgriProviderController agriController;
  final DashboardController dashboardController;
  final RecommendedLandController recommendedlandController;
  final localeController = Get.put(LocaleController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: homecontroller.prefs.getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data == "Farmer") {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Near by Partners'.tr,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF483C32),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Obx(() => Row(
                          children: [
                            agriController.agriData.value.result?.pageInfo
                                        ?.totalObject !=
                                    0
                                ? GestureDetector(
                                    onTap: () {
                                      dashboardController.selectedIndex.value =
                                          6;
                                      //  Get.to(()=>agriData(id: controller.landId.value,));
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'View all'.tr,
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF044D3A),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          ' (${agriController.agriData.value.result?.pageInfo?.totalObject ?? 0}) ',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF044D3A),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container()
                          ],
                        ))
                  ],
                ),
                Obx(() {
                  return agriController.agriData.value.result?.data?.length != 0
                      ? Container(
                          margin: const EdgeInsets.only(bottom: 20, top: 10),
                          height: Get.height * 0.14,
                          child: ListView.builder(
                              itemCount: agriController
                                      .agriData.value.result?.data?.length ??
                                  0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  width: AppDimension.w * 0.8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColor.GREY_BORDER),
                                    boxShadow: [AppColor.BOX_SHADOW],
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => UserProfileScreen(
                                              id: agriController
                                                      .agriData
                                                      .value
                                                      .result
                                                      ?.data?[index]
                                                      .userId!
                                                      .toInt() ??
                                                  0,
                                              userType: agriController
                                                      .agriData
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
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(18),
                                              topLeft: Radius.circular(18),
                                            ),
                                            image: agriController
                                                            .agriData
                                                            .value
                                                            .result
                                                            ?.data?[index]
                                                            .image !=
                                                        null &&
                                                    agriController
                                                            .agriData
                                                            .value
                                                            .result
                                                            ?.data?[index]
                                                            .image !=
                                                        ""
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                      agriController
                                                              .agriData
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
                                          child: agriController
                                                          .agriData
                                                          .value
                                                          .result
                                                          ?.data?[index]
                                                          .image ==
                                                      null ||
                                                  agriController
                                                          .agriData
                                                          .value
                                                          .result
                                                          ?.data?[index]
                                                          .image ==
                                                      ""
                                              ? Center(
                                                  child: Text(
                                                    agriController
                                                                    .agriData
                                                                    .value
                                                                    .result
                                                                    ?.data?[
                                                                        index]
                                                                    .fullName !=
                                                                null &&
                                                            agriController
                                                                    .agriData
                                                                    .value
                                                                    .result
                                                                    ?.data?[
                                                                        index]
                                                                    .fullName !=
                                                                ""
                                                        ? agriController
                                                                .agriData
                                                                .value
                                                                .result
                                                                ?.data![index]
                                                                .fullName![0]
                                                                .toUpperCase() ??
                                                            "".toUpperCase()
                                                        : '',
                                                    style: GoogleFonts.poppins(
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
                                            Text(
                                              agriController
                                                      .agriData
                                                      .value
                                                      .result
                                                      ?.data?[index]
                                                      .fullName ??
                                                  "",
                                              style: GoogleFonts.poppins(
                                                color: AppColor.BROWN_TEXT,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/farm/locationbrown.svg",
                                                  width: 14,
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.45,
                                                  child: Text(
                                                    '  ${agriController.agriData.value.result?.data?[index].livesIn ?? ""}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
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
                                            SizedBox(
                                              height: 20,
                                              width: Get.width * 0.43,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: agriController
                                                          .agriData
                                                          .value
                                                          .result
                                                          ?.data?[index]
                                                          .roles
                                                          ?.length ??
                                                      0,
                                                  itemBuilder:
                                                      (context, indexes) {
                                                    return Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: const Color(
                                                              0x14167C0C)),
                                                      child: Center(
                                                        child: Text(
                                                          agriController
                                                                  .agriData
                                                                  .value
                                                                  .result
                                                                  ?.data?[index]
                                                                  .roles![
                                                                      indexes]
                                                                  .name ??
                                                              "",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                            fontSize: 8,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 80),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: AppColor.DARK_GREEN,
                                                    width: 1),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.to(() => ChatScreen(
                                                        landId: 0,
                                                        enquiryId:
                                                            agriController
                                                                    .agriData
                                                                    .value
                                                                    .result
                                                                    ?.data?[
                                                                        index]
                                                                    .enquiryId
                                                                    ?.toInt() ??
                                                                0,
                                                        userId: agriController
                                                                .agriData
                                                                .value
                                                                .result
                                                                ?.data?[index]
                                                                .userId
                                                                ?.toInt() ??
                                                            0,
                                                        userType: agriController
                                                                .agriData
                                                                .value
                                                                .result
                                                                ?.data?[index]
                                                                .userType ??
                                                            "",
                                                        userFrom: agriController
                                                                .agriData
                                                                .value
                                                                .result
                                                                ?.data?[index]
                                                                .livesIn ??
                                                            "",
                                                        userName: agriController
                                                                .agriData
                                                                .value
                                                                .result
                                                                ?.data?[index]
                                                                .fullName ??
                                                            "",
                                                        image: agriController
                                                                .agriData
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
                                                    const Icon(
                                                      Icons.call,
                                                      color:
                                                          AppColor.DARK_GREEN,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                      'Contact'.tr,
                                                      style: const TextStyle(
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
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }))
                      : Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Lottie.asset(
                                    "assets/lotties/animation.json",
                                    width: double.infinity),
                              )
                            ],
                          ),
                        );
                }),
                Column(
                  children: [
                    Obx(() {
                      return recommendedlandController
                                  .landData.value.result?.count !=
                              0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Near by lands'.tr,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF483C32),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const RecommendedLandsList());
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'View all'.tr,
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF044D3A),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        ' (${recommendedlandController.landData.value.result?.count ?? 0}) >',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF044D3A),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Container();
                    }),
                    Obx(() {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recommendedlandController.landData.value
                                      .result?.recommendedLands?.length !=
                                  null
                              ? (recommendedlandController.landData.value
                                          .result!.recommendedLands!.length >
                                      2
                                  ? 2
                                  : recommendedlandController.landData.value
                                      .result!.recommendedLands!.length)
                              : 0,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => RecommendedLandInfo(
                                      id: recommendedlandController
                                              .landData
                                              .value
                                              .result
                                              ?.recommendedLands?[index]
                                              .id ??
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
                                    margin: const EdgeInsets.only(
                                      top: 10,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20)),
                                        color: Colors.white,
                                        boxShadow: [AppColor.BOX_SHADOW]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    SizedBox(
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
                                                          itemBuilder: (context,
                                                              imgindex) {
                                                            return Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              height:
                                                                  Get.height *
                                                                      0.17,
                                                              width: Get.width *
                                                                  0.34,
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
                                                                child:
                                                                    Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  color: index %
                                                                              2 ==
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
                                                  margin: const EdgeInsets.only(
                                                      top: 5),
                                                  child: Text(
                                                    "${"Land".tr} #${recommendedlandController.landData.value.result?.recommendedLands?[index].id ?? 0}",
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
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.25,
                                                  child: Text(
                                                    "${recommendedlandController.landData.value.result?.recommendedLands?[index].city ?? ""} ${recommendedlandController.landData.value.result?.recommendedLands?[index].state ?? ""} ${recommendedlandController.landData.value.result?.recommendedLands?[index].country ?? ""}",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
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
                                            SizedBox(
                                              height: Get.height * 0.12,
                                              child: Column(
                                                children: List.generate(
                                                  450 ~/ 10,
                                                  (index) => Expanded(
                                                    child: Container(
                                                      color: index % 2 == 0
                                                          ? Colors.transparent
                                                          : AppColor
                                                              .GREY_BORDER,
                                                      width:
                                                          1, // Height changed to width
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
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
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      child: Text(
                                                        'Area'.tr,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .DARK_GREEN,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 2.5,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          AppDimension.w * 0.5,
                                                      child: Text(
                                                        recommendedlandController
                                                                .landData
                                                                .value
                                                                .result
                                                                ?.recommendedLands?[
                                                                    index]
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
                                              height: Get.height * 0.12,
                                              child: Column(
                                                children: List.generate(
                                                  450 ~/ 10,
                                                  (index) => Expanded(
                                                    child: Container(
                                                      // Adjusted to horizontal margin
                                                      color: index % 2 == 0
                                                          ? Colors.transparent
                                                          : AppColor
                                                              .GREY_BORDER,
                                                      width:
                                                          1, // Height changed to width
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.3,
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
                                                      height: 28,
                                                      width: 28,
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      child: Text(
                                                        'Crop Preferences'.tr,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .DARK_GREEN,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                        itemBuilder: (context,
                                                            cropdata) {
                                                          return Text(
                                                            recommendedlandController
                                                                    .landData
                                                                    .value
                                                                    .result
                                                                    ?.recommendedLands?[
                                                                        index]
                                                                    .cropToGrow?[
                                                                        cropdata]
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
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            width: double.infinity,
                                            child: DottedBorder(
                                                color: AppColor.GREY_BORDER,
                                                radius:
                                                    const Radius.circular(12),
                                                borderType: BorderType.RRect,
                                                dashPattern: const [5, 2],
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
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
                                                            'Land Owner’s Purpose'
                                                                .tr,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: const Color(
                                                                  0xFF044D3A),
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              decorationColor:
                                                                  AppColor
                                                                      .DARK_GREEN,
                                                            )),
                                                        Text(
                                                          recommendedlandController
                                                                  .landData
                                                                  .value
                                                                  .result
                                                                  ?.recommendedLands?[
                                                                      index]
                                                                  .purpose
                                                                  ?.name ??
                                                              "",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: const Color(
                                                                0xFF044D3A),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: const BoxDecoration(
                                        color: Color(0x38044D3A),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          ImageConstants.ENQUIRIES,
                                          width: Get.width * 0.06,
                                        ),
                                        Text(
                                          'Contact Land Owner'.tr,
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
                )
              ],
            );
          } else {
            return Container(); // Return an empty container if user role is not "Land Owner"
          }
        } else {
          return const CircularProgressIndicator(); // Return a loading indicator while fetching user role
        }
      },
    );
  }
}
