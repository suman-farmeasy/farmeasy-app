import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/Screens/ChatSection/view/chat_ui.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/View/pdf_viwer.dart';
import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/Controller/recommended_land_deails_controller.dart';
import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/Controller/recommended_land_weather.dart';
import 'package:farm_easy/Screens/WeatherScreen/View/weather_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendedLandInfo extends StatefulWidget {
  RecommendedLandInfo({super.key, required this.id, required this.name});
  final int id;
  final String name;

  @override
  State<RecommendedLandInfo> createState() => _RecommendedLandInfoState();
}

class _RecommendedLandInfoState extends State<RecommendedLandInfo> {
  final controller = Get.put(RecommendedLandDetailsController());
  final currentWeather = Get.put(RecommendedLandWeatherController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getLandDetails();
  }

  @override
  Widget build(BuildContext context) {
    controller.landId.value = widget.id;
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.1),
        child: AppBar(
          backgroundColor: AppColor.DARK_GREEN,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 60, left: 10, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                    // Get.to(() => DashBoard());
                    // final dashboardControllers = Get.find<DashboardController>();
                    // if (dashboardControllers != null) {
                    //   dashboardControllers.homecontroller.landListData();
                    // }
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white),
                ),
                Text(
                  ' Land Details',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    height: 0.09,
                  ),
                ),
                Text(
                  '(#${widget.id})',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 0.09,
                  ),
                ),
              ],
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return InkWell(
                        onTap: () {
                          double? longitude = double.tryParse(
                              controller.landDetails.value.result!.longitude ??
                                  '');
                          double? latitude = double.tryParse(
                              controller.landDetails.value.result!.latitude ??
                                  '');

                          if (longitude != null && latitude != null) {
                            Get.to(() =>
                                WeatherScreen(lat: latitude, long: longitude));
                          } else {
                            print('Invalid latitude or longitude values');
                          }
                        },
                        child: Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: AppColor.PRIMARY_GRADIENT,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${currentWeather.currentWeatherData.value.name ?? ""}',
                                      style: GoogleFonts.poppins(
                                        color: Color(0xFF483C32),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
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
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, weatherIndex) {
                                            return Text(
                                              textAlign: TextAlign.start,
                                              '${currentWeather.currentWeatherData.value.weather?[weatherIndex].main ?? ""}',
                                              style: GoogleFonts.poppins(
                                                color: AppColor.BROWN_TEXT,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
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
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, weatherIndex) {
                                            String iconUrl =
                                                "http://openweathermap.org/img/wn/${currentWeather.currentWeatherData.value.weather?[weatherIndex].icon}.png";
                                            return Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              iconUrl),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                    Text(
                                      'Min: ${currentWeather.currentWeatherData.value.main?.tempMin?.toInt() ?? 0}º / Max: ${currentWeather.currentWeatherData.value.main?.tempMax?.toInt() ?? 0}º',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        color: Color(0xCC61646B),
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
                    Obx(() {
                      return controller.landDetails.value.result?.landImages
                                  ?.length !=
                              0
                          ? Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              height: Get.height * 0.25,
                              child: ListView.builder(
                                itemCount: controller.landDetails.value.result
                                        ?.landImages?.length ??
                                    0,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, img) {
                                  String imageUrl = controller.landDetails.value
                                          .result?.landImages?[img].image ??
                                      "";
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() =>
                                          ImageViewPage(imageUrl: imageUrl));
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: Get.width * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container();
                    }),
                    Obx(() {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                color: Colors.white,
                                boxShadow: [AppColor.BOX_SHADOW]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: Text(
                                    '${widget.name ?? ""}',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF483C32),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                      450 ~/ 4,
                                      (index) => Expanded(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              color: index % 2 == 0
                                                  ? Colors.transparent
                                                  : AppColor.GREY_BORDER,
                                              height: 1,
                                            ),
                                          )),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          height: 40,
                                          width: 40,
                                        ),
                                        Text(
                                          "Land #${widget.id}",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            color: AppColor.DARK_GREEN,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            height: 2.5,
                                          ),
                                        ),
                                        Container(
                                          width: Get.width * 0.25,
                                          child: Text(
                                            "${controller.landDetails.value.result?.address ?? ""}",
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
                                              height: 40,
                                              width: 40,
                                            ),
                                            Container(
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
                                                "${controller.landDetails.value.result?.landSize ?? ""}",
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
                                              height: 40,
                                              width: 40,
                                            ),
                                            Text(
                                              'Crop Preferences',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                color: AppColor.DARK_GREEN,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                height: 2.5,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                              width: Get.width * 0.2,
                                              child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: controller
                                                        .landDetails
                                                        .value
                                                        .result
                                                        ?.cropToGrow
                                                        ?.length ??
                                                    0,
                                                itemBuilder:
                                                    (context, cropdata) {
                                                  return Text(
                                                    "${controller.landDetails.value.result?.cropToGrow?[cropdata].name ?? ""}",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
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
                                                    style: GoogleFonts.poppins(
                                                      color: Color(0xFF044D3A),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor:
                                                          AppColor.DARK_GREEN,
                                                    )),
                                                Text(
                                                  '${controller.landDetails.value.result?.purpose?.name ?? ""}',
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0xFF044D3A),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
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
                          InkWell(
                            onTap: () {
                              Get.to(() => ChatScreen(
                                  landId: widget.id,
                                  enquiryId: controller.landDetails.value.result
                                          ?.enquiryId ??
                                      0,
                                  userId: controller.landDetails.value.result
                                          ?.landOwnerUserId
                                          ?.toInt() ??
                                      0,
                                  userName: controller.landDetails.value.result
                                          ?.landOwnerName ??
                                      "",
                                  userFrom: controller.landDetails.value.result
                                          ?.landOwnerLocation ??
                                      "",
                                  userType: controller.landDetails.value.result
                                          ?.landOwnerUserType ??
                                      "",
                                  image: controller.landDetails.value.result
                                          ?.landOwnerImage ??
                                      "",
                                  enquiryData: "",
                                  isEnquiryCreatedByMe: false,
                                  isEnquiryDisplay: false));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              margin: EdgeInsets.symmetric(horizontal: 10),
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
                            ),
                          )
                        ],
                      );
                    }),
                    Obx(() {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColor.GREY_BORDER),
                          boxShadow: [AppColor.BOX_SHADOW],
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Text(
                                "Additional Information",
                                style: GoogleFonts.poppins(
                                  color: AppColor.BROWN_TEXT,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Row(
                              children: List.generate(
                                  450 ~/ 4,
                                  (index) => Expanded(
                                        child: Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 5),
                                          color: index % 2 == 0
                                              ? Colors.transparent
                                              : AppColor.GREY_BORDER,
                                          height: 1,
                                        ),
                                      )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Get.width * 0.6,
                                  margin: EdgeInsets.only(top: 5),
                                  child: ListTile(
                                    leading: SvgPicture.asset(
                                      "assets/farm/area.svg",
                                      width: 30,
                                    ),
                                    title: Text(
                                      'Area',
                                      style: GoogleFonts.poppins(
                                        color: AppColor.DARK_GREEN,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${controller.landDetails.value.result?.landSize ?? ""}',
                                      style: GoogleFonts.poppins(
                                        color: Color(0xA3044D3A),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Color(0xFFE6E6E6),
                            ),
                            ListTile(
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
                                '${controller.landDetails.value.result?.address ?? ""}',
                                style: GoogleFonts.poppins(
                                  color: Color(0xA3044D3A),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                            Divider(
                              color: Color(0xFFE6E6E6),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                "assets/farm/target.svg",
                                width: 30,
                              ),
                              title: Text(
                                'Purpose',
                                style: GoogleFonts.poppins(
                                  color: AppColor.DARK_GREEN,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                '${controller.landDetails.value.result?.purpose?.name ?? ""}',
                                style: GoogleFonts.poppins(
                                  color: Color(0xA3044D3A),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                            Divider(
                              color: Color(0xFFE6E6E6),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                "assets/farm/cultivation.svg",
                                width: 30,
                              ),
                              title: Text(
                                'What kind of crop do you want to grow',
                                style: GoogleFonts.poppins(
                                  color: AppColor.DARK_GREEN,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Container(
                                height: 15,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.landDetails.value.result
                                          ?.cropToGrow?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    final crop = controller.landDetails.value
                                        .result!.cropToGrow![index];
                                    return Text(
                                      " ${crop.name ?? ""},",
                                      style: GoogleFonts.poppins(
                                        color: Color(0xA3044D3A),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: SvgPicture.asset(
                                    "assets/farm/family.svg",
                                    width: 30,
                                  ),
                                  title: Text(
                                    'Shelter Available',
                                    style: GoogleFonts.poppins(
                                      color: AppColor.DARK_GREEN,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${controller.landDetails.value.result?.accomodationAvailable == false ? "Unavailable" : "Available"}',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xA3044D3A),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Color(0xFFE6E6E6),
                                ),
                                ListTile(
                                  leading: SvgPicture.asset(
                                    "assets/farm/forest.svg",
                                    width: 30,
                                  ),
                                  title: Text(
                                    'Land Type',
                                    style: GoogleFonts.poppins(
                                      color: AppColor.DARK_GREEN,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    controller.landDetails.value.result
                                                ?.landType?.name ==
                                            ""
                                        ? "------"
                                        : '${controller.landDetails.value.result?.landType?.name ?? "-----"}',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xA3044D3A),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Color(0xFFE6E6E6),
                                ),
                                ListTile(
                                  leading: SvgPicture.asset(
                                    "assets/farm/farm.svg",
                                    width: 30,
                                  ),
                                  title: Text(
                                    'Is this land previously cultivated?',
                                    style: GoogleFonts.poppins(
                                      color: AppColor.DARK_GREEN,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        " ${controller.landDetails.value.result?.landFarmedBefore == true ? 'yes, ' : 'No '}",
                                        style: GoogleFonts.poppins(
                                          color: Color(0xA3044D3A),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                      Container(
                                        height: 15,
                                        width: Get.size.width * 0.5,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: controller
                                                  .landDetails
                                                  .value
                                                  .result
                                                  ?.cropsGrown
                                                  ?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            final crop = controller
                                                .landDetails
                                                .value
                                                .result
                                                ?.cropsGrown?[index];
                                            return Text(
                                              " ${crop?.name ?? ""},",
                                              style: GoogleFonts.poppins(
                                                color: Color(0xA3044D3A),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Color(0xFFE6E6E6),
                                ),
                                ListTile(
                                  leading: SvgPicture.asset(
                                    "assets/farm/road.svg",
                                    width: 30,
                                  ),
                                  title: Text(
                                    'Road access',
                                    style: GoogleFonts.poppins(
                                      color: AppColor.DARK_GREEN,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${controller.landDetails.value.result?.roadAccess == false ? 'Unavailable' : 'Available'}',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xA3044D3A),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Color(0xFFE6E6E6),
                                ),
                                ListTile(
                                  leading: SvgPicture.asset(
                                    "assets/farm/compost.svg",
                                    width: 30,
                                  ),
                                  title: Text(
                                    'Organic Farm Certified',
                                    style: GoogleFonts.poppins(
                                      color: AppColor.DARK_GREEN,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${controller.landDetails.value.result?.organicCertification == true ? 'yes ' : 'No '}',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xA3044D3A),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Color(0xFFE6E6E6),
                                ),
                                ListTile(
                                  leading: SvgPicture.asset(
                                    "assets/farm/sea.svg",
                                    width: 30,
                                  ),
                                  title: Text(
                                    'Water Sources Available?',
                                    style: GoogleFonts.poppins(
                                      color: AppColor.DARK_GREEN,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${controller.landDetails.value.result?.waterSourceAvailable == true ? '${controller.landDetails.value.result?.waterSource?.name} ' : 'Unavailable '}',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xA3044D3A),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Color(0xFFE6E6E6),
                                ),
                                ListTile(
                                  leading: SvgPicture.asset(
                                    "assets/farm/engineering.svg",
                                    width: 30,
                                  ),
                                  title: Text(
                                    'Equipment & Machinery Available',
                                    style: GoogleFonts.poppins(
                                      color: AppColor.DARK_GREEN,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    ' ${controller.landDetails.value.result?.equipmentAvailable == true ? "${controller.landDetails.value.result?.equipment}" : "Unavailable"}',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xA3044D3A),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Color(0xFFE6E6E6),
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
                                    leading: SvgPicture.asset(
                                      "assets/farm/file.svg",
                                      width: 30,
                                    ),
                                    title: Text(
                                      'Supporting Documents',
                                      style: GoogleFonts.poppins(
                                        color: AppColor.DARK_GREEN,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: controller
                                                .landDetails
                                                .value
                                                .result
                                                ?.certificationDocumnet ==
                                            null
                                        ? Text(
                                            "------",
                                            style: GoogleFonts.poppins(
                                              color: Color(0xA3044D3A),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              Get.to(() => PdfViewer(
                                                    pdfUrl:
                                                        "${controller.landDetails.value.result?.certificationDocumnet ?? ""}",
                                                  ));
                                            },
                                            child: Text(
                                              "View",
                                              style: GoogleFonts.poppins(
                                                color: Colors.blue,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                // decoration: TextDecoration.underline,
                                                height: 0,
                                              ),
                                            ),
                                          )),
                              ],
                            ))
                          ],
                        ),
                      );
                    })
                  ],
                );
        }),
      ),
      // bottomNavigationBar: Container(
      //   height: Get.height*0.06,
      //   margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      //   decoration: BoxDecoration(
      //     color: AppColor.DARK_GREEN,
      //         borderRadius: BorderRadius.circular(10),
      //   ),
      //   child: InkWell(
      //     onTap:(){
      // Get.to(()=>ChatScreen(
      // landId: widget.id,
      // enquiryId: controller.landDetails.value.result?.enquiryId??0,
      // userId: controller.landDetails.value.result?.landOwnerUserId?.toInt()??0,
      // userName: controller.landDetails.value.result?.landOwnerName??"",
      // userFrom: controller.landDetails.value.result?.landOwnerLocation??"",
      // userType: controller.landDetails.value.result?.landOwnerUserType??"",
      // image: controller.landDetails.value.result?.landOwnerImage??"",
      // enquiryData: "",
      // isEnquiryCreatedByMe: false,
      // isEnquiryDisplay: false)
      // );
      // },
      //     child: Center(child: Text(
      //       'Contact Land Owner',
      //       style: GoogleFonts.poppins(
      //         color: Colors.white,
      //         fontSize: 14,
      //         fontWeight: FontWeight.w600,
      //         height: 0,
      //       ),
      //     ),),
      //   ),
      // ),
    );
  }
}

class ImageViewPage extends StatelessWidget {
  final String imageUrl;

  ImageViewPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image View")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SafeArea(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
