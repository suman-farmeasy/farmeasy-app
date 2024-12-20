import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Screens/LandSection/EditLand/Controller/edit_land_controller.dart';
import 'package:farm_easy/Screens/LandSection/EditLand/View/kind_of_crop.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Widget/edit_land_dialog.dart';
import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/Screens/ChatSection/view/chat_ui.dart';
import 'package:farm_easy/Screens/LandSection/EditLand/View/edit_land.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Enquiries/Controller/enquiries_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/check_land_details_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/crop_suggestion_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/croplist_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/image_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/land_weather_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/landpercentage_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/list_landType_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/update_landDetails_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/waterrespource_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/View/pdf_viwer.dart';
import 'package:farm_easy/Screens/LandSection/MatchingAgriProvider/Controller/agri_controller.dart';
import 'package:farm_easy/Screens/LandSection/MatchingAgriProvider/View/matching_agri_provider.dart';
import 'package:farm_easy/Screens/LandSection/MatchingFarmer/Controller/matching_farmer_controller.dart';
import 'package:farm_easy/Screens/LandSection/MatchingFarmer/View/matching_farmer.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:farm_easy/Screens/WeatherScreen/View/weather_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../LandAdd/Controller/listother_crop.dart';
import '../../View/land_details.dart';
import '../Model/LandUpdateResponseModel.dart';

class InfoView extends StatefulWidget {
  InfoView({super.key, required this.landId});
  int landId;
  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  final _accomodationKey = GlobalKey<FormState>();
  final _equipmentKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  final farmerController = Get.put(MatchingFarmerController());
  final agriController = Get.put(AgriController());
  final landController = Get.put(ChecklandDetailsController());
  final landTypeController = Get.put(ListLandTypeController());
  final waterController = Get.put(WaterResourceController());
  final cropController = Get.put(CropListController());
  final updateLand = Get.put(UpdateLandDetailsController());
  final imageController = Get.put(ImageController());
  final percentageController = Get.put(LandPercentageController());
  final enqcontroller = Get.put(EnquiriesController());
  final cropSugestionController = Get.put(CropSuggestionController());
  final controller = Get.put(LandInfoController());
  final currentWeather = Get.put(LandWeatherController());
  final editController = Get.put(EditLandController());
  final otherCropController = Get.put(ListOthersCropController());
  final _landSize = GlobalKey<FormState>();
  final _landlease = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    landController.landDetails(widget.landId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        body: RefreshIndicator(
          color: AppColor.DARK_GREEN,
          onRefresh: () async {
            await controller.getLandDetails(widget.landId);
            await landController.landDetails(widget.landId);
            await percentageController.percentageIndicator();
            await enqcontroller.enquiriesListData();
            await farmerController.matchingFarmer(100);
            await agriController.getAgriData(100);
            await cropSugestionController.cropSuggestion();
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Obx(() {
                return controller.landDetailsLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.DARK_GREEN,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return InkWell(
                              onTap: () {
                                double? longitude = double.tryParse(controller
                                        .landDetailsData
                                        .value
                                        .result!
                                        .longitude ??
                                    '');
                                double? latitude = double.tryParse(controller
                                        .landDetailsData
                                        .value
                                        .result!
                                        .latitude ??
                                    '');

                                if (longitude != null && latitude != null) {
                                  Get.to(() => WeatherScreen(
                                      lat: latitude, long: longitude));
                                } else {
                                  print('Invalid latitude or longitude values');
                                }
                              },
                              child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      gradient: AppColor.PRIMARY_GRADIENT,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${currentWeather.currentWeatherData.value.main?.feelsLike?.toInt() ?? 0}º',
                                        style: GoogleFonts.poppins(
                                          color: AppColor.BROWN_TEXT,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            currentWeather.currentWeatherData
                                                    .value.name ??
                                                "",
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF483C32),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                            width: 100,
                                            child: ListView.builder(
                                                itemCount: currentWeather
                                                        .currentWeatherData
                                                        .value
                                                        .weather
                                                        ?.length ??
                                                    0,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (context, weatherIndex) {
                                                  return Text(
                                                    textAlign: TextAlign.start,
                                                    currentWeather
                                                            .currentWeatherData
                                                            .value
                                                            .weather?[
                                                                weatherIndex]
                                                            .main ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                      color:
                                                          AppColor.BROWN_TEXT,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: ListView.builder(
                                                itemCount: currentWeather
                                                        .currentWeatherData
                                                        .value
                                                        .weather
                                                        ?.length ??
                                                    0,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (context, weatherIndex) {
                                                  String iconUrl =
                                                      "http://openweathermap.org/img/wn/${currentWeather.currentWeatherData.value.weather?[weatherIndex].icon}.png";
                                                  return Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image:
                                                                    NetworkImage(
                                                                        iconUrl),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          ),
                                          Text(
                                            'Min: ${currentWeather.currentWeatherData.value.main?.tempMin?.toInt() ?? 0}º / Max: ${currentWeather.currentWeatherData.value.main?.tempMin?.toInt() ?? 0}º / Max: ${currentWeather.currentWeatherData.value.main?.tempMax?.toInt() ?? 0}º',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xCC61646B),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            );
                          }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "  Land Information   ",
                                    style: GoogleFonts.poppins(
                                      color: AppColor.BROWN_TEXT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  imageController.photos.clear();
                                  imageController.uploadedIds.clear();

                                  Get.to(() => EditLand(
                                        landId: controller.landDetailsData.value
                                                .result?.landId ??
                                            0,
                                        nickName: controller.landDetailsData
                                                .value.result?.landTitle ??
                                            "",
                                        landSizeData: controller
                                                .landDetailsData
                                                .value
                                                .result
                                                ?.landSizeData
                                                ?.area ??
                                            "",
                                        landSizeDataType: controller
                                                .landDetailsData
                                                .value
                                                .result
                                                ?.landSizeData
                                                ?.unit ??
                                            "",
                                        purposeId: controller.landDetailsData
                                                .value.result?.purpose?.id ??
                                            0,
                                        purposeName: controller.landDetailsData
                                                .value.result?.purpose?.name ??
                                            "",
                                        leaseDuration: controller
                                                .landDetailsData
                                                .value
                                                .result
                                                ?.leaseDurationData
                                                ?.duration ??
                                            "",
                                        leaseDurationType: controller
                                                .landDetailsData
                                                .value
                                                .result
                                                ?.leaseDurationData
                                                ?.unit ??
                                            "",
                                        leaseType: controller.landDetailsData
                                                .value.result?.leaseType ??
                                            "",
                                        leaseAmount: controller
                                                .landDetailsData
                                                .value
                                                .result
                                                ?.leaseAmountData
                                                ?.amount ??
                                            "",
                                        leaseAmountValue: controller
                                                .landDetailsData
                                                .value
                                                .result
                                                ?.leaseAmountData
                                                ?.unit ??
                                            "",
                                        cropToGrow: controller.landDetailsData
                                                .value.result!.cropToGrow! ??
                                            [],
                                        landType: controller.landDetailsData
                                                .value.result!.landType?.id ??
                                            0,
                                        isWaterAvailable: controller
                                                .landDetailsData
                                                .value
                                                .result!
                                                .waterSourceAvailable ??
                                            true,
                                        waterValue: controller
                                                .landDetailsData
                                                .value
                                                .result!
                                                .waterSource
                                                ?.id ??
                                            0,
                                        isAccommodationAvailable: controller
                                                .landDetailsData
                                                .value
                                                .result!
                                                .accomodationAvailable ??
                                            true,
                                        accommodation: controller
                                                .landDetailsData
                                                .value
                                                .result!
                                                .accomodation ??
                                            "",
                                        isEquipmentAvailable: controller
                                                .landDetailsData
                                                .value
                                                .result!
                                                .equipmentAvailable ??
                                            true,
                                        equipment: controller.landDetailsData
                                                .value.result!.equipment ??
                                            "",
                                        isRoadAccess: controller.landDetailsData
                                                .value.result!.roadAccess ??
                                            true,
                                        isFarmedBefore: controller
                                                .landDetailsData
                                                .value
                                                .result!
                                                .landFarmedBefore ??
                                            true,
                                        cropGrew: controller.landDetailsData
                                                .value.result!.cropsGrown! ??
                                            [],
                                        landImages: controller.landDetailsData
                                                .value.result?.images ??
                                            [],
                                        certificate: controller
                                                .landDetailsData
                                                .value
                                                .result
                                                ?.certificationDocumnet ??
                                            "",
                                        isLandCertified: controller
                                                .landDetailsData
                                                .value
                                                .result
                                                ?.organicCertification ??
                                            true,
                                      ));
                                },
                                child: SvgPicture.asset(
                                    "assets/img/edit_land.svg"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: Get.height * 0.64,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Obx(() {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColor.GREY_BORDER),
                                        boxShadow: [AppColor.BOX_SHADOW],
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showEditLandDialog(
                                                context,
                                                0.4,
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 20),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 15,
                                                      horizontal: 15),
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
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Land Size(Area)',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: const Color(
                                                                    0xFF272727),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            const TextSpan(
                                                              text: '*',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFFEB5757),
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height: 0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 15),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.075,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: AppColor
                                                                  .GREY_BORDER),
                                                          boxShadow: [
                                                            AppColor.BOX_SHADOW
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Form(
                                                              key: _landSize,
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15),
                                                                width:
                                                                    Get.width *
                                                                        0.33,
                                                                child:
                                                                    TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  controller:
                                                                      editController
                                                                          .landSize
                                                                          .value,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        'Land Size',
                                                                    hintStyle:
                                                                        GoogleFonts
                                                                            .poppins(
                                                                      color: const Color(
                                                                          0x994F4F4F),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      height:
                                                                          0.10,
                                                                    ),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                  ),
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'enter the land size';
                                                                    }
                                                                    {
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                              child: Obx(
                                                                () =>
                                                                    DropdownButton(
                                                                  underline:
                                                                      Container(),
                                                                  value: editController
                                                                          .selectedUnit
                                                                          .value ??
                                                                      "Square Meters",
                                                                  items: editController
                                                                      .units
                                                                      .map(
                                                                          (unit) {
                                                                    return DropdownMenuItem(
                                                                      value:
                                                                          unit,
                                                                      child:
                                                                          Text(
                                                                        unit,
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              const Color(0xFF4F4F4F),
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          height:
                                                                              0.10,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                  onChanged:
                                                                      (selectedUnit) {
                                                                    editController
                                                                        .updateSelectedUnit(
                                                                            selectedUnit.toString());
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 120),
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (_landSize
                                                                .currentState!
                                                                .validate()) {
                                                              editController
                                                                  .addLand();
                                                              updateLand.updateLandSize(
                                                                  editController
                                                                      .landArea
                                                                      .value);
                                                            }
                                                            {
                                                              return;
                                                            }
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 3,
                                                            ),
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 10,
                                                            ),
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: AppColor
                                                                  .DARK_GREEN,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    if (_landSize
                                                                        .currentState!
                                                                        .validate()) {
                                                                      editController
                                                                          .addLand();
                                                                      updateLand.updateLandSize(editController
                                                                          .landArea
                                                                          .value);
                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                    {
                                                                      return;
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    'Add ',
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      height: 0,
                                                                    ),
                                                                  )),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: Get.width * 0.6,
                                                  margin: const EdgeInsets.only(
                                                      top: 15),
                                                  child: ListTile(
                                                    trailing: const Icon(
                                                        Icons.arrow_drop_down),
                                                    leading: SvgPicture.asset(
                                                      "assets/farm/area.svg",
                                                      width: 30,
                                                    ),
                                                    title: Text(
                                                      'Area',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      editController.landArea
                                                              .value.isNotEmpty
                                                          ? editController
                                                              .landArea.value
                                                          : controller
                                                                  .landDetailsData
                                                                  .value
                                                                  .result
                                                                  ?.landSize ??
                                                              "plz select",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xA3044D3A),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                CircularPercentIndicator(
                                                  radius: Get.width * 0.11,
                                                  lineWidth: 8.0,
                                                  percent: (percentageController
                                                              .percentIndicate
                                                              .value
                                                              .result
                                                              ?.completionPercentage
                                                              ?.toDouble() ??
                                                          0.0) /
                                                      100,
                                                  startAngle: 0.0,
                                                  linearGradient:
                                                      LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      const Color(0xfff1f881f)
                                                          .withOpacity(0.8),
                                                      const Color(0xfffffe546)
                                                          .withOpacity(0.4),
                                                    ],
                                                  ),
                                                  center: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${percentageController.percentIndicate.value.result?.completionPercentage ?? "0"}%",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .DARK_GREEN,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0,
                                                        ),
                                                      ),
                                                      Text(
                                                        "information",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .GREEN_SUBTEXT,
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: Color(0xFFE6E6E6),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              log('Address');
                                            },
                                            leading: SvgPicture.asset(
                                              "assets/farm/location.svg",
                                              width: 30,
                                            ),
                                            title: Text(
                                              'Address',
                                              style: GoogleFonts.poppins(
                                                color: AppColor.DARK_GREEN,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            subtitle: Text(
                                              controller.landDetailsData.value
                                                      .result?.address ??
                                                  "",
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xA3044D3A),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const Divider(
                                            color: Color(0xFFE6E6E6),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => KindOfCrop(
                                                    landId: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.landId ??
                                                        0,
                                                    nickName: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.landTitle ??
                                                        "",
                                                    landSizeData: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.landSizeData
                                                            ?.area ??
                                                        "",
                                                    landSizeDataType: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.landSizeData
                                                            ?.unit ??
                                                        "",
                                                    purposeId: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.purpose
                                                            ?.id ??
                                                        0,
                                                    purposeName: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.purpose
                                                            ?.name ??
                                                        "",
                                                    leaseDuration: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.leaseDurationData
                                                            ?.duration ??
                                                        "",
                                                    leaseDurationType: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.leaseDurationData
                                                            ?.unit ??
                                                        "",
                                                    leaseType: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.leaseType ??
                                                        "",
                                                    leaseAmount: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.leaseAmountData
                                                            ?.amount ??
                                                        "",
                                                    leaseAmountValue: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.leaseAmountData
                                                            ?.unit ??
                                                        "",
                                                    cropToGrow: controller
                                                            .landDetailsData
                                                            .value
                                                            .result!
                                                            .cropToGrow! ??
                                                        [],
                                                    landType: controller
                                                            .landDetailsData
                                                            .value
                                                            .result!
                                                            .landType
                                                            ?.id ??
                                                        0,
                                                    isWaterAvailable: controller
                                                            .landDetailsData
                                                            .value
                                                            .result!
                                                            .waterSourceAvailable ??
                                                        true,
                                                    waterValue: controller
                                                            .landDetailsData
                                                            .value
                                                            .result!
                                                            .waterSource
                                                            ?.id ??
                                                        0,
                                                    isAccommodationAvailable:
                                                        controller
                                                                .landDetailsData
                                                                .value
                                                                .result!
                                                                .accomodationAvailable ??
                                                            true,
                                                    accommodation: controller
                                                            .landDetailsData
                                                            .value
                                                            .result!
                                                            .accomodation ??
                                                        "",
                                                    isEquipmentAvailable: controller
                                                            .landDetailsData
                                                            .value
                                                            .result!
                                                            .equipmentAvailable ??
                                                        true,
                                                    equipment: controller
                                                            .landDetailsData
                                                            .value
                                                            .result!
                                                            .equipment ??
                                                        "",
                                                    isRoadAccess: controller
                                                            .landDetailsData
                                                            .value
                                                            .result!
                                                            .roadAccess ??
                                                        true,
                                                    isFarmedBefore: controller
                                                            .landDetailsData
                                                            .value
                                                            .result!
                                                            .landFarmedBefore ??
                                                        true,
                                                    cropGrew: controller
                                                            .landDetailsData
                                                            .value
                                                            .result!
                                                            .cropsGrown! ??
                                                        [],
                                                    landImages: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.images ??
                                                        [],
                                                    certificate: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.certificationDocumnet ??
                                                        "",
                                                    isLandCertified: controller
                                                            .landDetailsData
                                                            .value
                                                            .result
                                                            ?.organicCertification ??
                                                        true,
                                                  ));
                                            },
                                            child: ListTile(
                                              trailing: const Icon(
                                                  Icons.arrow_drop_down),
                                              contentPadding:
                                                  const EdgeInsets.all(15),
                                              leading: SvgPicture.asset(
                                                "assets/farm/cultivation.svg",
                                                width: 30,
                                              ),
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  'What kind of crop do you want to grow',
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.DARK_GREEN,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              subtitle: SizedBox(
                                                height: 15,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: controller
                                                      .landDetailsData
                                                      .value
                                                      .result!
                                                      .cropToGrow!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final crop = controller
                                                        .landDetailsData
                                                        .value
                                                        .result!
                                                        .cropToGrow![index];
                                                    return Text(
                                                      " ${crop.name ?? ""},",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xA3044D3A),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          editController
                                                          .selectedPurposeName.value ==
                                                      "Give on lease for farming" ||
                                                  editController.selectedPurposeName
                                                          .value ==
                                                      "Profit sharing lease" ||
                                                  controller
                                                          .landDetailsData
                                                          .value
                                                          .result
                                                          ?.purpose!
                                                          .name ==
                                                      "Give on lease for farming" ||
                                                  controller
                                                          .landDetailsData
                                                          .value
                                                          .result
                                                          ?.purpose!
                                                          .name ==
                                                      "Profit sharing lease"
                                              ? Column(
                                                  children: [
                                                    const Divider(
                                                      color: Color(0xFFE6E6E6),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        showEditLandDialog(
                                                            context,
                                                            0.37,
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          15,
                                                                      horizontal:
                                                                          15),
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
                                                                    BorderRadius
                                                                        .circular(
                                                                            18),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              'Lease type',
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            color:
                                                                                const Color(0xFF272727),
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            height:
                                                                                0,
                                                                          ),
                                                                        ),
                                                                        const TextSpan(
                                                                          text:
                                                                              '*',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xFFEB5757),
                                                                            fontSize:
                                                                                14,
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            height:
                                                                                0,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Obx(() {
                                                                    return Container(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              10,
                                                                          horizontal:
                                                                              0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: Obx(
                                                                                  () => RadioListTile<bool>(
                                                                                    contentPadding: EdgeInsets.zero,
                                                                                    activeColor: AppColor.DARK_GREEN,
                                                                                    title: Text(
                                                                                      'Rent/month',
                                                                                      style: GoogleFonts.poppins(
                                                                                        color: const Color(0xFF333333),
                                                                                        fontSize: 12,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                    ),
                                                                                    value: true,
                                                                                    groupValue: editController.isleaseAvailable.value,
                                                                                    onChanged: (value) {
                                                                                      editController.isleaseAvailable.value = value!;
                                                                                      editController.lease_type.value = "Rent";
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: Obx(
                                                                                  () => RadioListTile<bool>(
                                                                                    contentPadding: const EdgeInsets.all(0),
                                                                                    title: Text(
                                                                                      'Share profit',
                                                                                      style: GoogleFonts.poppins(
                                                                                        color: const Color(0xFF333333),
                                                                                        fontSize: 12,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                    ),
                                                                                    value: false,
                                                                                    activeColor: AppColor.DARK_GREEN,
                                                                                    groupValue: editController.isleaseAvailable.value,
                                                                                    onChanged: (value) {
                                                                                      editController.isleaseAvailable.value = value!;
                                                                                      editController.lease_type.value = "Share Profit";
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                editController.isleaseAvailable.value,
                                                                            child:
                                                                                Container(
                                                                              margin: const EdgeInsets.symmetric(vertical: 15),
                                                                              height: MediaQuery.of(context).size.height * 0.075,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                border: Border.all(color: AppColor.GREY_BORDER),
                                                                                boxShadow: [
                                                                                  AppColor.BOX_SHADOW
                                                                                ],
                                                                                borderRadius: BorderRadius.circular(18),
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                                    child: Obx(
                                                                                      () => DropdownButton(
                                                                                        icon: null,
                                                                                        underline: Container(),
                                                                                        value: editController.amount.value ?? "Months",
                                                                                        items: editController.amountType.map((unit) {
                                                                                          return DropdownMenuItem(
                                                                                            value: unit,
                                                                                            child: Text(
                                                                                              unit,
                                                                                              style: GoogleFonts.poppins(
                                                                                                color: const Color(0xFF4F4F4F),
                                                                                                fontSize: 14,
                                                                                                fontWeight: FontWeight.w500,
                                                                                                height: 0.10,
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        }).toList(),
                                                                                        onChanged: (selectedUnit) {
                                                                                          editController.updateSelectedamount(selectedUnit.toString());
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 1,
                                                                                    color: Colors.grey,
                                                                                  ),
                                                                                  Container(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                                    width: Get.width * 0.33,
                                                                                    child: TextFormField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      controller: editController.isleaseAmount.value,
                                                                                      decoration: InputDecoration(
                                                                                        hintText: 'amount',
                                                                                        hintStyle: GoogleFonts.poppins(
                                                                                          color: const Color(0x994F4F4F),
                                                                                          fontSize: 14,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          height: 0.10,
                                                                                        ),
                                                                                        border: InputBorder.none,
                                                                                      ),
                                                                                      validator: (value) {
                                                                                        if (value!.isEmpty) {
                                                                                          return 'enter the amount';
                                                                                        }
                                                                                        {
                                                                                          return null;
                                                                                        }
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            120),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        print(
                                                                            "LEASE TYPE:::${editController.lease_type.value}");
                                                                        editController
                                                                            .addAmount();
                                                                        updateLand.updateLandLeaseType(
                                                                            editController.lease_type.value,
                                                                            editController.leaseAmount.value);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(
                                                                          vertical:
                                                                              3,
                                                                        ),
                                                                        margin:
                                                                            const EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10,
                                                                        ),
                                                                        decoration:
                                                                            ShapeDecoration(
                                                                          color:
                                                                              AppColor.DARK_GREEN,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child: TextButton(
                                                                              onPressed: () {
                                                                                print("LEASE TYPE:::${editController.lease_type.value}");
                                                                                editController.addAmount();
                                                                                updateLand.updateLandLeaseType(editController.lease_type.value, editController.leaseAmount.value);
                                                                                Future.delayed(const Duration(milliseconds: 500), () {
                                                                                  Navigator.pop(context);
                                                                                  Navigator.pop(context);
                                                                                  Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                        builder: (context) => LandDetails(
                                                                                          id: widget.landId,
                                                                                        ),
                                                                                      ));
                                                                                });
                                                                              },
                                                                              child: Text(
                                                                                'Add ',
                                                                                style: GoogleFonts.poppins(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  height: 0,
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ));
                                                      },
                                                      child: ListTile(
                                                        trailing: const Icon(Icons
                                                            .arrow_drop_down),
                                                        leading:
                                                            SvgPicture.asset(
                                                          "assets/img/wide 1.svg",
                                                          width: 30,
                                                          color: AppColor
                                                              .DARK_GREEN,
                                                        ),
                                                        title: Text(
                                                          'Lease Type',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                          editController
                                                                  .lease_type
                                                                  .value
                                                                  .isNotEmpty
                                                              ? editController
                                                                  .lease_type
                                                                  .value
                                                              : controller
                                                                      .landDetailsData
                                                                      .value
                                                                      .result
                                                                      ?.leaseType! ??
                                                                  "",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: const Color(
                                                                0xA3044D3A),
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const Divider(
                                                      color: Color(0xFFE6E6E6),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        showEditLandDialog(
                                                          context,
                                                          0.27,
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 10),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        15,
                                                                    horizontal:
                                                                        15),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: AppColor
                                                                      .GREY_BORDER),
                                                              boxShadow: [
                                                                AppColor
                                                                    .BOX_SHADOW
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text.rich(
                                                                  TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            'Lease duration',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              const Color(0xFF272727),
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          height:
                                                                              0,
                                                                        ),
                                                                      ),
                                                                      const TextSpan(
                                                                        text:
                                                                            '*',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFFEB5757),
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          height:
                                                                              0,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          15),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.075,
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
                                                                    children: [
                                                                      Form(
                                                                        key:
                                                                            _landlease,
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 15),
                                                                          width:
                                                                              Get.width * 0.33,
                                                                          child:
                                                                              TextFormField(
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            controller:
                                                                                editController.landlease.value,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: 'duration',
                                                                              hintStyle: GoogleFonts.poppins(
                                                                                color: const Color(0x994F4F4F),
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w500,
                                                                                height: 0.10,
                                                                              ),
                                                                              border: InputBorder.none,
                                                                            ),
                                                                            validator:
                                                                                (value) {
                                                                              if (value!.isEmpty) {
                                                                                return 'enter the duration';
                                                                              }
                                                                              {
                                                                                return null;
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      Container(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                15),
                                                                        child:
                                                                            Obx(
                                                                          () {
                                                                            // Ensure the selected value is in the list of items
                                                                            final selectedValue = editController.leaseunits.contains(editController.selectedleaseUinit.value)
                                                                                ? editController.selectedleaseUinit.value
                                                                                : null;

                                                                            return DropdownButton(
                                                                              underline: Container(),
                                                                              value: selectedValue,
                                                                              hint: const Text("Select a unit"),
                                                                              items: editController.leaseunits.map((unit) {
                                                                                return DropdownMenuItem(
                                                                                  value: unit,
                                                                                  child: Text(
                                                                                    unit,
                                                                                    style: GoogleFonts.poppins(
                                                                                      color: const Color(0xFF4F4F4F),
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      height: 0.10,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }).toList(),
                                                                              onChanged: (selectedUnit) {
                                                                                editController.updateSelectedleaseUnit(selectedUnit.toString());
                                                                              },
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              120),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      if (_landlease
                                                                          .currentState!
                                                                          .validate()) {
                                                                        editController
                                                                            .addLease();
                                                                        updateLand.updateLandLeaseDuration(editController
                                                                            .leaseDUration
                                                                            .value);
                                                                      }
                                                                      {
                                                                        return;
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        vertical:
                                                                            3,
                                                                      ),
                                                                      margin: const EdgeInsets
                                                                          .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                      ),
                                                                      decoration:
                                                                          ShapeDecoration(
                                                                        color: AppColor
                                                                            .DARK_GREEN,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child: TextButton(
                                                                            onPressed: () {
                                                                              if (_landlease.currentState!.validate()) {
                                                                                editController.addLease();
                                                                                updateLand.updateLandLeaseDuration(editController.leaseDUration.value);
                                                                                Future.delayed(const Duration(milliseconds: 500), () {
                                                                                  Navigator.pop(context);
                                                                                  Navigator.pop(context);
                                                                                  Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                        builder: (context) => LandDetails(
                                                                                          id: widget.landId,
                                                                                        ),
                                                                                      ));
                                                                                });
                                                                              }
                                                                              {
                                                                                return;
                                                                              }
                                                                            },
                                                                            child: Text(
                                                                              'Add ',
                                                                              style: GoogleFonts.poppins(
                                                                                color: Colors.white,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w600,
                                                                                height: 0,
                                                                              ),
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: ListTile(
                                                        trailing: const Icon(Icons
                                                            .arrow_drop_down),
                                                        leading:
                                                            SvgPicture.asset(
                                                          "assets/img/wide 1.svg",
                                                          width: 30,
                                                          color: AppColor
                                                              .DARK_GREEN,
                                                        ),
                                                        title: Text(
                                                          'Lease duration',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                          editController
                                                                  .leaseDUration
                                                                  .value
                                                                  .isNotEmpty
                                                              ? editController
                                                                  .leaseDUration
                                                                  .value
                                                              : controller
                                                                      .landDetailsData
                                                                      .value
                                                                      .result
                                                                      ?.leaseDuration ??
                                                                  "",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: const Color(
                                                                0xA3044D3A),
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          Obx(() {
                                            return controller
                                                        .isvissible.value ==
                                                    true
                                                ? const Divider(
                                                    color: Color(0xFFE6E6E6),
                                                  )
                                                : Container();
                                          }),
                                          Obx(() {
                                            return controller.isvissible.value
                                                ? Container(
                                                    child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          showEditLandDialog(
                                                            context,
                                                            0.4,
                                                            Obx(
                                                              () {
                                                                return Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          20),
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          15),
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
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child:
                                                                            Text(
                                                                          'Is there space available for farmer accommodation?',
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            color:
                                                                                const Color(0xFF272727),
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: List.generate(
                                                                            450 ~/ 4,
                                                                            (index) => Expanded(
                                                                                  child: Container(
                                                                                    margin: const EdgeInsets.symmetric(vertical: 12),
                                                                                    color: index % 2 == 0 ? Colors.transparent : AppColor.GREY_BORDER,
                                                                                    height: 1,
                                                                                  ),
                                                                                )),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Obx(
                                                                              () => RadioListTile<bool>(
                                                                                contentPadding: const EdgeInsets.all(0),
                                                                                activeColor: AppColor.DARK_GREEN,
                                                                                title: Text(
                                                                                  'Available',
                                                                                  style: GoogleFonts.poppins(
                                                                                    color: const Color(0xFF333333),
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                                value: true,
                                                                                groupValue: updateLand.isAccomodationAvailable.value,
                                                                                onChanged: (value) {
                                                                                  updateLand.isAccomodationAvailable.value = value!;
                                                                                  print(updateLand.isAccomodationAvailable.value);
                                                                                  setState(() {
                                                                                    updateLand.accomodationController.value.text = "";
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Obx(
                                                                              () => RadioListTile<bool>(
                                                                                contentPadding: const EdgeInsets.all(0),
                                                                                title: Text(
                                                                                  'Unavailable',
                                                                                  style: GoogleFonts.poppins(
                                                                                    color: const Color(0xFF333333),
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                                value: false,
                                                                                activeColor: AppColor.DARK_GREEN,
                                                                                groupValue: updateLand.isAccomodationAvailable.value,
                                                                                onChanged: (value) {
                                                                                  updateLand.isAccomodationAvailable.value = value!;
                                                                                  print(updateLand.isAccomodationAvailable.value);
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Visibility(
                                                                        visible: updateLand
                                                                            .isAccomodationAvailable
                                                                            .value,
                                                                        child:
                                                                            Container(
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 15),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            border:
                                                                                Border.all(color: AppColor.GREY_BORDER),
                                                                            boxShadow: [
                                                                              AppColor.BOX_SHADOW
                                                                            ],
                                                                            borderRadius:
                                                                                BorderRadius.circular(18),
                                                                          ),
                                                                          child:
                                                                              Form(
                                                                            key:
                                                                                _accomodationKey,
                                                                            child:
                                                                                TextFormField(
                                                                              controller: updateLand.accomodationController.value,
                                                                              validator: (value) {
                                                                                if (value!.isEmpty) {
                                                                                  return 'Please enter the value';
                                                                                }
                                                                                return "";
                                                                              },
                                                                              decoration: InputDecoration(
                                                                                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                                                                  hintText: "What’s available?",
                                                                                  hintStyle: GoogleFonts.poppins(
                                                                                    color: const Color(0x994F4F4F),
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    height: 0.10,
                                                                                  ),
                                                                                  border: InputBorder.none),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          updateLand.isAccomodationAvailable.value
                                                                              ? _accomodationKey.currentState!.validate()
                                                                              : "";
                                                                          updateLand.isAccomodationAvailable.value
                                                                              ? await updateLand.updateAccomodationAvailable()
                                                                              : await updateLand.isaccomodationAvailable();

                                                                          log('1 ${updateLand.accomodationController.value}');
                                                                          log('2 ${updateLand.isAccomodationAvailable.value}');
                                                                          Future.delayed(
                                                                              const Duration(milliseconds: 500),
                                                                              () {
                                                                            Navigator.pop(context);
                                                                            Navigator.pop(context);
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => LandDetails(
                                                                                    id: widget.landId,
                                                                                  ),
                                                                                ));
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                            margin: EdgeInsets.only(left: Get.width * 0.5),
                                                                            padding: const EdgeInsets.symmetric(
                                                                              vertical: 13,
                                                                              horizontal: 40,
                                                                            ),
                                                                            decoration: ShapeDecoration(
                                                                              color: AppColor.DARK_GREEN,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                            ),
                                                                            child: updateLand.accomodationloading.value
                                                                                ? Container(
                                                                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                                                                    height: 15,
                                                                                    width: 15,
                                                                                    child: const CircularProgressIndicator(
                                                                                      color: Colors.white,
                                                                                      strokeWidth: 3,
                                                                                    ),
                                                                                  )
                                                                                : const Text(
                                                                                    'Save',
                                                                                    style: TextStyle(
                                                                                      color: Color(0xFFFBFBFB),
                                                                                      fontSize: 12,
                                                                                      fontFamily: 'Poppins',
                                                                                      fontWeight: FontWeight.w600,
                                                                                      height: 0,
                                                                                    ),
                                                                                  )),
                                                                      )
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                        child: ListTile(
                                                            trailing:
                                                                const Icon(Icons
                                                                    .arrow_drop_down),
                                                            leading: SvgPicture
                                                                .asset(
                                                              "assets/farm/family.svg",
                                                              width: 30,
                                                            ),
                                                            title: Text(
                                                              'Shelter Available',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: AppColor
                                                                    .DARK_GREEN,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              (controller
                                                                          .landDetailsData
                                                                          .value
                                                                          .result
                                                                          ?.accomodationAvailable ??
                                                                      false)
                                                                  ? "Available"
                                                                  : "Unavailable",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: const Color(
                                                                    0xA3044D3A),
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 0,
                                                              ),
                                                            )),
                                                      ),
                                                      const Divider(
                                                        color:
                                                            Color(0xFFE6E6E6),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          showEditLandDialog(
                                                            context,
                                                            0.6,
                                                            Obx(() {
                                                              return Container(
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        20),
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        15),
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
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        'Type of Land',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              const Color(0xFF272727),
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: List.generate(
                                                                          450 ~/ 4,
                                                                          (index) => Expanded(
                                                                                child: Container(
                                                                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                                                                  color: index % 2 == 0 ? Colors.transparent : AppColor.GREY_BORDER,
                                                                                  height: 1,
                                                                                ),
                                                                              )),
                                                                    ),
                                                                    landTypeController
                                                                            .loading
                                                                            .value
                                                                        ? const Center(
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                            color:
                                                                                AppColor.DARK_GREEN,
                                                                          ))
                                                                        : Wrap(
                                                                            spacing:
                                                                                10,
                                                                            runSpacing:
                                                                                10,
                                                                            children:
                                                                                List.generate(
                                                                              landTypeController.landData.value.result?.length ?? 0,
                                                                              (index) {
                                                                                final landType = landTypeController.landData.value.result![index];
                                                                                return InkWell(
                                                                                  onTap: () {
                                                                                    landTypeController.selectedId.value = landType.id!.toInt(); // Assign actual id
                                                                                    updateLand.landType.value = landType.id.toString();
                                                                                    print("======================================================================${updateLand.landType.value}");
                                                                                  },
                                                                                  child: Container(
                                                                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                                                    decoration: BoxDecoration(
                                                                                      gradient: landTypeController.selectedId.value == landType.id ? AppColor.PRIMARY_GRADIENT : AppColor.WHITE_GRADIENT,
                                                                                      borderRadius: BorderRadius.circular(30),
                                                                                      border: Border.all(
                                                                                        color: landTypeController.selectedId.value == landType.id ? AppColor.DARK_GREEN : AppColor.GREY_BORDER,
                                                                                      ),
                                                                                    ),
                                                                                    child: Text(
                                                                                      landType.name ?? "",
                                                                                      style: GoogleFonts.poppins(
                                                                                        color: AppColor.DARK_GREEN,
                                                                                        fontSize: 12,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        updateLand
                                                                            .updateLandType();
                                                                        Future.delayed(
                                                                            const Duration(milliseconds: 500),
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => LandDetails(
                                                                                  id: widget.landId,
                                                                                ),
                                                                              ));
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                          margin: EdgeInsets.only(left: Get.width * 0.5),
                                                                          padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                13,
                                                                            horizontal:
                                                                                40,
                                                                          ),
                                                                          decoration: ShapeDecoration(
                                                                            color:
                                                                                AppColor.DARK_GREEN,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                          child: const Text(
                                                                            'Save',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color(0xFFFBFBFB),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Poppins',
                                                                              fontWeight: FontWeight.w600,
                                                                              height: 0,
                                                                            ),
                                                                          )),
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                          );
                                                        },
                                                        child: ListTile(
                                                          trailing: const Icon(Icons
                                                              .arrow_drop_down),
                                                          leading:
                                                              SvgPicture.asset(
                                                            "assets/farm/forest.svg",
                                                            width: 30,
                                                          ),
                                                          title: Text(
                                                            'Land Type',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: AppColor
                                                                  .DARK_GREEN,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                            controller
                                                                    .landDetailsData
                                                                    .value
                                                                    .result
                                                                    ?.landType!
                                                                    .name ??
                                                                "N/A",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: const Color(
                                                                  0xA3044D3A),
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color:
                                                            Color(0xFFE6E6E6),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          showEditLandDialog(
                                                              context,
                                                              0.8,
                                                              Container(
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        20),
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        15),
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
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      margin: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              8),
                                                                      child:
                                                                          Text(
                                                                        'Did you farm on this land in the past?',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              const Color(0xFF272727),
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: List.generate(
                                                                          450 ~/ 4,
                                                                          (index) => Expanded(
                                                                                child: Container(
                                                                                  margin: const EdgeInsets.symmetric(vertical: 12),
                                                                                  color: index % 2 == 0 ? Colors.transparent : AppColor.GREY_BORDER,
                                                                                  height: 1,
                                                                                ),
                                                                              )),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Obx(
                                                                          () =>
                                                                              SizedBox(
                                                                            width:
                                                                                AppDimension.w * 0.4,
                                                                            child:
                                                                                RadioListTile<bool>(
                                                                              activeColor: AppColor.DARK_GREEN,
                                                                              title: Text(
                                                                                'Yes',
                                                                                style: GoogleFonts.poppins(
                                                                                  color: const Color(0xFF333333),
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                              value: true,
                                                                              groupValue: updateLand.isLandFarm.value,
                                                                              onChanged: (value) {
                                                                                updateLand.isLandFarm.value = value!;
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Obx(
                                                                          () =>
                                                                              Expanded(
                                                                            child:
                                                                                RadioListTile<bool>(
                                                                              title: Text(
                                                                                'No',
                                                                                style: GoogleFonts.poppins(
                                                                                  color: const Color(0xFF333333),
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                              value: false,
                                                                              activeColor: AppColor.DARK_GREEN,
                                                                              groupValue: updateLand.isLandFarm.value,
                                                                              onChanged: (value) {
                                                                                updateLand.isLandFarm.value = value!;
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    updateLand
                                                                            .isLandFarm
                                                                            .value
                                                                        ? Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              const Text(
                                                                                'What type of crops did you grew?',
                                                                                style: TextStyle(
                                                                                  color: Color(0xFF272727),
                                                                                  fontSize: 13,
                                                                                  fontFamily: 'Poppins',
                                                                                  fontWeight: FontWeight.w500,
                                                                                  height: 0,
                                                                                ),
                                                                              ),
                                                                              Obx(() {
                                                                                return Container(
                                                                                  margin: const EdgeInsets.symmetric(vertical: 15),
                                                                                  child: Wrap(
                                                                                    spacing: 10,
                                                                                    children: List.generate(cropSugestionController.cropData.value.result!.length, (index) {
                                                                                      final cropId = cropSugestionController.cropData.value.result![index].id;
                                                                                      bool isSelected = cropId != null && updateLand.crops.contains(cropId.toInt());

                                                                                      return InkWell(
                                                                                        onTap: () {
                                                                                          if (cropId != null) {
                                                                                            if (isSelected) {
                                                                                              updateLand.crops.remove(cropId);
                                                                                            } else {
                                                                                              updateLand.crops.add(cropId);
                                                                                            }
                                                                                          }
                                                                                        },
                                                                                        child: AnimatedContainer(
                                                                                          margin: const EdgeInsets.symmetric(vertical: 5),
                                                                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), border: isSelected ? Border.all(color: AppColor.DARK_GREEN) : Border.all(color: AppColor.GREY_BORDER), gradient: isSelected ? AppColor.PRIMARY_GRADIENT : AppColor.WHITE_GRADIENT),
                                                                                          duration: const Duration(milliseconds: 10),
                                                                                          child: Text(cropSugestionController.cropData.value.result![index].name.toString()),
                                                                                        ),
                                                                                      );
                                                                                    }),
                                                                                  ),
                                                                                );
                                                                              }),
                                                                            ],
                                                                          )
                                                                        : Container(),
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        updateLand.isLandFarm.value
                                                                            ? await updateLand.updateCropData()
                                                                            : await updateLand.updateCrop();
                                                                        Future.delayed(
                                                                            const Duration(milliseconds: 500),
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => LandDetails(
                                                                                  id: widget.landId,
                                                                                ),
                                                                              ));
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                          margin: EdgeInsets.only(left: Get.width * 0.5),
                                                                          padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                13,
                                                                            horizontal:
                                                                                40,
                                                                          ),
                                                                          decoration: ShapeDecoration(
                                                                            color:
                                                                                AppColor.DARK_GREEN,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                          child: updateLand.croploading.value
                                                                              ? Container(
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                                                                  height: 15,
                                                                                  width: 15,
                                                                                  child: const CircularProgressIndicator(
                                                                                    color: Colors.white,
                                                                                    strokeWidth: 3,
                                                                                  ),
                                                                                )
                                                                              : const Text(
                                                                                  'Save',
                                                                                  style: TextStyle(
                                                                                    color: Color(0xFFFBFBFB),
                                                                                    fontSize: 12,
                                                                                    fontFamily: 'Poppins',
                                                                                    fontWeight: FontWeight.w600,
                                                                                    height: 0,
                                                                                  ),
                                                                                )),
                                                                    )
                                                                  ],
                                                                ),
                                                              ));
                                                        },
                                                        child: ListTile(
                                                          trailing: const Icon(Icons
                                                              .arrow_drop_down),
                                                          leading:
                                                              SvgPicture.asset(
                                                            "assets/farm/farm.svg",
                                                            width: 30,
                                                          ),
                                                          title: Text(
                                                            'Is this land previously cultivated?',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: AppColor
                                                                  .DARK_GREEN,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          subtitle: Row(
                                                            children: [
                                                              Text(
                                                                " ${controller.landDetailsData.value.result?.landFarmedBefore == true ? 'yes, ' : 'N/A '}",
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: const Color(
                                                                      0xA3044D3A),
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 0,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                                width: Get.size
                                                                        .width *
                                                                    0.5,
                                                                child: ListView
                                                                    .builder(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemCount: controller
                                                                      .landDetailsData
                                                                      .value
                                                                      .result!
                                                                      .cropsGrown!
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    final crop = controller
                                                                        .landDetailsData
                                                                        .value
                                                                        .result!
                                                                        .cropsGrown![index];
                                                                    return Text(
                                                                      " ${crop.name ?? ""},",
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: const Color(
                                                                            0xA3044D3A),
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color:
                                                            Color(0xFFE6E6E6),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          showEditLandDialog(
                                                              context,
                                                              0.4,
                                                              Container(
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        20),
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        15),
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
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      margin: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              8),
                                                                      child:
                                                                          Text(
                                                                        'Is there road access to the land?',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              const Color(0xFF272727),
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: List.generate(
                                                                          450 ~/ 4,
                                                                          (index) => Expanded(
                                                                                child: Container(
                                                                                  margin: const EdgeInsets.symmetric(vertical: 12),
                                                                                  color: index % 2 == 0 ? Colors.transparent : AppColor.GREY_BORDER,
                                                                                  height: 1,
                                                                                ),
                                                                              )),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Obx(
                                                                          () =>
                                                                              SizedBox(
                                                                            width:
                                                                                AppDimension.w * 0.4,
                                                                            child:
                                                                                RadioListTile<bool>(
                                                                              activeColor: AppColor.DARK_GREEN,
                                                                              title: Text(
                                                                                'Yes',
                                                                                style: GoogleFonts.poppins(
                                                                                  color: const Color(0xFF333333),
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                              value: true,
                                                                              groupValue: updateLand.isRoadAvailable.value,
                                                                              onChanged: (value) {
                                                                                updateLand.isRoadAvailable.value = value!;
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Obx(
                                                                          () =>
                                                                              Expanded(
                                                                            child:
                                                                                RadioListTile<bool>(
                                                                              title: Text(
                                                                                'No',
                                                                                style: GoogleFonts.poppins(
                                                                                  color: const Color(0xFF333333),
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                              value: false,
                                                                              activeColor: AppColor.DARK_GREEN,
                                                                              groupValue: updateLand.isRoadAvailable.value,
                                                                              onChanged: (value) {
                                                                                updateLand.isRoadAvailable.value = value!;
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        await updateLand
                                                                            .roadAvailable();

                                                                        Future.delayed(
                                                                            const Duration(milliseconds: 500),
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => LandDetails(
                                                                                  id: widget.landId,
                                                                                ),
                                                                              ));
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                          margin: EdgeInsets.only(left: Get.width * 0.5),
                                                                          padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                13,
                                                                            horizontal:
                                                                                40,
                                                                          ),
                                                                          decoration: ShapeDecoration(
                                                                            color:
                                                                                AppColor.DARK_GREEN,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                          child: updateLand.roadloading.value
                                                                              ? Container(
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                                                                  height: 15,
                                                                                  width: 15,
                                                                                  child: const CircularProgressIndicator(
                                                                                    color: Colors.white,
                                                                                    strokeWidth: 3,
                                                                                  ),
                                                                                )
                                                                              : const Text(
                                                                                  'Save',
                                                                                  style: TextStyle(
                                                                                    color: Color(0xFFFBFBFB),
                                                                                    fontSize: 12,
                                                                                    fontFamily: 'Poppins',
                                                                                    fontWeight: FontWeight.w600,
                                                                                    height: 0,
                                                                                  ),
                                                                                )),
                                                                    )
                                                                  ],
                                                                ),
                                                              ));
                                                        },
                                                        child: ListTile(
                                                          trailing: const Icon(Icons
                                                              .arrow_drop_down),
                                                          leading:
                                                              SvgPicture.asset(
                                                            "assets/farm/road.svg",
                                                            width: 30,
                                                          ),
                                                          title: Text(
                                                            'Road access',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: AppColor
                                                                  .DARK_GREEN,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                            updateLand.isRoadAvailable
                                                                        .value ==
                                                                    true
                                                                ? "yes"
                                                                : controller
                                                                            .landDetailsData
                                                                            .value
                                                                            .result
                                                                            ?.roadAccess ==
                                                                        false
                                                                    ? 'No'
                                                                    : controller.landDetailsData.value.result?.roadAccess ==
                                                                            true
                                                                        ? "yes"
                                                                        : "N/A",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: const Color(
                                                                  0xA3044D3A),
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color:
                                                            Color(0xFFE6E6E6),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          showEditLandDialog(
                                                            context,
                                                            0.5,
                                                            Obx(
                                                              () {
                                                                return Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          20),
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          15),
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
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child:
                                                                            Text(
                                                                          'Is this property certified organic, or does it qualify for organic certification under federal organic regulations?',
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            color:
                                                                                const Color(0xFF272727),
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: List.generate(
                                                                            450 ~/ 4,
                                                                            (index) => Expanded(
                                                                                  child: Container(
                                                                                    margin: const EdgeInsets.symmetric(vertical: 12),
                                                                                    color: index % 2 == 0 ? Colors.transparent : AppColor.GREY_BORDER,
                                                                                    height: 1,
                                                                                  ),
                                                                                )),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Obx(
                                                                            () =>
                                                                                SizedBox(
                                                                              width: AppDimension.w * 0.4,
                                                                              child: RadioListTile<bool>(
                                                                                activeColor: AppColor.DARK_GREEN,
                                                                                title: Text(
                                                                                  'Yes',
                                                                                  style: GoogleFonts.poppins(
                                                                                    color: const Color(0xFF333333),
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                                value: true,
                                                                                groupValue: updateLand.isCertified.value,
                                                                                onChanged: (value) {
                                                                                  updateLand.isCertified.value = value!;
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Obx(
                                                                            () =>
                                                                                Expanded(
                                                                              child: RadioListTile<bool>(
                                                                                title: Text(
                                                                                  'No',
                                                                                  style: GoogleFonts.poppins(
                                                                                    color: const Color(0xFF333333),
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                                value: false,
                                                                                activeColor: AppColor.DARK_GREEN,
                                                                                groupValue: updateLand.isCertified.value,
                                                                                onChanged: (value) {
                                                                                  updateLand.isCertified.value = value!;
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      updateLand
                                                                              .isCertified
                                                                              .value
                                                                          ? updateLand.selectedPdf.value != null
                                                                              ? Stack(
                                                                                  children: [
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        updateLand.pickPdf();
                                                                                      },
                                                                                      child: Container(
                                                                                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(18),
                                                                                          border: Border.all(color: AppColor.GREY_BORDER),
                                                                                        ),
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          children: [
                                                                                            Container(
                                                                                                margin: const EdgeInsets.only(top: 20),
                                                                                                child: SvgPicture.asset(
                                                                                                  "assets/logos/doc.svg",
                                                                                                  width: 30,
                                                                                                )),
                                                                                            Container(
                                                                                              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                                                                              child: Text(
                                                                                                updateLand.selectedPdf.value?.path != null ? updateLand.selectedPdf.value!.path.split('/').last : '',
                                                                                                style: GoogleFonts.poppins(
                                                                                                  color: const Color(0xFF283037),
                                                                                                  fontSize: 10,
                                                                                                  fontWeight: FontWeight.w400,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Positioned(
                                                                                      top: 0,
                                                                                      right: 0,
                                                                                      child: InkWell(
                                                                                        onTap: () {
                                                                                          updateLand.removeCertificate();
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 28,
                                                                                          padding: const EdgeInsets.all(4),
                                                                                          decoration: const BoxDecoration(
                                                                                            shape: BoxShape.circle,
                                                                                            color: Color.fromARGB(255, 244, 67, 54),
                                                                                          ),
                                                                                          child: const Icon(
                                                                                            Icons.close,
                                                                                            color: Colors.white,
                                                                                            size: 18,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : InkWell(
                                                                                  onTap: () {
                                                                                    updateLand.pickPdf();
                                                                                  },
                                                                                  child: Container(
                                                                                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(18),
                                                                                      border: Border.all(color: AppColor.GREY_BORDER),
                                                                                    ),
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                            margin: const EdgeInsets.symmetric(vertical: 10),
                                                                                            child: SvgPicture.asset(
                                                                                              "assets/logos/doc.svg",
                                                                                              width: 30,
                                                                                            )),
                                                                                        Container(
                                                                                          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                                                                          child: Text(
                                                                                            "Browse document\n",
                                                                                            style: GoogleFonts.poppins(
                                                                                              color: const Color(0xFF283037),
                                                                                              fontSize: 10,
                                                                                              fontWeight: FontWeight.w400,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          margin: const EdgeInsets.only(bottom: 15),
                                                                                          child: Text(
                                                                                            "to Upload",
                                                                                            style: GoogleFonts.poppins(
                                                                                              color: const Color(0xFF6E7B89),
                                                                                              fontSize: 10,
                                                                                              height: -0.07,
                                                                                              fontWeight: FontWeight.w400,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                          : Container(),
                                                                      InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          updateLand.isCertified.value
                                                                              ? await updateLand.selectedPDF()
                                                                              : await updateLand.certificationValue();
                                                                          Future.delayed(
                                                                              const Duration(milliseconds: 500),
                                                                              () {
                                                                            Navigator.pop(context);
                                                                            Navigator.pop(context);
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => LandDetails(
                                                                                    id: widget.landId,
                                                                                  ),
                                                                                ));
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              EdgeInsets.only(left: Get.width * 0.5),
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 13,
                                                                              horizontal: 40),
                                                                          decoration:
                                                                              ShapeDecoration(
                                                                            color:
                                                                                AppColor.DARK_GREEN,
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                          ),
                                                                          child: updateLand.pdfloading.value
                                                                              ? Container(
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                                                                  height: 15,
                                                                                  width: 15,
                                                                                  child: const CircularProgressIndicator(
                                                                                    color: Colors.white,
                                                                                    strokeWidth: 3,
                                                                                  ),
                                                                                )
                                                                              : const Text(
                                                                                  'Save',
                                                                                  style: TextStyle(
                                                                                    color: Color(0xFFFBFBFB),
                                                                                    fontSize: 12,
                                                                                    fontFamily: 'Poppins',
                                                                                    fontWeight: FontWeight.w600,
                                                                                    height: 0,
                                                                                  ),
                                                                                ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                        child: ListTile(
                                                          trailing: const Icon(Icons
                                                              .arrow_drop_down),
                                                          leading:
                                                              SvgPicture.asset(
                                                            "assets/farm/compost.svg",
                                                            width: 30,
                                                          ),
                                                          title: Text(
                                                            'Organic Farm Certified',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: AppColor
                                                                  .DARK_GREEN,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                            controller
                                                                        .landDetailsData
                                                                        .value
                                                                        .result
                                                                        ?.organicCertification ==
                                                                    true
                                                                ? 'yes '
                                                                : 'N/A ',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: const Color(
                                                                  0xA3044D3A),
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color:
                                                            Color(0xFFE6E6E6),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          showEditLandDialog(
                                                            context,
                                                            0.6,
                                                            Obx(() {
                                                              return Container(
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        20),
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        15),
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
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        'Are there water sources available?',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              const Color(0xFF272727),
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: List.generate(
                                                                          450 ~/ 4,
                                                                          (index) => Expanded(
                                                                                child: Container(
                                                                                  margin: const EdgeInsets.symmetric(vertical: 12),
                                                                                  color: index % 2 == 0 ? Colors.transparent : AppColor.GREY_BORDER,
                                                                                  height: 1,
                                                                                ),
                                                                              )),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Obx(
                                                                            () =>
                                                                                RadioListTile(
                                                                              contentPadding: const EdgeInsets.all(0),
                                                                              activeColor: AppColor.DARK_GREEN,
                                                                              title: Text(
                                                                                'Available',
                                                                                style: GoogleFonts.poppins(
                                                                                  color: const Color(0xFF333333),
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                              value: true,
                                                                              groupValue: updateLand.isWaterAvailable.value,
                                                                              onChanged: (value) {
                                                                                updateLand.isWaterAvailable.value = value!;
                                                                                print(updateLand.isWaterAvailable.value);
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Obx(
                                                                            () =>
                                                                                RadioListTile(
                                                                              contentPadding: const EdgeInsets.all(0),
                                                                              title: Text(
                                                                                'Unavailable',
                                                                                style: GoogleFonts.poppins(
                                                                                  color: const Color(0xFF333333),
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                              value: false,
                                                                              activeColor: AppColor.DARK_GREEN,
                                                                              groupValue: updateLand.isWaterAvailable.value,
                                                                              onChanged: (value) {
                                                                                updateLand.isWaterAvailable.value = value!;
                                                                                print(updateLand.isWaterAvailable.value);
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Obx(() =>
                                                                        Visibility(
                                                                          visible: updateLand
                                                                              .isWaterAvailable
                                                                              .value,
                                                                          child:
                                                                              Wrap(
                                                                            spacing:
                                                                                10,
                                                                            runSpacing:
                                                                                10,
                                                                            children:
                                                                                List.generate(
                                                                              waterController.waterResource.value.result?.length ?? 0,
                                                                              (index) {
                                                                                final waterResource = waterController.waterResource.value.result![index];
                                                                                return InkWell(
                                                                                  onTap: () {
                                                                                    updateLand.waterId.value = waterResource.id!.toInt(); // Assign actual id
                                                                                    updateLand.waterResource.value = waterResource.id.toString();
                                                                                    print("======================================================================${updateLand.waterResource.value}");
                                                                                  },
                                                                                  child: Container(
                                                                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                                                    decoration: BoxDecoration(
                                                                                      gradient: updateLand.waterId.value == waterResource.id ? AppColor.PRIMARY_GRADIENT : AppColor.WHITE_GRADIENT,
                                                                                      borderRadius: BorderRadius.circular(30),
                                                                                      border: Border.all(
                                                                                        color: updateLand.waterId.value == waterResource.id ? AppColor.DARK_GREEN : AppColor.GREY_BORDER,
                                                                                      ),
                                                                                    ),
                                                                                    child: Text(
                                                                                      waterResource.name ?? "",
                                                                                      style: GoogleFonts.poppins(
                                                                                        color: AppColor.DARK_GREEN,
                                                                                        fontSize: 12,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        )),
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        updateLand.isWaterAvailable.value
                                                                            ? await updateLand.updateWaterResource()
                                                                            : await updateLand.updateWaterisAvailable();
                                                                        Future.delayed(
                                                                            const Duration(milliseconds: 500),
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => LandDetails(
                                                                                  id: widget.landId,
                                                                                ),
                                                                              ));
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                          margin: EdgeInsets.only(left: Get.width * 0.5, top: 10),
                                                                          padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                13,
                                                                            horizontal:
                                                                                40,
                                                                          ),
                                                                          decoration: ShapeDecoration(
                                                                            color:
                                                                                AppColor.DARK_GREEN,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                          child: updateLand.waterloading.value
                                                                              ? Container(
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                                                                  height: 15,
                                                                                  width: 15,
                                                                                  child: const CircularProgressIndicator(
                                                                                    color: Colors.white,
                                                                                    strokeWidth: 3,
                                                                                  ),
                                                                                )
                                                                              : const Text(
                                                                                  'Save',
                                                                                  style: TextStyle(
                                                                                    color: Color(0xFFFBFBFB),
                                                                                    fontSize: 12,
                                                                                    fontFamily: 'Poppins',
                                                                                    fontWeight: FontWeight.w600,
                                                                                    height: 0,
                                                                                  ),
                                                                                )),
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                          );
                                                        },
                                                        child: ListTile(
                                                          trailing: const Icon(Icons
                                                              .arrow_drop_down),
                                                          leading:
                                                              SvgPicture.asset(
                                                            "assets/farm/sea.svg",
                                                            width: 30,
                                                          ),
                                                          title: Text(
                                                            'Water Sources Available?',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: AppColor
                                                                  .DARK_GREEN,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                            controller
                                                                        .landDetailsData
                                                                        .value
                                                                        .result!
                                                                        .waterSourceAvailable ==
                                                                    true
                                                                ? '${controller.landDetailsData.value.result?.waterSource!.name} '
                                                                : 'N/A ',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: const Color(
                                                                  0xA3044D3A),
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color:
                                                            Color(0xFFE6E6E6),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          showEditLandDialog(
                                                            context,
                                                            0.5,
                                                            Obx(() {
                                                              return Container(
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        20),
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        15),
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
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        'Do you have any equipment/machines available at your land for farming?',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              const Color(0xFF272727),
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: List.generate(
                                                                          450 ~/ 4,
                                                                          (index) => Expanded(
                                                                                child: Container(
                                                                                  margin: const EdgeInsets.symmetric(vertical: 12),
                                                                                  color: index % 2 == 0 ? Colors.transparent : AppColor.GREY_BORDER,
                                                                                  height: 1,
                                                                                ),
                                                                              )),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Obx(
                                                                            () =>
                                                                                RadioListTile<bool>(
                                                                              contentPadding: const EdgeInsets.all(0),
                                                                              activeColor: AppColor.DARK_GREEN,
                                                                              title: Text(
                                                                                'Available',
                                                                                style: GoogleFonts.poppins(
                                                                                  color: const Color(0xFF333333),
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                              value: true,
                                                                              groupValue: updateLand.isEquipmentAvailable.value,
                                                                              onChanged: (value) {
                                                                                updateLand.isEquipmentAvailable.value = value!;
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Obx(
                                                                            () =>
                                                                                RadioListTile<bool>(
                                                                              contentPadding: const EdgeInsets.all(0),
                                                                              title: Text(
                                                                                'Unavailable',
                                                                                style: GoogleFonts.poppins(
                                                                                  color: const Color(0xFF333333),
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                              value: false,
                                                                              activeColor: AppColor.DARK_GREEN,
                                                                              groupValue: updateLand.isEquipmentAvailable.value,
                                                                              onChanged: (value) {
                                                                                updateLand.isEquipmentAvailable.value = value!;
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Visibility(
                                                                      visible: updateLand
                                                                          .isEquipmentAvailable
                                                                          .value,
                                                                      child:
                                                                          Container(
                                                                        margin: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                15),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          border:
                                                                              Border.all(color: AppColor.GREY_BORDER),
                                                                          boxShadow: [
                                                                            AppColor.BOX_SHADOW
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(18),
                                                                        ),
                                                                        child:
                                                                            Form(
                                                                          key:
                                                                              _equipmentKey,
                                                                          child:
                                                                              TextFormField(
                                                                            controller:
                                                                                updateLand.equipmentController.value,
                                                                            validator:
                                                                                (value) {
                                                                              if (value!.isEmpty) {
                                                                                return 'Please enter the value';
                                                                              }
                                                                              return "";
                                                                            },
                                                                            decoration: InputDecoration(
                                                                                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                                                                hintText: "What’s available?",
                                                                                hintStyle: GoogleFonts.poppins(
                                                                                  color: const Color(0x994F4F4F),
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  height: 0.10,
                                                                                ),
                                                                                border: InputBorder.none),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        updateLand.isEquipmentAvailable.value
                                                                            ? _equipmentKey.currentState!.validate()
                                                                            : "";
                                                                        updateLand.isEquipmentAvailable.value
                                                                            ? await updateLand.updateEquipmentAvailable()
                                                                            : await updateLand.isequipmentAvailable();
                                                                        Future.delayed(
                                                                            const Duration(milliseconds: 500),
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => LandDetails(
                                                                                  id: widget.landId,
                                                                                ),
                                                                              ));
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                          margin: EdgeInsets.only(left: Get.width * 0.5),
                                                                          padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                13,
                                                                            horizontal:
                                                                                40,
                                                                          ),
                                                                          decoration: ShapeDecoration(
                                                                            color:
                                                                                AppColor.DARK_GREEN,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                          child: updateLand.equipmentloading.value
                                                                              ? Container(
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                                                                  height: 15,
                                                                                  width: 15,
                                                                                  child: const CircularProgressIndicator(
                                                                                    color: Colors.white,
                                                                                    strokeWidth: 3,
                                                                                  ),
                                                                                )
                                                                              : const Text(
                                                                                  'Save',
                                                                                  style: TextStyle(
                                                                                    color: Color(0xFFFBFBFB),
                                                                                    fontSize: 12,
                                                                                    fontFamily: 'Poppins',
                                                                                    fontWeight: FontWeight.w600,
                                                                                    height: 0,
                                                                                  ),
                                                                                )),
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                          );
                                                        },
                                                        child: ListTile(
                                                          trailing: const Icon(Icons
                                                              .arrow_drop_down),
                                                          leading:
                                                              SvgPicture.asset(
                                                            "assets/farm/engineering.svg",
                                                            width: 30,
                                                          ),
                                                          title: Text(
                                                            'Equipment & Machinery Available',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: AppColor
                                                                  .DARK_GREEN,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          subtitle: controller
                                                                      .landDetailsData
                                                                      .value
                                                                      .result!
                                                                      .equipmentAvailable ==
                                                                  true
                                                              ? Text(
                                                                  controller
                                                                          .landDetailsData
                                                                          .value
                                                                          .result!
                                                                          .equipment!
                                                                          .isEmpty
                                                                      ? 'Available'
                                                                      : controller
                                                                          .landDetailsData
                                                                          .value
                                                                          .result!
                                                                          .equipment!,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: const Color(
                                                                        0xA3044D3A),
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  'N/A',
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: const Color(
                                                                        0xA3044D3A),
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color:
                                                            Color(0xFFE6E6E6),
                                                      ),
                                                      // ListTile(
                                                      //   leading: SvgPicture.asset(
                                                      //     "assets/farm/time.svg",
                                                      //     width: 30,
                                                      //   ),
                                                      //   title: Text(
                                                      //     'Property Availability Tenure',
                                                      //     style: GoogleFonts.poppins(
                                                      //       color: AppColor.DARK_GREEN,
                                                      //       fontSize: 11,
                                                      //       fontWeight: FontWeight.w600,
                                                      //     ),
                                                      //   ),
                                                      //   subtitle: Text(
                                                      //     '3 Years',
                                                      //     style: GoogleFonts.poppins(
                                                      //       color: Color(0xA3044D3A),
                                                      //       fontSize: 10,
                                                      //       fontWeight: FontWeight.w500,
                                                      //       height: 0,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      // Divider(
                                                      //   color: Color(0xFFE6E6E6),
                                                      // ),
                                                      // ListTile(
                                                      //   leading: SvgPicture.asset(
                                                      //     "assets/farm/location.svg",
                                                      //     width: 30,
                                                      //   ),
                                                      //   title: Text(
                                                      //     'Property Available for cultivation from',
                                                      //     style: GoogleFonts.poppins(
                                                      //       color: AppColor.DARK_GREEN,
                                                      //       fontSize: 11,
                                                      //       fontWeight: FontWeight.w600,
                                                      //     ),
                                                      //   ),
                                                      //   subtitle: Text(
                                                      //     '31 Oct 2024',
                                                      //     style: GoogleFonts.poppins(
                                                      //       color: Color(0xA3044D3A),
                                                      //       fontSize: 10,
                                                      //       fontWeight: FontWeight.w500,
                                                      //       height: 0,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      // Divider(
                                                      //   color: Color(0xFFE6E6E6),
                                                      // ),
                                                      ListTile(
                                                          leading:
                                                              SvgPicture.asset(
                                                            "assets/farm/file.svg",
                                                            width: 30,
                                                          ),
                                                          title: Text(
                                                            'Supporting Documents',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: AppColor
                                                                  .DARK_GREEN,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          subtitle: landController
                                                                      .landData
                                                                      .value
                                                                      .result
                                                                      ?.isOrganicCertificationAdded ==
                                                                  false
                                                              ? Text(
                                                                  "Not Uploaded",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: const Color(
                                                                        0xA3044D3A),
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                )
                                                              : InkWell(
                                                                  onTap: () {
                                                                    Get.to(() =>
                                                                        PdfViewer(
                                                                          pdfUrl:
                                                                              controller.landDetailsData.value.result!.certificationDocumnet ?? "",
                                                                        ));
                                                                  },
                                                                  child: Text(
                                                                    "view",
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: const Color(
                                                                          0xA3044D3A),
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                      height: 0,
                                                                    ),
                                                                  ),
                                                                )),
                                                    ],
                                                  ))
                                                : Container();
                                          }),
                                          Row(
                                            children: List.generate(
                                                450 ~/ 4,
                                                (index) => Expanded(
                                                      child: Container(
                                                        color: index % 2 == 0
                                                            ? Colors.transparent
                                                            : AppColor
                                                                .GREY_BORDER,
                                                        height: 1,
                                                      ),
                                                    )),
                                          ),
                                          Obx(() {
                                            return controller.isvissible.value
                                                ? Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          controller.isvissible
                                                              .value = false;
                                                        },
                                                        child: const Text(
                                                          'View Less',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF044D3A),
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            controller
                                                                .isvissible
                                                                .value = false;
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .keyboard_arrow_up_rounded,
                                                            size: 20,
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                          ))
                                                    ],
                                                  )
                                                : Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          controller.isvissible
                                                              .value = true;
                                                        },
                                                        child: const Text(
                                                          'View More',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF044D3A),
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            controller
                                                                .isvissible
                                                                .value = true;
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .keyboard_arrow_down_rounded,
                                                            size: 20,
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                          ))
                                                    ],
                                                  );
                                          })
                                        ],
                                      ),
                                    );
                                  }),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 15),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 20),
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(12),
                                                              topRight: Radius
                                                                  .circular(12),
                                                            )),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Distance Filter",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        1000),
                                                                () {
                                                              Navigator.pop(
                                                                  context);
                                                              Navigator.pop(
                                                                  context);
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            LandDetails(
                                                                      id: widget
                                                                          .landId,
                                                                    ),
                                                                  ));
                                                            });
                                                          },
                                                          child:
                                                              const CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                Colors.white,
                                                            child: Icon(
                                                              Icons.close,
                                                              color: AppColor
                                                                  .DARK_GREEN,
                                                              size: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Distance",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColor
                                                                      .BROWN_TEXT),
                                                        ),
                                                        Obx(() => Text(
                                                              "${controller.currentDistance.value} km",
                                                              style: GoogleFonts.poppins(
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
                                                  const SizedBox(height: 20),
                                                  Obx(
                                                    () => Slider(
                                                      value: controller
                                                          .currentDistance.value
                                                          .toDouble(),
                                                      min: 100,
                                                      max: 1000,
                                                      divisions: (1000 - 100) ~/
                                                          50, // Calculate divisions
                                                      label:
                                                          "${controller.currentDistance.value} km",
                                                      onChanged: (value) {
                                                        controller
                                                            .updateDistance(
                                                                value);
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  GestureDetector(
                                                    onTap: () {
                                                      farmerController
                                                          .matchingFarmer(
                                                              controller
                                                                  .currentDistance
                                                                  .value);
                                                      agriController.getAgriData(
                                                          controller
                                                              .currentDistance
                                                              .value);

                                                      Future.delayed(
                                                          const Duration(
                                                              milliseconds:
                                                                  1000), () {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      LandDetails(
                                                                id: widget
                                                                    .landId,
                                                              ),
                                                            ));
                                                      });
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 10,
                                                      ),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      decoration:
                                                          ShapeDecoration(
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Apply Filter ',
                                                          style: GoogleFonts
                                                              .poppins(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/img/filter.svg"),
                                            Text(
                                              "  Distance Filter",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.BROWN_TEXT,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${controller.currentDistance.value.toString()} Km",
                                          style: GoogleFonts.poppins(
                                            color: AppColor.DARK_GREEN,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Matching Farmers',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF483C32),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          farmerController.matchingFarmerData
                                                      .value.result?.count !=
                                                  0
                                              ? InkWell(
                                                  onTap: () {
                                                    Get.to(() => MatchingFarmer(
                                                          id: controller
                                                              .landId.value,
                                                        ));
                                                  },
                                                  child: Text(
                                                    'View all (${farmerController.matchingFarmerData.value.result?.count ?? 0}) ',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF044D3A),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      )
                                    ],
                                  ),
                                  farmerController
                                              .matchingFarmerData
                                              .value
                                              .result
                                              ?.matchingFarmerList
                                              ?.length !=
                                          0
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 20,
                                          ),
                                          height: Get.height * 0.14,
                                          child: ListView.builder(
                                              itemCount: farmerController
                                                      .matchingFarmerData
                                                      .value
                                                      .result
                                                      ?.matchingFarmerList
                                                      ?.length ??
                                                  0,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Get.to(() => UserProfileScreen(
                                                        id: farmerController
                                                                .matchingFarmerData
                                                                .value
                                                                .result
                                                                ?.matchingFarmerList?[
                                                                    index]
                                                                .userId
                                                                ?.toInt() ??
                                                            0,
                                                        userType: farmerController
                                                                .matchingFarmerData
                                                                .value
                                                                .result
                                                                ?.matchingFarmerList?[
                                                                    index]
                                                                .userType ??
                                                            ""));
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    width: Get.width * 0.8,
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
                                                        InkWell(
                                                          onTap: () {
                                                            Get.to(() => UserProfileScreen(
                                                                id: farmerController
                                                                        .matchingFarmerData
                                                                        .value
                                                                        .result
                                                                        ?.matchingFarmerList?[
                                                                            index]
                                                                        .userId
                                                                        ?.toInt() ??
                                                                    0,
                                                                userType: farmerController
                                                                        .matchingFarmerData
                                                                        .value
                                                                        .result
                                                                        ?.matchingFarmerList?[
                                                                            index]
                                                                        .userType ??
                                                                    ""));
                                                          },
                                                          //farmerController.farmerData
                                                          child: Container(
                                                            width: Get.width *
                                                                0.25,
                                                            height: Get.height *
                                                                0.16,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColor
                                                                  .DARK_GREEN
                                                                  .withOpacity(
                                                                      0.1),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        18),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        18),
                                                              ),
                                                              image: farmerController
                                                                              .matchingFarmerData
                                                                              .value
                                                                              .result
                                                                              ?.matchingFarmerList?[
                                                                                  index]
                                                                              .image !=
                                                                          null &&
                                                                      farmerController
                                                                              .matchingFarmerData
                                                                              .value
                                                                              .result
                                                                              ?.matchingFarmerList?[index]
                                                                              .image !=
                                                                          ""
                                                                  ? DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        farmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].image! ??
                                                                            "",
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : null, // Only apply image if it exists
                                                            ),
                                                            child: farmerController
                                                                            .matchingFarmerData
                                                                            .value
                                                                            .result
                                                                            ?.matchingFarmerList?[
                                                                                index]
                                                                            .image ==
                                                                        null ||
                                                                    farmerController
                                                                            .matchingFarmerData
                                                                            .value
                                                                            .result
                                                                            ?.matchingFarmerList?[index]
                                                                            .image ==
                                                                        ""
                                                                ? Center(
                                                                    child: Text(
                                                                      farmerController
                                                                              .matchingFarmerData
                                                                              .value
                                                                              .result
                                                                              ?.matchingFarmerList?[index]
                                                                              .fullName![0]
                                                                              .toUpperCase() ??
                                                                          "",
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            50,
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
                                                        // Container(
                                                        //     width: Get.width * 0.24,
                                                        //     decoration: BoxDecoration(
                                                        //         image: DecorationImage(
                                                        //             image: NetworkImage(
                                                        //                 "${farmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].image ?? ""}"),
                                                        //             fit: BoxFit.cover),
                                                        //         color: Colors.black,
                                                        //         borderRadius:
                                                        //             BorderRadius.only(
                                                        //                 bottomLeft: Radius
                                                        //                     .circular(
                                                        //                         18),
                                                        //                 topLeft: Radius
                                                        //                     .circular(
                                                        //                         18)))),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Text(
                                                                farmerController
                                                                        .matchingFarmerData
                                                                        .value
                                                                        .result
                                                                        ?.matchingFarmerList?[
                                                                            index]
                                                                        .fullName ??
                                                                    "",
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: AppColor
                                                                      .BROWN_TEXT,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    "assets/farm/locationbrown.svg",
                                                                    width: 14,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        Get.width *
                                                                            0.44,
                                                                    child: Text(
                                                                      '  ${farmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].livesIn ?? ""}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: const Color(
                                                                            0xFF61646B),
                                                                        fontSize:
                                                                            8,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    "assets/farm/brownPort.svg",
                                                                    width: 14,
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            5),
                                                                    height: 20,
                                                                    width:
                                                                        Get.width *
                                                                            0.4,
                                                                    child: ListView.builder(
                                                                        scrollDirection: Axis.horizontal,
                                                                        itemCount: farmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].expertise!.length ?? 0,
                                                                        itemBuilder: (context, experties) {
                                                                          return Container(
                                                                            margin:
                                                                                const EdgeInsets.symmetric(horizontal: 5),
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 8),
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color(0x14167C0C)),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                farmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].expertise![experties].name ?? "",
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
                                                                  Get.to(() =>
                                                                      ChatScreen(
                                                                        landId: controller
                                                                            .landId
                                                                            .value,
                                                                        enquiryId:
                                                                            farmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].enquiryId?.toInt() ??
                                                                                0,
                                                                        userId:
                                                                            farmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].userId?.toInt() ??
                                                                                0,
                                                                        userType:
                                                                            farmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].userType ??
                                                                                "",
                                                                        userFrom:
                                                                            farmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].livesIn ??
                                                                                "",
                                                                        userName:
                                                                            farmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].fullName ??
                                                                                "",
                                                                        image: farmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].image ??
                                                                            "",
                                                                        isEnquiryCreatedByMe:
                                                                            false,
                                                                        isEnquiryDisplay:
                                                                            false,
                                                                        enquiryData:
                                                                            "",
                                                                      ));
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    left: 60,
                                                                  ),
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          4),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    border: Border.all(
                                                                        color: AppColor
                                                                            .DARK_GREEN,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      const Row(
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
                                                                        size:
                                                                            15,
                                                                      ),
                                                                      Text(
                                                                        '  Contact Farmer',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFF044D3A),
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
                                              }),
                                        )
                                      : Obx(() {
                                          return farmerController
                                                  .showAnimation.value
                                              ? Lottie.asset(
                                                  "assets/lotties/animation.json",
                                                  height: 100,
                                                  width: double.infinity,
                                                )
                                              : const Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 30.0,
                                                            horizontal: 10),
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      "Use Distance filter to see matching farmers near you",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                  ),
                                                );
                                        }),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Matching Partners',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF483C32),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          agriController.agriProviderData.value
                                                      .result?.count !=
                                                  0
                                              ? InkWell(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        MatchingAgriProvider(
                                                          id: controller
                                                              .landId.value,
                                                        ));
                                                  },
                                                  child: Text(
                                                    'View all (${agriController.agriProviderData.value.result?.count}) ',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF044D3A),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      )
                                    ],
                                  ),
                                  agriController
                                              .agriProviderData
                                              .value
                                              .result
                                              ?.matchingAgriServiceProviders
                                              ?.length !=
                                          0
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          height: Get.height * 0.14,
                                          child: ListView.builder(
                                              itemCount: agriController
                                                      .agriProviderData
                                                      .value
                                                      .result
                                                      ?.matchingAgriServiceProviders
                                                      ?.length ??
                                                  0,
                                              scrollDirection: Axis.horizontal,
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
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    width: AppDimension.w * 0.8,
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
                                                          //farmerController.farmerData
                                                          child: Container(
                                                            width: Get.width *
                                                                0.25,
                                                            height: Get.height *
                                                                0.16,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColor
                                                                  .DARK_GREEN
                                                                  .withOpacity(
                                                                      0.1),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        18),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        18),
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
                                                                              ?.matchingAgriServiceProviders?[index]
                                                                              .image !=
                                                                          ""
                                                                  ? DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        agriController.agriProviderData.value.result?.matchingAgriServiceProviders?[index].image! ??
                                                                            "",
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
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
                                                                    null
                                                                ? Center(
                                                                    child: Text(
                                                                      agriController
                                                                              .agriProviderData
                                                                              .value
                                                                              .result
                                                                              ?.matchingAgriServiceProviders?[index]
                                                                              .fullName![0]
                                                                              .toUpperCase() ??
                                                                          "",
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            50,
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
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Text(
                                                                agriController
                                                                        .agriProviderData
                                                                        .value
                                                                        .result
                                                                        ?.matchingAgriServiceProviders?[
                                                                            index]
                                                                        .fullName ??
                                                                    "",
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
                                                              Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    "assets/farm/locationbrown.svg",
                                                                    width: 14,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        Get.width *
                                                                            0.45,
                                                                    child: Text(
                                                                      '  ${agriController.agriProviderData.value.result?.matchingAgriServiceProviders?[index].livesIn ?? ""}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: const Color(
                                                                            0xFF61646B),
                                                                        fontSize:
                                                                            8,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                                width:
                                                                    Get.width *
                                                                        0.43,
                                                                child: ListView
                                                                    .builder(
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        itemCount:
                                                                            agriController.agriProviderData.value.result?.matchingAgriServiceProviders?[index].roles?.length ??
                                                                                0,
                                                                        itemBuilder:
                                                                            (context,
                                                                                indexes) {
                                                                          return Container(
                                                                            margin:
                                                                                const EdgeInsets.symmetric(horizontal: 5),
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 8),
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color(0x14167C0C)),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                agriController.agriProviderData.value.result?.matchingAgriServiceProviders?[index].roles![indexes].name ?? "",
                                                                                style: GoogleFonts.poppins(
                                                                                  color: AppColor.DARK_GREEN,
                                                                                  fontSize: 8,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  height: 0.22,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            80),
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        4),
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
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Get.to(() =>
                                                                        ChatScreen(
                                                                          landId: agriController
                                                                              .landId
                                                                              .value,
                                                                          enquiryId:
                                                                              agriController.agriProviderData.value.result?.matchingAgriServiceProviders?[index].enquiryId ?? 0,
                                                                          userId:
                                                                              agriController.agriProviderData.value.result?.matchingAgriServiceProviders?[index].userId?.toInt() ?? 0,
                                                                          userType:
                                                                              agriController.agriProviderData.value.result?.matchingAgriServiceProviders?[index].userType ?? "",
                                                                          userFrom:
                                                                              agriController.agriProviderData.value.result?.matchingAgriServiceProviders?[index].livesIn ?? "",
                                                                          userName:
                                                                              agriController.agriProviderData.value.result?.matchingAgriServiceProviders?[index].fullName ?? "",
                                                                          image:
                                                                              agriController.agriProviderData.value.result?.matchingAgriServiceProviders?[index].image ?? "",
                                                                          isEnquiryCreatedByMe:
                                                                              false,
                                                                          isEnquiryDisplay:
                                                                              false,
                                                                          enquiryData:
                                                                              "",
                                                                        ));
                                                                  },
                                                                  child:
                                                                      const Row(
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
                                                                        size:
                                                                            15,
                                                                      ),
                                                                      Text(
                                                                        '  Contact ',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFF044D3A),
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
                                              }))
                                      : Obx(() {
                                          return agriController
                                                  .showAnimation.value
                                              ? Lottie.asset(
                                                  "assets/lotties/animation.json",
                                                  height: 100,
                                                  width: double.infinity,
                                                )
                                              : const Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 20.0,
                                                            horizontal: 10),
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      "Use Distance filter to see matching partners near you",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                  ),
                                                );
                                        }),

                                  // percentageController.percentIndicate.value
                                  //             .result?.completionPercentage !=
                                  //         100
                                  //     ? Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           Container(
                                  //             margin: const EdgeInsets.only(
                                  //                 top: 20),
                                  //             child: Text(
                                  //               'Provide more information ',
                                  //               style: GoogleFonts.poppins(
                                  //                 color:
                                  //                     const Color(0xFF483C32),
                                  //                 fontSize: 14,
                                  //                 fontWeight: FontWeight.w500,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             'To get better matches & more Enquiries',
                                  //             style: GoogleFonts.poppins(
                                  //               color: const Color(0xCC483C32),
                                  //               fontSize: 10,
                                  //               fontWeight: FontWeight.w400,
                                  //               height: 0,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       )
                                  //     : Container(),
                                  // Obx(() {
                                  //   return landController.landData.value.result
                                  //               ?.isLandTypeAdded ==
                                  //           false
                                  //       ? Container(
                                  //           margin: const EdgeInsets.symmetric(
                                  //               vertical: 20),
                                  //           padding: const EdgeInsets.symmetric(
                                  //               vertical: 10, horizontal: 15),
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             border: Border.all(
                                  //                 color: AppColor.GREY_BORDER),
                                  //             boxShadow: [AppColor.BOX_SHADOW],
                                  //             borderRadius:
                                  //                 BorderRadius.circular(18),
                                  //           ),
                                  //           child: Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             children: [
                                  //               Align(
                                  //                 alignment: Alignment.topLeft,
                                  //                 child: Text(
                                  //                   'Type of Land',
                                  //                   style: GoogleFonts.poppins(
                                  //                     color: const Color(
                                  //                         0xFF272727),
                                  //                     fontSize: 13,
                                  //                     fontWeight:
                                  //                         FontWeight.w500,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               Row(
                                  //                 children: List.generate(
                                  //                     450 ~/ 4,
                                  //                     (index) => Expanded(
                                  //                           child: Container(
                                  //                             margin:
                                  //                                 const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     vertical:
                                  //                                         10),
                                  //                             color: index %
                                  //                                         2 ==
                                  //                                     0
                                  //                                 ? Colors
                                  //                                     .transparent
                                  //                                 : AppColor
                                  //                                     .GREY_BORDER,
                                  //                             height: 1,
                                  //                           ),
                                  //                         )),
                                  //               ),
                                  //               landTypeController.loading.value
                                  //                   ? const Center(
                                  //                       child:
                                  //                           CircularProgressIndicator(
                                  //                       color:
                                  //                           AppColor.DARK_GREEN,
                                  //                     ))
                                  //                   : Wrap(
                                  //                       spacing: 10,
                                  //                       runSpacing: 10,
                                  //                       children: List.generate(
                                  //                           landTypeController
                                  //                                   .landData
                                  //                                   .value
                                  //                                   .result
                                  //                                   ?.length ??
                                  //                               0,
                                  //                           (index) => InkWell(
                                  //                                 onTap: () {
                                  //                                   landTypeController
                                  //                                       .selectedId
                                  //                                       .value = index;
                                  //                                   updateLand.landType.value = landTypeController
                                  //                                       .landData
                                  //                                       .value
                                  //                                       .result![
                                  //                                           index]
                                  //                                       .id
                                  //                                       .toString();
                                  //                                   print(
                                  //                                       "======================================================================${updateLand.landType.value}");
                                  //                                 },
                                  //                                 child:
                                  //                                     Container(
                                  //                                   padding: const EdgeInsets
                                  //                                       .symmetric(
                                  //                                       vertical:
                                  //                                           10,
                                  //                                       horizontal:
                                  //                                           20),
                                  //                                   decoration:
                                  //                                       BoxDecoration(
                                  //                                     gradient: landTypeController.selectedId.value ==
                                  //                                             index
                                  //                                         ? AppColor
                                  //                                             .PRIMARY_GRADIENT
                                  //                                         : AppColor
                                  //                                             .WHITE_GRADIENT,
                                  //                                     borderRadius:
                                  //                                         BorderRadius.circular(
                                  //                                             30),
                                  //                                     border: Border.all(
                                  //                                         color: landTypeController.selectedId.value == index
                                  //                                             ? AppColor.DARK_GREEN
                                  //                                             : AppColor.GREY_BORDER),
                                  //                                   ),
                                  //                                   child: Text(
                                  //                                     landTypeController
                                  //                                             .landData
                                  //                                             .value
                                  //                                             .result?[index]
                                  //                                             .name ??
                                  //                                         "",
                                  //                                     style: GoogleFonts
                                  //                                         .poppins(
                                  //                                       color: AppColor
                                  //                                           .DARK_GREEN,
                                  //                                       fontSize:
                                  //                                           12,
                                  //                                       fontWeight:
                                  //                                           FontWeight.w500,
                                  //                                     ),
                                  //                                   ),
                                  //                                 ),
                                  //                               )),
                                  //                     ),
                                  //               InkWell(
                                  //                 onTap: () async {
                                  //                   await updateLand
                                  //                       .updateLandType();
                                  //                   Future.delayed(
                                  //                       const Duration(
                                  //                           seconds: 1), () {
                                  //                     landController
                                  //                         .landDetails(
                                  //                             widget.landId);
                                  //                   });
                                  //                 },
                                  //                 child: Container(
                                  //                     margin: EdgeInsets.only(
                                  //                         left:
                                  //                             Get.width * 0.5),
                                  //                     padding: const EdgeInsets
                                  //                         .symmetric(
                                  //                       vertical: 13,
                                  //                       horizontal: 40,
                                  //                     ),
                                  //                     decoration:
                                  //                         ShapeDecoration(
                                  //                       color:
                                  //                           AppColor.DARK_GREEN,
                                  //                       shape:
                                  //                           RoundedRectangleBorder(
                                  //                         borderRadius:
                                  //                             BorderRadius
                                  //                                 .circular(8),
                                  //                       ),
                                  //                     ),
                                  //                     child: updateLand
                                  //                             .landloading.value
                                  //                         ? Container(
                                  //                             margin:
                                  //                                 const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     horizontal:
                                  //                                         5),
                                  //                             height: 15,
                                  //                             width: 15,
                                  //                             child:
                                  //                                 const CircularProgressIndicator(
                                  //                               color: Colors
                                  //                                   .white,
                                  //                               strokeWidth: 3,
                                  //                             ),
                                  //                           )
                                  //                         : const Text(
                                  //                             'Save',
                                  //                             style: TextStyle(
                                  //                               color: Color(
                                  //                                   0xFFFBFBFB),
                                  //                               fontSize: 12,
                                  //                               fontFamily:
                                  //                                   'Poppins',
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w600,
                                  //                               height: 0,
                                  //                             ),
                                  //                           )),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         )
                                  //       : Container();
                                  // }),
                                  // Obx(() {
                                  //   return landController.landData.value.result
                                  //               ?.isWaterSourceAdded ==
                                  //           false
                                  //       ? Container(
                                  //           margin: const EdgeInsets.symmetric(
                                  //               vertical: 20),
                                  //           padding: const EdgeInsets.symmetric(
                                  //               vertical: 10, horizontal: 15),
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             border: Border.all(
                                  //                 color: AppColor.GREY_BORDER),
                                  //             boxShadow: [AppColor.BOX_SHADOW],
                                  //             borderRadius:
                                  //                 BorderRadius.circular(18),
                                  //           ),
                                  //           child: Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.start,
                                  //             children: [
                                  //               Align(
                                  //                 alignment: Alignment.topLeft,
                                  //                 child: Text(
                                  //                   'Are there water sources available?',
                                  //                   style: GoogleFonts.poppins(
                                  //                     color: const Color(
                                  //                         0xFF272727),
                                  //                     fontSize: 13,
                                  //                     fontWeight:
                                  //                         FontWeight.w500,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               Row(
                                  //                 children: List.generate(
                                  //                     450 ~/ 4,
                                  //                     (index) => Expanded(
                                  //                           child: Container(
                                  //                             margin:
                                  //                                 const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     vertical:
                                  //                                         12),
                                  //                             color: index %
                                  //                                         2 ==
                                  //                                     0
                                  //                                 ? Colors
                                  //                                     .transparent
                                  //                                 : AppColor
                                  //                                     .GREY_BORDER,
                                  //                             height: 1,
                                  //                           ),
                                  //                         )),
                                  //               ),
                                  //               Row(
                                  //                 children: [
                                  //                   Expanded(
                                  //                     child: Obx(
                                  //                       () => RadioListTile(
                                  //                         contentPadding:
                                  //                             const EdgeInsets
                                  //                                 .all(0),
                                  //                         activeColor: AppColor
                                  //                             .DARK_GREEN,
                                  //                         title: Text(
                                  //                           'Available',
                                  //                           style: GoogleFonts
                                  //                               .poppins(
                                  //                             color: const Color(
                                  //                                 0xFF333333),
                                  //                             fontSize: 12,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .w500,
                                  //                           ),
                                  //                         ),
                                  //                         value: true,
                                  //                         groupValue: updateLand
                                  //                             .isWaterAvailable
                                  //                             .value,
                                  //                         onChanged: (value) {
                                  //                           updateLand
                                  //                               .isWaterAvailable
                                  //                               .value = value!;
                                  //                           print(updateLand
                                  //                               .isWaterAvailable
                                  //                               .value);
                                  //                         },
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   Expanded(
                                  //                     child: Obx(
                                  //                       () => RadioListTile(
                                  //                         contentPadding:
                                  //                             const EdgeInsets
                                  //                                 .all(0),
                                  //                         title: Text(
                                  //                           'Unavailable',
                                  //                           style: GoogleFonts
                                  //                               .poppins(
                                  //                             color: const Color(
                                  //                                 0xFF333333),
                                  //                             fontSize: 12,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .w500,
                                  //                           ),
                                  //                         ),
                                  //                         value: false,
                                  //                         activeColor: AppColor
                                  //                             .DARK_GREEN,
                                  //                         groupValue: updateLand
                                  //                             .isWaterAvailable
                                  //                             .value,
                                  //                         onChanged: (value) {
                                  //                           updateLand
                                  //                               .isWaterAvailable
                                  //                               .value = value!;
                                  //                           print(updateLand
                                  //                               .isWaterAvailable
                                  //                               .value);
                                  //                         },
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //               Obx(() => Visibility(
                                  //                     visible: updateLand
                                  //                         .isWaterAvailable
                                  //                         .value,
                                  //                     child: Wrap(
                                  //                       spacing: 10,
                                  //                       runSpacing: 10,
                                  //                       children: List.generate(
                                  //                           waterController
                                  //                                   .waterResource
                                  //                                   .value
                                  //                                   .result
                                  //                                   ?.length ??
                                  //                               0,
                                  //                           (index) => InkWell(
                                  //                                 onTap: () {
                                  //                                   updateLand
                                  //                                       .waterId
                                  //                                       .value = index;
                                  //                                   updateLand.waterResource.value = waterController
                                  //                                       .waterResource
                                  //                                       .value
                                  //                                       .result![
                                  //                                           index]
                                  //                                       .id
                                  //                                       .toString();
                                  //                                   print(
                                  //                                       "======================================================================${updateLand.waterResource.value}");
                                  //                                 },
                                  //                                 child:
                                  //                                     Container(
                                  //                                   padding: const EdgeInsets
                                  //                                       .symmetric(
                                  //                                       vertical:
                                  //                                           10,
                                  //                                       horizontal:
                                  //                                           20),
                                  //                                   decoration:
                                  //                                       BoxDecoration(
                                  //                                     gradient: updateLand.waterId ==
                                  //                                             index
                                  //                                         ? AppColor
                                  //                                             .PRIMARY_GRADIENT
                                  //                                         : AppColor
                                  //                                             .WHITE_GRADIENT,
                                  //                                     borderRadius:
                                  //                                         BorderRadius.circular(
                                  //                                             30),
                                  //                                     border: Border.all(
                                  //                                         color: updateLand.waterId == index
                                  //                                             ? AppColor.DARK_GREEN
                                  //                                             : AppColor.GREY_BORDER),
                                  //                                   ),
                                  //                                   child: Text(
                                  //                                     waterController
                                  //                                             .waterResource
                                  //                                             .value
                                  //                                             .result?[index]
                                  //                                             .name ??
                                  //                                         "",
                                  //                                     style: GoogleFonts
                                  //                                         .poppins(
                                  //                                       color: AppColor
                                  //                                           .DARK_GREEN,
                                  //                                       fontSize:
                                  //                                           12,
                                  //                                       fontWeight:
                                  //                                           FontWeight.w500,
                                  //                                     ),
                                  //                                   ),
                                  //                                 ),
                                  //                               )),
                                  //                     ),
                                  //                   )),
                                  //               InkWell(
                                  //                 onTap: () async {
                                  //                   updateLand.isWaterAvailable
                                  //                           .value
                                  //                       ? await updateLand
                                  //                           .updateWaterResource()
                                  //                       : await updateLand
                                  //                           .updateWaterisAvailable();
                                  //                   Future.delayed(
                                  //                       const Duration(
                                  //                           seconds: 1), () {
                                  //                     landController
                                  //                         .landDetails(
                                  //                             widget.landId);
                                  //                   });
                                  //                 },
                                  //                 child: Container(
                                  //                     margin: EdgeInsets.only(
                                  //                         left: Get.width * 0.5,
                                  //                         top: 10),
                                  //                     padding: const EdgeInsets
                                  //                         .symmetric(
                                  //                       vertical: 13,
                                  //                       horizontal: 40,
                                  //                     ),
                                  //                     decoration:
                                  //                         ShapeDecoration(
                                  //                       color:
                                  //                           AppColor.DARK_GREEN,
                                  //                       shape:
                                  //                           RoundedRectangleBorder(
                                  //                         borderRadius:
                                  //                             BorderRadius
                                  //                                 .circular(8),
                                  //                       ),
                                  //                     ),
                                  //                     child: updateLand
                                  //                             .waterloading
                                  //                             .value
                                  //                         ? Container(
                                  //                             margin:
                                  //                                 const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     horizontal:
                                  //                                         5),
                                  //                             height: 15,
                                  //                             width: 15,
                                  //                             child:
                                  //                                 const CircularProgressIndicator(
                                  //                               color: Colors
                                  //                                   .white,
                                  //                               strokeWidth: 3,
                                  //                             ),
                                  //                           )
                                  //                         : const Text(
                                  //                             'Save',
                                  //                             style: TextStyle(
                                  //                               color: Color(
                                  //                                   0xFFFBFBFB),
                                  //                               fontSize: 12,
                                  //                               fontFamily:
                                  //                                   'Poppins',
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w600,
                                  //                               height: 0,
                                  //                             ),
                                  //                           )),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         )
                                  //       : Container();
                                  // }),
                                  // Obx(() {
                                  //   return landController.landData.value.result
                                  //               ?.isAccomodationAdded ==
                                  //           false
                                  //       ? Container(
                                  //           margin: const EdgeInsets.symmetric(
                                  //               vertical: 20),
                                  //           padding: const EdgeInsets.symmetric(
                                  //               vertical: 10, horizontal: 15),
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             border: Border.all(
                                  //                 color: AppColor.GREY_BORDER),
                                  //             boxShadow: [AppColor.BOX_SHADOW],
                                  //             borderRadius:
                                  //                 BorderRadius.circular(18),
                                  //           ),
                                  //           child: Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.end,
                                  //             children: [
                                  //               Align(
                                  //                 alignment: Alignment.topLeft,
                                  //                 child: Text(
                                  //                   'Is there space available for farmer accommodation?',
                                  //                   style: GoogleFonts.poppins(
                                  //                     color: const Color(
                                  //                         0xFF272727),
                                  //                     fontSize: 13,
                                  //                     fontWeight:
                                  //                         FontWeight.w500,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               Row(
                                  //                 children: List.generate(
                                  //                     450 ~/ 4,
                                  //                     (index) => Expanded(
                                  //                           child: Container(
                                  //                             margin:
                                  //                                 const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     vertical:
                                  //                                         12),
                                  //                             color: index %
                                  //                                         2 ==
                                  //                                     0
                                  //                                 ? Colors
                                  //                                     .transparent
                                  //                                 : AppColor
                                  //                                     .GREY_BORDER,
                                  //                             height: 1,
                                  //                           ),
                                  //                         )),
                                  //               ),
                                  //               Row(
                                  //                 children: [
                                  //                   Expanded(
                                  //                     child: Obx(
                                  //                       () =>
                                  //                           RadioListTile<bool>(
                                  //                         contentPadding:
                                  //                             const EdgeInsets
                                  //                                 .all(0),
                                  //                         activeColor: AppColor
                                  //                             .DARK_GREEN,
                                  //                         title: Text(
                                  //                           'Available',
                                  //                           style: GoogleFonts
                                  //                               .poppins(
                                  //                             color: const Color(
                                  //                                 0xFF333333),
                                  //                             fontSize: 12,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .w500,
                                  //                           ),
                                  //                         ),
                                  //                         value: true,
                                  //                         groupValue: updateLand
                                  //                             .isAccomodationAvailable
                                  //                             .value,
                                  //                         onChanged: (value) {
                                  //                           updateLand
                                  //                               .isAccomodationAvailable
                                  //                               .value = value!;
                                  //                           print(updateLand
                                  //                               .isAccomodationAvailable
                                  //                               .value);
                                  //                         },
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   Expanded(
                                  //                     child: Obx(
                                  //                       () =>
                                  //                           RadioListTile<bool>(
                                  //                         contentPadding:
                                  //                             const EdgeInsets
                                  //                                 .all(0),
                                  //                         title: Text(
                                  //                           'Unavailable',
                                  //                           style: GoogleFonts
                                  //                               .poppins(
                                  //                             color: const Color(
                                  //                                 0xFF333333),
                                  //                             fontSize: 12,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .w500,
                                  //                           ),
                                  //                         ),
                                  //                         value: false,
                                  //                         activeColor: AppColor
                                  //                             .DARK_GREEN,
                                  //                         groupValue: updateLand
                                  //                             .isAccomodationAvailable
                                  //                             .value,
                                  //                         onChanged: (value) {
                                  //                           updateLand
                                  //                               .isAccomodationAvailable
                                  //                               .value = value!;
                                  //                           print(updateLand
                                  //                               .isAccomodationAvailable
                                  //                               .value);
                                  //                         },
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //               // Visibility(
                                  //               //   visible: updateLand
                                  //               //       .isAccomodationAvailable.value,
                                  //               //   child: Container(
                                  //               //     margin: EdgeInsets.symmetric(
                                  //               //         vertical: 15),
                                  //               //     decoration: BoxDecoration(
                                  //               //       color: Colors.white,
                                  //               //       border: Border.all(
                                  //               //           color:
                                  //               //               AppColor.GREY_BORDER),
                                  //               //       boxShadow: [
                                  //               //         AppColor.BOX_SHADOW
                                  //               //       ],
                                  //               //       borderRadius:
                                  //               //           BorderRadius.circular(18),
                                  //               //     ),
                                  //               //     child: Form(
                                  //               //       key: _accomodationKey,
                                  //               //       child: TextFormField(
                                  //               //         controller: updateLand
                                  //               //             .accomodationController
                                  //               //             .value,
                                  //               //         validator: (value) {
                                  //               //           if (value!.isEmpty) {
                                  //               //             return 'Please enter the value';
                                  //               //           }
                                  //               //           return "";
                                  //               //         },
                                  //               //         decoration: InputDecoration(
                                  //               //             contentPadding:
                                  //               //                 EdgeInsets.symmetric(
                                  //               //                     vertical: 15,
                                  //               //                     horizontal: 20),
                                  //               //             hintText:
                                  //               //                 "What’s available?",
                                  //               //             hintStyle:
                                  //               //                 GoogleFonts.poppins(
                                  //               //               color:
                                  //               //                   Color(0x994F4F4F),
                                  //               //               fontSize: 14,
                                  //               //               fontWeight:
                                  //               //                   FontWeight.w500,
                                  //               //               height: 0.10,
                                  //               //             ),
                                  //               //             border: InputBorder.none),
                                  //               //       ),
                                  //               //     ),
                                  //               //   ),
                                  //               // ),
                                  //               InkWell(
                                  //                 onTap: () async {
                                  //                   updateLand
                                  //                           .isAccomodationAvailable
                                  //                           .value
                                  //                       ? _accomodationKey
                                  //                           .currentState!
                                  //                           .validate()
                                  //                       : "";
                                  //                   updateLand
                                  //                           .isAccomodationAvailable
                                  //                           .value
                                  //                       ? await updateLand
                                  //                           .updateAccomodationAvailable()
                                  //                       : await updateLand
                                  //                           .isaccomodationAvailable();
                                  //                   Future.delayed(
                                  //                       const Duration(
                                  //                           seconds: 1), () {
                                  //                     landController
                                  //                         .landDetails(
                                  //                             widget.landId);
                                  //                   });
                                  //                 },
                                  //                 child: Container(
                                  //                     margin: EdgeInsets.only(
                                  //                         left:
                                  //                             Get.width * 0.5),
                                  //                     padding: const EdgeInsets
                                  //                         .symmetric(
                                  //                       vertical: 13,
                                  //                       horizontal: 40,
                                  //                     ),
                                  //                     decoration:
                                  //                         ShapeDecoration(
                                  //                       color:
                                  //                           AppColor.DARK_GREEN,
                                  //                       shape:
                                  //                           RoundedRectangleBorder(
                                  //                         borderRadius:
                                  //                             BorderRadius
                                  //                                 .circular(8),
                                  //                       ),
                                  //                     ),
                                  //                     child: updateLand
                                  //                             .accomodationloading
                                  //                             .value
                                  //                         ? Container(
                                  //                             margin:
                                  //                                 const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     horizontal:
                                  //                                         5),
                                  //                             height: 15,
                                  //                             width: 15,
                                  //                             child:
                                  //                                 const CircularProgressIndicator(
                                  //                               color: Colors
                                  //                                   .white,
                                  //                               strokeWidth: 3,
                                  //                             ),
                                  //                           )
                                  //                         : const Text(
                                  //                             'Save',
                                  //                             style: TextStyle(
                                  //                               color: Color(
                                  //                                   0xFFFBFBFB),
                                  //                               fontSize: 12,
                                  //                               fontFamily:
                                  //                                   'Poppins',
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w600,
                                  //                               height: 0,
                                  //                             ),
                                  //                           )),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         )
                                  //       : Container();
                                  // }),
                                  // Obx(() {
                                  //   return landController.landData.value.result
                                  //               ?.isEquipmentAdded ==
                                  //           false
                                  //       ? Container(
                                  //           margin: const EdgeInsets.symmetric(
                                  //               vertical: 20),
                                  //           padding: const EdgeInsets.symmetric(
                                  //               vertical: 10, horizontal: 15),
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             border: Border.all(
                                  //                 color: AppColor.GREY_BORDER),
                                  //             boxShadow: [AppColor.BOX_SHADOW],
                                  //             borderRadius:
                                  //                 BorderRadius.circular(18),
                                  //           ),
                                  //           child: Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             children: [
                                  //               Align(
                                  //                 alignment: Alignment.topLeft,
                                  //                 child: Text(
                                  //                   'Availability of farm equipment and machine near land.',
                                  //                   style: GoogleFonts.poppins(
                                  //                     color: const Color(
                                  //                         0xFF272727),
                                  //                     fontSize: 13,
                                  //                     fontWeight:
                                  //                         FontWeight.w500,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               Row(
                                  //                 children: List.generate(
                                  //                     450 ~/ 4,
                                  //                     (index) => Expanded(
                                  //                           child: Container(
                                  //                             margin:
                                  //                                 const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     vertical:
                                  //                                         12),
                                  //                             color: index %
                                  //                                         2 ==
                                  //                                     0
                                  //                                 ? Colors
                                  //                                     .transparent
                                  //                                 : AppColor
                                  //                                     .GREY_BORDER,
                                  //                             height: 1,
                                  //                           ),
                                  //                         )),
                                  //               ),
                                  //               Row(
                                  //                 children: [
                                  //                   Expanded(
                                  //                     child: Obx(
                                  //                       () =>
                                  //                           RadioListTile<bool>(
                                  //                         contentPadding:
                                  //                             const EdgeInsets
                                  //                                 .all(0),
                                  //                         activeColor: AppColor
                                  //                             .DARK_GREEN,
                                  //                         title: Text(
                                  //                           'Available',
                                  //                           style: GoogleFonts
                                  //                               .poppins(
                                  //                             color: const Color(
                                  //                                 0xFF333333),
                                  //                             fontSize: 12,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .w500,
                                  //                           ),
                                  //                         ),
                                  //                         value: true,
                                  //                         groupValue: updateLand
                                  //                             .isEquipmentAvailable
                                  //                             .value,
                                  //                         onChanged: (value) {
                                  //                           updateLand
                                  //                               .isEquipmentAvailable
                                  //                               .value = value!;
                                  //                         },
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   Expanded(
                                  //                     child: Obx(
                                  //                       () =>
                                  //                           RadioListTile<bool>(
                                  //                         contentPadding:
                                  //                             const EdgeInsets
                                  //                                 .all(0),
                                  //                         title: Text(
                                  //                           'Unavailable',
                                  //                           style: GoogleFonts
                                  //                               .poppins(
                                  //                             color: const Color(
                                  //                                 0xFF333333),
                                  //                             fontSize: 12,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .w500,
                                  //                           ),
                                  //                         ),
                                  //                         value: false,
                                  //                         activeColor: AppColor
                                  //                             .DARK_GREEN,
                                  //                         groupValue: updateLand
                                  //                             .isEquipmentAvailable
                                  //                             .value,
                                  //                         onChanged: (value) {
                                  //                           updateLand
                                  //                               .isEquipmentAvailable
                                  //                               .value = value!;
                                  //                         },
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //               // Visibility(
                                  //               //   visible: updateLand
                                  //               //       .isEquipmentAvailable.value,
                                  //               //   child: Container(
                                  //               //     margin: EdgeInsets.symmetric(
                                  //               //         vertical: 15),
                                  //               //     decoration: BoxDecoration(
                                  //               //       color: Colors.white,
                                  //               //       border: Border.all(
                                  //               //           color:
                                  //               //               AppColor.GREY_BORDER),
                                  //               //       boxShadow: [
                                  //               //         AppColor.BOX_SHADOW
                                  //               //       ],
                                  //               //       borderRadius:
                                  //               //           BorderRadius.circular(18),
                                  //               //     ),
                                  //               //     child: Form(
                                  //               //       key: _equipmentKey,
                                  //               //       child: TextFormField(
                                  //               //         controller: updateLand
                                  //               //             .equipmentController
                                  //               //             .value,
                                  //               //         validator: (value) {
                                  //               //           if (value!.isEmpty) {
                                  //               //             return 'Please enter the value';
                                  //               //           }
                                  //               //           return "";
                                  //               //         },
                                  //               //         decoration: InputDecoration(
                                  //               //             contentPadding:
                                  //               //                 EdgeInsets.symmetric(
                                  //               //                     vertical: 15,
                                  //               //                     horizontal: 20),
                                  //               //             hintText:
                                  //               //                 "What’s available?",
                                  //               //             hintStyle:
                                  //               //                 GoogleFonts.poppins(
                                  //               //               color:
                                  //               //                   Color(0x994F4F4F),
                                  //               //               fontSize: 14,
                                  //               //               fontWeight:
                                  //               //                   FontWeight.w500,
                                  //               //               height: 0.10,
                                  //               //             ),
                                  //               //             border: InputBorder.none),
                                  //               //       ),
                                  //               //     ),
                                  //               //   ),
                                  //               // ),
                                  //               InkWell(
                                  //                 onTap: () async {
                                  //                   updateLand
                                  //                           .isEquipmentAvailable
                                  //                           .value
                                  //                       ? _equipmentKey
                                  //                           .currentState!
                                  //                           .validate()
                                  //                       : "";
                                  //                   updateLand
                                  //                           .isEquipmentAvailable
                                  //                           .value
                                  //                       ? await updateLand
                                  //                           .updateEquipmentAvailable()
                                  //                       : await updateLand
                                  //                           .isequipmentAvailable();
                                  //                   Future.delayed(
                                  //                       const Duration(
                                  //                           seconds: 1), () {
                                  //                     landController
                                  //                         .landDetails(
                                  //                             widget.landId);
                                  //                   });
                                  //                 },
                                  //                 child: Container(
                                  //                     margin: EdgeInsets.only(
                                  //                         left:
                                  //                             Get.width * 0.5),
                                  //                     padding: const EdgeInsets
                                  //                         .symmetric(
                                  //                       vertical: 13,
                                  //                       horizontal: 40,
                                  //                     ),
                                  //                     decoration:
                                  //                         ShapeDecoration(
                                  //                       color:
                                  //                           AppColor.DARK_GREEN,
                                  //                       shape:
                                  //                           RoundedRectangleBorder(
                                  //                         borderRadius:
                                  //                             BorderRadius
                                  //                                 .circular(8),
                                  //                       ),
                                  //                     ),
                                  //                     child: updateLand
                                  //                             .equipmentloading
                                  //                             .value
                                  //                         ? Container(
                                  //                             margin:
                                  //                                 const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     horizontal:
                                  //                                         5),
                                  //                             height: 15,
                                  //                             width: 15,
                                  //                             child:
                                  //                                 const CircularProgressIndicator(
                                  //                               color: Colors
                                  //                                   .white,
                                  //                               strokeWidth: 3,
                                  //                             ),
                                  //                           )
                                  //                         : const Text(
                                  //                             'Save',
                                  //                             style: TextStyle(
                                  //                               color: Color(
                                  //                                   0xFFFBFBFB),
                                  //                               fontSize: 12,
                                  //                               fontFamily:
                                  //                                   'Poppins',
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w600,
                                  //                               height: 0,
                                  //                             ),
                                  //                           )),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         )
                                  //       : Container();
                                  // }),
                                  // Obx(() {
                                  //   return landController.landData.value.result
                                  //               ?.isLandFarmedAdded ==
                                  //           false
                                  //       ? Container(
                                  //           margin: const EdgeInsets.symmetric(
                                  //               vertical: 20),
                                  //           padding: const EdgeInsets.symmetric(
                                  //               vertical: 10, horizontal: 15),
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             border: Border.all(
                                  //                 color: AppColor.GREY_BORDER),
                                  //             boxShadow: [AppColor.BOX_SHADOW],
                                  //             borderRadius:
                                  //                 BorderRadius.circular(18),
                                  //           ),
                                  //           child: Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             children: [
                                  //               Container(
                                  //                 margin: const EdgeInsets
                                  //                     .symmetric(vertical: 8),
                                  //                 child: Text(
                                  //                   'Did you farm on this land in the past?',
                                  //                   style: GoogleFonts.poppins(
                                  //                     color: const Color(
                                  //                         0xFF272727),
                                  //                     fontSize: 13,
                                  //                     fontWeight:
                                  //                         FontWeight.w500,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               Row(
                                  //                 children: List.generate(
                                  //                     450 ~/ 4,
                                  //                     (index) => Expanded(
                                  //                           child: Container(
                                  //                             margin:
                                  //                                 const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     vertical:
                                  //                                         12),
                                  //                             color: index %
                                  //                                         2 ==
                                  //                                     0
                                  //                                 ? Colors
                                  //                                     .transparent
                                  //                                 : AppColor
                                  //                                     .GREY_BORDER,
                                  //                             height: 1,
                                  //                           ),
                                  //                         )),
                                  //               ),
                                  //               Row(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment
                                  //                         .spaceBetween,
                                  //                 crossAxisAlignment:
                                  //                     CrossAxisAlignment.start,
                                  //                 children: [
                                  //                   Obx(
                                  //                     () => SizedBox(
                                  //                       width: AppDimension.w *
                                  //                           0.4,
                                  //                       child:
                                  //                           RadioListTile<bool>(
                                  //                         activeColor: AppColor
                                  //                             .DARK_GREEN,
                                  //                         title: Text(
                                  //                           'Yes',
                                  //                           style: GoogleFonts
                                  //                               .poppins(
                                  //                             color: const Color(
                                  //                                 0xFF333333),
                                  //                             fontSize: 12,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .w500,
                                  //                           ),
                                  //                         ),
                                  //                         value: true,
                                  //                         groupValue: updateLand
                                  //                             .isLandFarm.value,
                                  //                         onChanged: (value) {
                                  //                           updateLand
                                  //                               .isLandFarm
                                  //                               .value = value!;
                                  //                         },
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   Obx(
                                  //                     () => Expanded(
                                  //                       child:
                                  //                           RadioListTile<bool>(
                                  //                         title: Text(
                                  //                           'No',
                                  //                           style: GoogleFonts
                                  //                               .poppins(
                                  //                             color: const Color(
                                  //                                 0xFF333333),
                                  //                             fontSize: 12,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .w500,
                                  //                           ),
                                  //                         ),
                                  //                         value: false,
                                  //                         activeColor: AppColor
                                  //                             .DARK_GREEN,
                                  //                         groupValue: updateLand
                                  //                             .isLandFarm.value,
                                  //                         onChanged: (value) {
                                  //                           updateLand
                                  //                               .isLandFarm
                                  //                               .value = value!;
                                  //                         },
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //               updateLand.isLandFarm.value
                                  //                   ? Column(
                                  //                       crossAxisAlignment:
                                  //                           CrossAxisAlignment
                                  //                               .start,
                                  //                       children: [
                                  //                         const Text(
                                  //                           'What type of crops did you grew?',
                                  //                           style: TextStyle(
                                  //                             color: Color(
                                  //                                 0xFF272727),
                                  //                             fontSize: 13,
                                  //                             fontFamily:
                                  //                                 'Poppins',
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .w500,
                                  //                             height: 0,
                                  //                           ),
                                  //                         ),
                                  //                         Obx(() {
                                  //                           return Container(
                                  //                             margin:
                                  //                                 const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     vertical:
                                  //                                         15),
                                  //                             child: Wrap(
                                  //                               spacing: 10,
                                  //                               children: List.generate(
                                  //                                   cropSugestionController
                                  //                                       .cropData
                                  //                                       .value
                                  //                                       .result!
                                  //                                       .length,
                                  //                                   (index) {
                                  //                                 final cropId =
                                  //                                     cropSugestionController
                                  //                                         .cropData
                                  //                                         .value
                                  //                                         .result![
                                  //                                             index]
                                  //                                         .id;
                                  //                                 bool isSelected = cropId !=
                                  //                                         null &&
                                  //                                     updateLand
                                  //                                         .crops
                                  //                                         .contains(
                                  //                                             cropId.toInt());

                                  //                                 return InkWell(
                                  //                                   onTap: () {
                                  //                                     if (cropId !=
                                  //                                         null) {
                                  //                                       if (isSelected) {
                                  //                                         updateLand
                                  //                                             .crops
                                  //                                             .remove(cropId);
                                  //                                       } else {
                                  //                                         updateLand
                                  //                                             .crops
                                  //                                             .add(cropId);
                                  //                                       }
                                  //                                     }
                                  //                                   },
                                  //                                   child:
                                  //                                       AnimatedContainer(
                                  //                                     margin: const EdgeInsets
                                  //                                         .symmetric(
                                  //                                         vertical:
                                  //                                             5),
                                  //                                     padding: const EdgeInsets
                                  //                                         .symmetric(
                                  //                                         vertical:
                                  //                                             10,
                                  //                                         horizontal:
                                  //                                             10),
                                  //                                     decoration: BoxDecoration(
                                  //                                         borderRadius: BorderRadius.circular(
                                  //                                             40),
                                  //                                         border: isSelected
                                  //                                             ? Border.all(color: AppColor.DARK_GREEN)
                                  //                                             : Border.all(color: AppColor.GREY_BORDER),
                                  //                                         gradient: isSelected ? AppColor.PRIMARY_GRADIENT : AppColor.WHITE_GRADIENT),
                                  //                                     duration: const Duration(
                                  //                                         milliseconds:
                                  //                                             10),
                                  //                                     child: Text(cropSugestionController
                                  //                                         .cropData
                                  //                                         .value
                                  //                                         .result![
                                  //                                             index]
                                  //                                         .name
                                  //                                         .toString()),
                                  //                                   ),
                                  //                                 );
                                  //                               }),
                                  //                             ),
                                  //                           );
                                  //                         }),
                                  //                       ],
                                  //                     )
                                  //                   : Container(),
                                  //               InkWell(
                                  //                 onTap: () async {
                                  //                   updateLand.isLandFarm.value
                                  //                       ? await updateLand
                                  //                           .updateCropData()
                                  //                       : await updateLand
                                  //                           .updateCrop();
                                  //                   Future.delayed(
                                  //                       const Duration(
                                  //                           seconds: 1), () {
                                  //                     landController
                                  //                         .landDetails(
                                  //                             widget.landId);
                                  //                   });
                                  //                 },
                                  //                 child: Container(
                                  //                     margin: EdgeInsets.only(
                                  //                         left:
                                  //                             Get.width * 0.5),
                                  //                     padding: const EdgeInsets
                                  //                         .symmetric(
                                  //                       vertical: 13,
                                  //                       horizontal: 40,
                                  //                     ),
                                  //                     decoration:
                                  //                         ShapeDecoration(
                                  //                       color:
                                  //                           AppColor.DARK_GREEN,
                                  //                       shape:
                                  //                           RoundedRectangleBorder(
                                  //                         borderRadius:
                                  //                             BorderRadius
                                  //                                 .circular(8),
                                  //                       ),
                                  //                     ),
                                  //                     child: updateLand
                                  //                             .croploading.value
                                  //                         ? Container(
                                  //                             margin:
                                  //                                 const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     horizontal:
                                  //                                         5),
                                  //                             height: 15,
                                  //                             width: 15,
                                  //                             child:
                                  //                                 const CircularProgressIndicator(
                                  //                               color: Colors
                                  //                                   .white,
                                  //                               strokeWidth: 3,
                                  //                             ),
                                  //                           )
                                  //                         : const Text(
                                  //                             'Save',
                                  //                             style: TextStyle(
                                  //                               color: Color(
                                  //                                   0xFFFBFBFB),
                                  //                               fontSize: 12,
                                  //                               fontFamily:
                                  //                                   'Poppins',
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w600,
                                  //                               height: 0,
                                  //                             ),
                                  //                           )),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         )
                                  //       : Container();
                                  // }),
                                  // Obx(() {
                                  //   return landController.landData.value.result
                                  //               ?.isRoadAccessAdded ==
                                  //           false
                                  //       ? Container(
                                  //           margin: const EdgeInsets.symmetric(
                                  //               vertical: 20),
                                  //           padding: const EdgeInsets.symmetric(
                                  //               vertical: 10, horizontal: 15),
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             border: Border.all(
                                  //                 color: AppColor.GREY_BORDER),
                                  //             boxShadow: [AppColor.BOX_SHADOW],
                                  //             borderRadius:
                                  //                 BorderRadius.circular(18),
                                  //           ),
                                  //           child: Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             children: [
                                  //               Container(
                                  //                 margin: const EdgeInsets
                                  //                     .symmetric(vertical: 8),
                                  //                 child: Text(
                                  //                   'Is there road access to the land?',
                                  //                   style: GoogleFonts.poppins(
                                  //                     color: const Color(
                                  //                         0xFF272727),
                                  //                     fontSize: 13,
                                  //                     fontWeight:
                                  //                         FontWeight.w500,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               Row(
                                  //                 children: List.generate(
                                  //                     450 ~/ 4,
                                  //                     (index) => Expanded(
                                  //                           child: Container(
                                  //                             margin:
                                  //                                 const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     vertical:
                                  //                                         12),
                                  //                             color: index %
                                  //                                         2 ==
                                  //                                     0
                                  //                                 ? Colors
                                  //                                     .transparent
                                  //                                 : AppColor
                                  //                                     .GREY_BORDER,
                                  //                             height: 1,
                                  //                           ),
                                  //                         )),
                                  //               ),
                                  //               Row(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment
                                  //                         .spaceBetween,
                                  //                 crossAxisAlignment:
                                  //                     CrossAxisAlignment.start,
                                  //                 children: [
                                  //                   Obx(
                                  //                     () => SizedBox(
                                  //                       width: AppDimension.w *
                                  //                           0.4,
                                  //                       child:
                                  //                           RadioListTile<bool>(
                                  //                         activeColor: AppColor
                                  //                             .DARK_GREEN,
                                  //                         title: Text(
                                  //                           'Yes',
                                  //                           style: GoogleFonts
                                  //                               .poppins(
                                  //                             color: const Color(
                                  //                                 0xFF333333),
                                  //                             fontSize: 12,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .w500,
                                  //                           ),
                                  //                         ),
                                  //                         value: true,
                                  //                         groupValue: updateLand
                                  //                             .isRoadAvailable
                                  //                             .value,
                                  //                         onChanged: (value) {
                                  //                           updateLand
                                  //                               .isRoadAvailable
                                  //                               .value = value!;
                                  //                         },
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   Obx(
                                  //                     () => Expanded(
                                  //                       child:
                                  //                           RadioListTile<bool>(
                                  //                         title: Text(
                                  //                           'No',
                                  //                           style: GoogleFonts
                                  //                               .poppins(
                                  //                             color: const Color(
                                  //                                 0xFF333333),
                                  //                             fontSize: 12,
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .w500,
                                  //                           ),
                                  //                         ),
                                  //                         value: false,
                                  //                         activeColor: AppColor
                                  //                             .DARK_GREEN,
                                  //                         groupValue: updateLand
                                  //                             .isRoadAvailable
                                  //                             .value,
                                  //                         onChanged: (value) {
                                  //                           updateLand
                                  //                               .isRoadAvailable
                                  //                               .value = value!;
                                  //                         },
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //               InkWell(
                                  //                 onTap: () async {
                                  //                   await updateLand
                                  //                       .roadAvailable();
                                  //                   Future.delayed(
                                  //                       const Duration(
                                  //                           seconds: 1), () {
                                  //                     landController
                                  //                         .landDetails(
                                  //                             widget.landId);
                                  //                   });
                                  //                 },
                                  //                 child: Container(
                                  //                     margin: EdgeInsets.only(
                                  //                         left:
                                  //                             Get.width * 0.5),
                                  //                     padding: const EdgeInsets
                                  //                         .symmetric(
                                  //                       vertical: 13,
                                  //                       horizontal: 40,
                                  //                     ),
                                  //                     decoration:
                                  //                         ShapeDecoration(
                                  //                       color:
                                  //                           AppColor.DARK_GREEN,
                                  //                       shape:
                                  //                           RoundedRectangleBorder(
                                  //                         borderRadius:
                                  //                             BorderRadius
                                  //                                 .circular(8),
                                  //                       ),
                                  //                     ),
                                  //                     child: updateLand
                                  //                             .roadloading.value
                                  //                         ? Container(
                                  //                             margin:
                                  //                                 const EdgeInsets
                                  //                                     .symmetric(
                                  //                                     horizontal:
                                  //                                         5),
                                  //                             height: 15,
                                  //                             width: 15,
                                  //                             child:
                                  //                                 const CircularProgressIndicator(
                                  //                               color: Colors
                                  //                                   .white,
                                  //                               strokeWidth: 3,
                                  //                             ),
                                  //                           )
                                  //                         : const Text(
                                  //                             'Save',
                                  //                             style: TextStyle(
                                  //                               color: Color(
                                  //                                   0xFFFBFBFB),
                                  //                               fontSize: 12,
                                  //                               fontFamily:
                                  //                                   'Poppins',
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .w600,
                                  //                               height: 0,
                                  //                             ),
                                  //                           )),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         )
                                  //       : Container();
                                  // }),
                                  // // Obx(() {
                                  // //   return landController.landData.value.result
                                  // //               ?.isOrganicCertificationAdded ==
                                  // //           false
                                  // //       ? Container(
                                  // //           margin:
                                  // //               EdgeInsets.symmetric(vertical: 20),
                                  // //           padding: EdgeInsets.symmetric(
                                  // //               vertical: 10, horizontal: 15),
                                  // //           decoration: BoxDecoration(
                                  // //             color: Colors.white,
                                  // //             border: Border.all(
                                  // //                 color: AppColor.GREY_BORDER),
                                  // //             boxShadow: [AppColor.BOX_SHADOW],
                                  // //             borderRadius: BorderRadius.circular(18),
                                  // //           ),
                                  // //           child: Column(
                                  // //             crossAxisAlignment:
                                  // //                 CrossAxisAlignment.start,
                                  // //             children: [
                                  // //               Align(
                                  // //                 alignment: Alignment.topLeft,
                                  // //                 child: Text(
                                  // //                   'Is this property certified organic, or does it qualify for organic certification under federal organic regulations?',
                                  // //                   style: GoogleFonts.poppins(
                                  // //                     color: Color(0xFF272727),
                                  // //                     fontSize: 13,
                                  // //                     fontWeight: FontWeight.w500,
                                  // //                   ),
                                  // //                 ),
                                  // //               ),
                                  // //               Row(
                                  // //                 children: List.generate(
                                  // //                     450 ~/ 4,
                                  // //                     (index) => Expanded(
                                  // //                           child: Container(
                                  // //                             margin: EdgeInsets
                                  // //                                 .symmetric(
                                  // //                                     vertical: 12),
                                  // //                             color: index % 2 == 0
                                  // //                                 ? Colors.transparent
                                  // //                                 : AppColor
                                  // //                                     .GREY_BORDER,
                                  // //                             height: 1,
                                  // //                           ),
                                  // //                         )),
                                  // //               ),
                                  // //               Row(
                                  // //                 mainAxisAlignment:
                                  // //                     MainAxisAlignment.spaceBetween,
                                  // //                 crossAxisAlignment:
                                  // //                     CrossAxisAlignment.start,
                                  // //                 children: [
                                  // //                   Obx(
                                  // //                     () => Container(
                                  // //                       width: AppDimension.w * 0.4,
                                  // //                       child: RadioListTile<bool>(
                                  // //                         activeColor:
                                  // //                             AppColor.DARK_GREEN,
                                  // //                         title: Text(
                                  // //                           'Yes',
                                  // //                           style:
                                  // //                               GoogleFonts.poppins(
                                  // //                             color:
                                  // //                                 Color(0xFF333333),
                                  // //                             fontSize: 12,
                                  // //                             fontWeight:
                                  // //                                 FontWeight.w500,
                                  // //                           ),
                                  // //                         ),
                                  // //                         value: true,
                                  // //                         groupValue: updateLand
                                  // //                             .isCertified.value,
                                  // //                         onChanged: (value) {
                                  // //                           updateLand.isCertified
                                  // //                               .value = value!;
                                  // //                         },
                                  // //                       ),
                                  // //                     ),
                                  // //                   ),
                                  // //                   Obx(
                                  // //                     () => Expanded(
                                  // //                       child: RadioListTile<bool>(
                                  // //                         title: Text(
                                  // //                           'No',
                                  // //                           style:
                                  // //                               GoogleFonts.poppins(
                                  // //                             color:
                                  // //                                 Color(0xFF333333),
                                  // //                             fontSize: 12,
                                  // //                             fontWeight:
                                  // //                                 FontWeight.w500,
                                  // //                           ),
                                  // //                         ),
                                  // //                         value: false,
                                  // //                         activeColor:
                                  // //                             AppColor.DARK_GREEN,
                                  // //                         groupValue: updateLand
                                  // //                             .isCertified.value,
                                  // //                         onChanged: (value) {
                                  // //                           updateLand.isCertified
                                  // //                               .value = value!;
                                  // //                         },
                                  // //                       ),
                                  // //                     ),
                                  // //                   ),
                                  // //                 ],
                                  // //               ),
                                  // //               updateLand.isCertified.value
                                  // //                   ? updateLand.selectedPdf.value !=
                                  // //                           null
                                  // //                       ? Container(
                                  // //                           margin:
                                  // //                               EdgeInsets.symmetric(
                                  // //                                   vertical: 10,
                                  // //                                   horizontal: 10),
                                  // //                           padding:
                                  // //                               EdgeInsets.symmetric(
                                  // //                                   vertical: 10,
                                  // //                                   horizontal: 10),
                                  // //                           decoration: BoxDecoration(
                                  // //                             borderRadius:
                                  // //                                 BorderRadius
                                  // //                                     .circular(18),
                                  // //                             border: Border.all(
                                  // //                                 color: AppColor
                                  // //                                     .GREY_BORDER),
                                  // //                           ),
                                  // //                           child: Column(
                                  // //                             crossAxisAlignment:
                                  // //                                 CrossAxisAlignment
                                  // //                                     .center,
                                  // //                             children: [
                                  // //                               Container(
                                  // //                                   margin: EdgeInsets
                                  // //                                       .only(
                                  // //                                           top: 20),
                                  // //                                   child: SvgPicture
                                  // //                                       .asset(
                                  // //                                     "assets/logos/doc.svg",
                                  // //                                     width: 30,
                                  // //                                   )),
                                  // //                               Container(
                                  // //                                 margin: EdgeInsets
                                  // //                                     .symmetric(
                                  // //                                         vertical:
                                  // //                                             20,
                                  // //                                         horizontal:
                                  // //                                             20),
                                  // //                                 child: Text(
                                  // //                                   "${updateLand.selectedPdf.value?.path != null ? updateLand.selectedPdf.value!.path.split('/').last : ''}",
                                  // //                                   style: GoogleFonts
                                  // //                                       .poppins(
                                  // //                                     color: Color(
                                  // //                                         0xFF283037),
                                  // //                                     fontSize: 10,
                                  // //                                     fontWeight:
                                  // //                                         FontWeight
                                  // //                                             .w400,
                                  // //                                   ),
                                  // //                                 ),
                                  // //                               ),
                                  // //                             ],
                                  // //                           ),
                                  // //                         )
                                  // //                       : InkWell(
                                  // //                           onTap: () {
                                  // //                             updateLand.pickPdf();
                                  // //                           },
                                  // //                           child: Container(
                                  // //                             margin: EdgeInsets
                                  // //                                 .symmetric(
                                  // //                                     vertical: 10,
                                  // //                                     horizontal: 10),
                                  // //                             padding: EdgeInsets
                                  // //                                 .symmetric(
                                  // //                                     vertical: 10,
                                  // //                                     horizontal: 10),
                                  // //                             decoration:
                                  // //                                 BoxDecoration(
                                  // //                               borderRadius:
                                  // //                                   BorderRadius
                                  // //                                       .circular(18),
                                  // //                               border: Border.all(
                                  // //                                   color: AppColor
                                  // //                                       .GREY_BORDER),
                                  // //                             ),
                                  // //                             child: Column(
                                  // //                               crossAxisAlignment:
                                  // //                                   CrossAxisAlignment
                                  // //                                       .center,
                                  // //                               children: [
                                  // //                                 Container(
                                  // //                                     margin: EdgeInsets
                                  // //                                         .symmetric(
                                  // //                                             vertical:
                                  // //                                                 10),
                                  // //                                     child:
                                  // //                                         SvgPicture
                                  // //                                             .asset(
                                  // //                                       "assets/logos/doc.svg",
                                  // //                                       width: 30,
                                  // //                                     )),
                                  // //                                 Container(
                                  // //                                   margin: EdgeInsets
                                  // //                                       .symmetric(
                                  // //                                           vertical:
                                  // //                                               2,
                                  // //                                           horizontal:
                                  // //                                               10),
                                  // //                                   child: Text(
                                  // //                                     "Browse document\n",
                                  // //                                     style:
                                  // //                                         GoogleFonts
                                  // //                                             .poppins(
                                  // //                                       color: Color(
                                  // //                                           0xFF283037),
                                  // //                                       fontSize: 10,
                                  // //                                       fontWeight:
                                  // //                                           FontWeight
                                  // //                                               .w400,
                                  // //                                     ),
                                  // //                                   ),
                                  // //                                 ),
                                  // //                                 Container(
                                  // //                                   margin: EdgeInsets
                                  // //                                       .only(
                                  // //                                           bottom:
                                  // //                                               15),
                                  // //                                   child: Text(
                                  // //                                     "to Upload",
                                  // //                                     style:
                                  // //                                         GoogleFonts
                                  // //                                             .poppins(
                                  // //                                       color: Color(
                                  // //                                           0xFF6E7B89),
                                  // //                                       fontSize: 10,
                                  // //                                       height: -0.07,
                                  // //                                       fontWeight:
                                  // //                                           FontWeight
                                  // //                                               .w400,
                                  // //                                     ),
                                  // //                                   ),
                                  // //                                 ),
                                  // //                               ],
                                  // //                             ),
                                  // //                           ),
                                  // //                         )
                                  // //                   : Container(),
                                  // //               InkWell(
                                  // //                 onTap: () async {
                                  // //                   updateLand.isCertified.value
                                  // //                       ? await updateLand
                                  // //                           .selectedPDF()
                                  // //                       : await updateLand
                                  // //                           .certificationValue();
                                  // //                   Future.delayed(
                                  // //                       const Duration(seconds: 1),
                                  // //                       () {
                                  // //                     landController
                                  // //                         .landDetails(widget.landId);
                                  // //                   });
                                  // //                 },
                                  // //                 child: Container(
                                  // //                   margin: EdgeInsets.only(
                                  // //                       left: Get.width * 0.5),
                                  // //                   padding:
                                  // //                       const EdgeInsets.symmetric(
                                  // //                           vertical: 13,
                                  // //                           horizontal: 40),
                                  // //                   decoration: ShapeDecoration(
                                  // //                     color: AppColor.DARK_GREEN,
                                  // //                     shape: RoundedRectangleBorder(
                                  // //                         borderRadius:
                                  // //                             BorderRadius.circular(
                                  // //                                 8)),
                                  // //                   ),
                                  // //                   child: updateLand.pdfloading.value
                                  // //                       ? Container(
                                  // //                           margin:
                                  // //                               EdgeInsets.symmetric(
                                  // //                                   horizontal: 5),
                                  // //                           height: 15,
                                  // //                           width: 15,
                                  // //                           child:
                                  // //                               CircularProgressIndicator(
                                  // //                             color: Colors.white,
                                  // //                             strokeWidth: 3,
                                  // //                           ),
                                  // //                         )
                                  // //                       : Text(
                                  // //                           'Save',
                                  // //                           style: TextStyle(
                                  // //                             color:
                                  // //                                 Color(0xFFFBFBFB),
                                  // //                             fontSize: 12,
                                  // //                             fontFamily: 'Poppins',
                                  // //                             fontWeight:
                                  // //                                 FontWeight.w600,
                                  // //                             height: 0,
                                  // //                           ),
                                  // //                         ),
                                  // //                 ),
                                  // //               )
                                  // //             ],
                                  // //           ),
                                  // //         )
                                  // //       : Container();
                                  // // }),
                                  // Obx(() {
                                  //   return landController.landData.value.result
                                  //               ?.isLandPhotoAdded ==
                                  //           false
                                  //       ? Container(
                                  //           margin: const EdgeInsets.symmetric(
                                  //               vertical: 20),
                                  //           padding: const EdgeInsets.symmetric(
                                  //               vertical: 10, horizontal: 15),
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             border: Border.all(
                                  //                 color: AppColor.GREY_BORDER),
                                  //             boxShadow: [AppColor.BOX_SHADOW],
                                  //             borderRadius:
                                  //                 BorderRadius.circular(18),
                                  //           ),
                                  //           child: Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             children: [
                                  //               const Text(
                                  //                 'Add up to 6 photos of your land.',
                                  //                 style: TextStyle(
                                  //                   color: Color(0xFF272727),
                                  //                   fontSize: 14,
                                  //                   fontFamily: 'Poppins',
                                  //                   fontWeight: FontWeight.w600,
                                  //                 ),
                                  //               ),
                                  //               Container(
                                  //                 margin: const EdgeInsets
                                  //                     .symmetric(vertical: 8),
                                  //                 child: Text(
                                  //                   'Added ${imageController.photoAdded}/6',
                                  //                   style: const TextStyle(
                                  //                     color: Color(0xFF757575),
                                  //                     fontSize: 10,
                                  //                     fontFamily: 'Poppins',
                                  //                     fontWeight:
                                  //                         FontWeight.w500,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               GridView.builder(
                                  //                 physics:
                                  //                     const NeverScrollableScrollPhysics(),
                                  //                 shrinkWrap: true,
                                  //                 gridDelegate:
                                  //                     const SliverGridDelegateWithFixedCrossAxisCount(
                                  //                   crossAxisCount: 3,
                                  //                   crossAxisSpacing: 8,
                                  //                   mainAxisSpacing: 8,
                                  //                 ),
                                  //                 itemCount: imageController
                                  //                             .photos.length <
                                  //                         6
                                  //                     ? imageController
                                  //                             .photos.length +
                                  //                         1
                                  //                     : 6,
                                  //                 itemBuilder:
                                  //                     (context, index) {
                                  //                   if (index <
                                  //                       imageController
                                  //                           .photos.length) {
                                  //                     return Stack(
                                  //                       children: [
                                  //                         Container(
                                  //                           decoration:
                                  //                               BoxDecoration(
                                  //                             image:
                                  //                                 DecorationImage(
                                  //                               image: FileImage(File(
                                  //                                   imageController
                                  //                                           .photos[
                                  //                                       index])),
                                  //                               fit: BoxFit
                                  //                                   .cover,
                                  //                             ),
                                  //                             borderRadius:
                                  //                                 BorderRadius
                                  //                                     .circular(
                                  //                                         12),
                                  //                           ),
                                  //                         ),
                                  //                         Positioned(
                                  //                           top: 0,
                                  //                           right: 0,
                                  //                           child: InkWell(
                                  //                             onTap: () {
                                  //                               imageController
                                  //                                   .deleteImage(
                                  //                                       index);
                                  //                               imageController
                                  //                                   .deleteImageLocal(
                                  //                                       index);
                                  //                             },
                                  //                             child: Container(
                                  //                               height: 28,
                                  //                               padding:
                                  //                                   const EdgeInsets
                                  //                                       .all(4),
                                  //                               decoration:
                                  //                                   const BoxDecoration(
                                  //                                 shape: BoxShape
                                  //                                     .circle,
                                  //                                 color: Color
                                  //                                     .fromARGB(
                                  //                                         255,
                                  //                                         244,
                                  //                                         67,
                                  //                                         54),
                                  //                               ),
                                  //                               child:
                                  //                                   const Icon(
                                  //                                 Icons.close,
                                  //                                 color: Colors
                                  //                                     .white,
                                  //                                 size: 18,
                                  //                               ),
                                  //                             ),
                                  //                           ),
                                  //                         ),
                                  //                       ],
                                  //                     );
                                  //                   } else if (index ==
                                  //                           imageController
                                  //                               .photos
                                  //                               .length &&
                                  //                       index < 6) {
                                  //                     return Visibility(
                                  //                       visible: imageController
                                  //                               .photos.length <
                                  //                           6,
                                  //                       child: InkWell(
                                  //                         onTap: () {
                                  //                           imageController
                                  //                               .getImages();
                                  //                         },
                                  //                         child: DottedBorder(
                                  //                           borderType:
                                  //                               BorderType
                                  //                                   .RRect,
                                  //                           color: AppColor
                                  //                               .DARK_GREEN,
                                  //                           dashPattern: const [
                                  //                             9,
                                  //                             4
                                  //                           ],
                                  //                           radius: const Radius
                                  //                               .circular(12),
                                  //                           child: ClipRRect(
                                  //                             borderRadius:
                                  //                                 const BorderRadius
                                  //                                     .all(
                                  //                                     Radius.circular(
                                  //                                         12)),
                                  //                             child: Container(
                                  //                               color: const Color(
                                  //                                   0x1E044D3A),
                                  //                               child: Center(
                                  //                                 child: Column(
                                  //                                   mainAxisAlignment:
                                  //                                       MainAxisAlignment
                                  //                                           .center,
                                  //                                   children: [
                                  //                                     SvgPicture
                                  //                                         .asset(
                                  //                                       'assets/logos/gallery.svg',
                                  //                                       height:
                                  //                                           24,
                                  //                                     ),
                                  //                                     const SizedBox(
                                  //                                         height:
                                  //                                             10),
                                  //                                     Text(
                                  //                                       "Browse",
                                  //                                       style: GoogleFonts
                                  //                                           .poppins(
                                  //                                         fontSize:
                                  //                                             11,
                                  //                                         fontWeight:
                                  //                                             FontWeight.w400,
                                  //                                         color:
                                  //                                             AppColor.DARK_GREEN,
                                  //                                       ),
                                  //                                     ),
                                  //                                     Text(
                                  //                                       "Photos",
                                  //                                       style: GoogleFonts
                                  //                                           .poppins(
                                  //                                         fontSize:
                                  //                                             11,
                                  //                                         fontWeight:
                                  //                                             FontWeight.w400,
                                  //                                         color:
                                  //                                             const Color(0xFF73817B),
                                  //                                       ),
                                  //                                     ),
                                  //                                   ],
                                  //                                 ),
                                  //                               ),
                                  //                             ),
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                     );
                                  //                   } else {
                                  //                     return Container();
                                  //                   }
                                  //                 },
                                  //               ),
                                  //               InkWell(
                                  //                 onTap: () {
                                  //                   imageController.updateImg();
                                  //                   Future.delayed(
                                  //                       const Duration(
                                  //                           seconds: 1), () {
                                  //                     landController
                                  //                         .landDetails(
                                  //                             widget.landId);
                                  //                   });
                                  //                   print(
                                  //                       "Uploaded IDs: ${imageController.uploadedIds.value}");
                                  //                 },
                                  //                 child: Container(
                                  //                   margin: EdgeInsets.only(
                                  //                       left: Get.width * 0.5,
                                  //                       top: 10),
                                  //                   padding: const EdgeInsets
                                  //                       .symmetric(
                                  //                       vertical: 13,
                                  //                       horizontal: 40),
                                  //                   decoration: ShapeDecoration(
                                  //                     color:
                                  //                         AppColor.DARK_GREEN,
                                  //                     shape:
                                  //                         RoundedRectangleBorder(
                                  //                             borderRadius:
                                  //                                 BorderRadius
                                  //                                     .circular(
                                  //                                         8)),
                                  //                   ),
                                  //                   child: imageController
                                  //                           .loading.value
                                  //                       ? Container(
                                  //                           margin:
                                  //                               const EdgeInsets
                                  //                                   .symmetric(
                                  //                                   horizontal:
                                  //                                       5),
                                  //                           height: 15,
                                  //                           width: 15,
                                  //                           child:
                                  //                               const CircularProgressIndicator(
                                  //                             color:
                                  //                                 Colors.white,
                                  //                             strokeWidth: 3,
                                  //                           ),
                                  //                         )
                                  //                       : const Text(
                                  //                           'Save',
                                  //                           style: TextStyle(
                                  //                             color: Color(
                                  //                                 0xFFFBFBFB),
                                  //                             fontSize: 12,
                                  //                             fontFamily:
                                  //                                 'Poppins',
                                  //                             fontWeight:
                                  //                                 FontWeight
                                  //                                     .w600,
                                  //                           ),
                                  //                         ),
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         )
                                  //       : Container(
                                  //           margin: const EdgeInsets.symmetric(
                                  //               vertical: 10),
                                  //         );
                                  // })
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
              })),
        ));
  }
}
