import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/utils/Constants/string_constant.dart';
import 'package:farm_easy/Screens/AllEnquiries/Controller/all_enquiries_controller.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/View/complete_profile.dart';
import 'package:farm_easy/Screens/ChatGpt/View/chat_gpt_start_Screen.dart';
import 'package:farm_easy/Screens/ChatSection/view/chat_ui.dart';
import 'package:farm_easy/Screens/Dashboard/controller/dashboard_controller.dart';
import 'package:farm_easy/Screens/FertilizerCalculator/Controller/fertilizer_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/agri_provider_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/crop_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/crop_fertilizer_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/crop_grid_calculator.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/farmer_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/home_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/matching_farmer.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/recomended_land_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/recommended_landowners.dart';
import 'package:farm_easy/Screens/HomeScreen/ProfielSection/Controller/profile_complete_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/VIew/add_land.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/View/land_details.dart';
import 'package:farm_easy/Screens/LandSection/MyLands/View/home_screen_land.dart';
import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/view/recomended_land_info.dart';
import 'package:farm_easy/Screens/LandSection/Recommended%20Lands%20List/View/view.dart';
import 'package:farm_easy/Screens/ProductAndServices/Controller/product_view_controller.dart';
import 'package:farm_easy/Screens/ProductAndServices/View/add_product.dart';
import 'package:farm_easy/Screens/RecommendedLandowners/view.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:farm_easy/Screens/WeatherScreen/Controller/current_weather_controller.dart';
import 'package:farm_easy/Screens/notification_controller.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/localization/translated_text_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../utils/localization/localization_controller.dart';
import '../Widgets/add_land_widget.dart';
import '../Widgets/add_product_widget.dart';
import '../Widgets/farmer_body_widget.dart';
import '../Widgets/homeScreen_android_appbar.dart';
import '../Widgets/homeScreen_ios_appbar.dart';
import '../Widgets/landowner_body_widget.dart';
import '../Widgets/partner_body_widget.dart';
import '../Widgets/profile_completion_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final localeController = Get.put(LocaleController());
  final homecontroller = Get.put(HomeController());
  final dashboardController = Get.put(DashboardController());
  final profilePercentageController = Get.put(ProfilePercentageController());
  final currentWeather = Get.put(CurrentWeatherController());
  final recommendedlandController = Get.put(RecommendedLandController());
  final agriController = Get.put(ListAgriProviderController());
  final farmerController = Get.put(ListFarmerController());
  final recoLandowner = Get.put(RecommendedLandownersController());
  final cropController = Get.put(CropController());
  final cropgridCalculator = Get.put(CropGridCalculator());
  final cropFertilizer = Get.put(CropFertilizerController());
  final cropFertilizerCalculator = Get.put(FertilizerCalculatedController());

  final enqcontroller = Get.put(AllEnquiriesController());
  final getProfileController = Get.put(GetProfileController());
  final controller = Get.put(ProductViewController());

  var db = Hive.box('appData');
  var selectedLang;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transLateApp();
    PushNotifications.init();
    PushNotifications.localNotiInit();
    getProfileController.getProfile();
    controller.productList(
        userId: getProfileController.getProfileData.value.result?.userId ?? 0);
  }

  void transLateApp() {
    log(db.get('selectedLanguage'));
    db.get('selectedLanguage') == 'Hindi'
        ? selectedLang = 'hi'
        : db.get('selectedLanguage') == 'English'
            ? selectedLang = 'en'
            : db.get('selectedLanguage') == 'Punjabi'
                ? selectedLang = 'pa'
                : selectedLang = 'en';
  }

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.BACKGROUND,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
          child: isIOS ? HomeScreenIOS_AppBar() : HomeScreenANDROID_AppBar(),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              homecontroller.landListData();
              profilePercentageController.profilePercentage();
              currentWeather.currentWeather();
              farmerController.farmerList();
              enqcontroller.refreshAllEnquiries();
              recommendedlandController.recommendedLandData(100);
              controller.productList(
                  userId: getProfileController
                          .getProfileData.value.result?.userId ??
                      0);
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // For Displaying Username
                          FutureBuilder<String>(
                            future: homecontroller.prefs.getUserName(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return TranslateTextBox(
                                    text: 'Error: ${snapshot.error}',
                                    toLanguage: selectedLang);
                              } else {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'hi'.tr,
                                        style: const TextStyle(
                                          color: Color(0xFF483C32),
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        ' ,${snapshot.data}',
                                        style: const TextStyle(
                                          color: Color(0xFF483C32),
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),

                          // Displaying Role
                          FutureBuilder<String>(
                            future: homecontroller.prefs.getUserRole(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                String displayText =
                                    snapshot.data == "Agri Service Provider"
                                        ? "Partner"
                                        : snapshot.data ?? '';
                                return InkWell(
                                  onTap: () {
                                    HapticFeedback.heavyImpact();
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        displayText,
                                        style: const TextStyle(
                                            color: AppColor.DARK_GREEN,
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            decorationColor:
                                                AppColor.DARK_GREEN),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    // Fetch UserRole
                    FutureBuilder<String>(
                      future: homecontroller.prefs.getUserRole(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData && snapshot.data == "Farmer" ||
                              snapshot.data == "Land Owner") {
                            return Container(
                              color: Colors.black,
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return const CircularProgressIndicator(); // Return a loading indicator while fetching user role
                        }
                      },
                    ),

                    // Profile Completion
                    Obx(() {
                      return profilePercentageController.profileData.value
                                  .result?.completionPercentage ==
                              100
                          ? Container(
                              margin: const EdgeInsets.only(top: 20),
                            )
                          : ProfileCompletion(
                              getProfileController: getProfileController,
                              profilePercentageController:
                                  profilePercentageController,
                              homecontroller: homecontroller);
                    }),

                    // Add Land || Product
                    FutureBuilder<String>(
                      future: homecontroller.prefs.getUserRole(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data == "Land Owner") {
                            return AddLandWidget();
                          } else if (snapshot.data ==
                              StringConstatnt.AGRI_PROVIDER) {
                            return AddProductWidget(); // Return an empty container if user role is not "Land Owner"
                          } else {
                            return Container();
                          }
                        } else {
                          return const CircularProgressIndicator(); // Return a loading indicator while fetching user role
                        }
                      },
                    ),

                    // Body
                    LandOwnerBodyWidget(homecontroller: homecontroller),
                    PartnerBodyWidget(
                        homecontroller: homecontroller,
                        recoLandowner: recoLandowner),
                    FarmerBodyWidget(
                      homecontroller: homecontroller,
                      agriController: agriController,
                      dashboardController: dashboardController,
                      recommendedlandController: recommendedlandController,
                    ),

                    FutureBuilder<String>(
                      future: homecontroller.prefs.getUserRole(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData &&
                              snapshot.data == "Agri Service Provider") {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Farmers'.tr,
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF483C32),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Obx(() {
                                      return Row(
                                        children: [
                                          farmerController.farmer.value.result
                                                      ?.pageInfo?.totalObject !=
                                                  0
                                              ? GestureDetector(
                                                  onTap: () {
                                                    dashboardController
                                                        .selectedIndex
                                                        .value = 4;
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'View all'.tr,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: const Color(
                                                              0xFF044D3A),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        '(${farmerController.farmer.value.result?.pageInfo?.totalObject ?? 0})',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: const Color(
                                                              0xFF044D3A),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      );
                                    })
                                  ],
                                ),
                                Obx(() {
                                  return farmerController.farmer.value.result
                                              ?.data?.length !=
                                          0
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 20, top: 10),
                                          height: Get.height * 0.14,
                                          child: ListView.builder(
                                              itemCount: farmerController
                                                      .farmer
                                                      .value
                                                      .result
                                                      ?.data
                                                      ?.length ??
                                                  0,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: const EdgeInsets.only(
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
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(() => UserProfileScreen(
                                                              id: farmerController
                                                                      .farmer
                                                                      .value
                                                                      .result
                                                                      ?.data?[
                                                                          index]
                                                                      .userId!
                                                                      .toInt() ??
                                                                  0,
                                                              userType: farmerController
                                                                      .farmer
                                                                      .value
                                                                      .result
                                                                      ?.data?[
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
                                                                const BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(18),
                                                              topLeft: Radius
                                                                  .circular(18),
                                                            ),
                                                            image: farmerController
                                                                            .farmer
                                                                            .value
                                                                            .result
                                                                            ?.data?[
                                                                                index]
                                                                            .image !=
                                                                        null &&
                                                                    farmerController
                                                                            .farmer
                                                                            .value
                                                                            .result
                                                                            ?.data?[index]
                                                                            .image !=
                                                                        ""
                                                                ? DecorationImage(
                                                                    image:
                                                                        NetworkImage(
                                                                      farmerController
                                                                              .farmer
                                                                              .value
                                                                              .result
                                                                              ?.data?[index]
                                                                              .image! ??
                                                                          "",
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : null,
                                                          ),
                                                          child: farmerController
                                                                          .farmer
                                                                          .value
                                                                          .result
                                                                          ?.data?[
                                                                              index]
                                                                          .image ==
                                                                      null ||
                                                                  farmerController
                                                                          .farmer
                                                                          .value
                                                                          .result
                                                                          ?.data?[
                                                                              index]
                                                                          .image ==
                                                                      ""
                                                              ? Center(
                                                                  child: Text(
                                                                    farmerController
                                                                            .farmer
                                                                            .value
                                                                            .result
                                                                            ?.data?[index]
                                                                            .fullName![0] ??
                                                                        "",
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
                                                              : const SizedBox(), // Show nothing if image exists
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              farmerController
                                                                      .farmer
                                                                      .value
                                                                      .result
                                                                      ?.data?[
                                                                          index]
                                                                      .fullName ??
                                                                  "",
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
                                                            const SizedBox(
                                                              height: 5,
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
                                                                    '  ${farmerController.farmer.value.result?.data?[index].livesIn ?? ""}',
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
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                              width: Get.width *
                                                                  0.43,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      itemCount: farmerController
                                                                              .farmer
                                                                              .value
                                                                              .result
                                                                              ?.data?[
                                                                                  index]
                                                                              .expertise!
                                                                              .length ??
                                                                          0,
                                                                      itemBuilder:
                                                                          (context,
                                                                              indexes) {
                                                                        return Container(
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 5),
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 8),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(20),
                                                                              color: const Color(0x14167C0C)),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              farmerController.farmer.value.result?.data?[index].expertise![indexes].name ?? "",
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
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 80,
                                                                      bottom:
                                                                          11),
                                                              padding:
                                                                  const EdgeInsets
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
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Get.to(() =>
                                                                      ChatScreen(
                                                                        landId:
                                                                            0,
                                                                        enquiryId:
                                                                            farmerController.farmer.value.result?.data?[index].enquiryId?.toInt() ??
                                                                                0,
                                                                        userId:
                                                                            farmerController.farmer.value.result?.data?[index].userId?.toInt() ??
                                                                                0,
                                                                        userType:
                                                                            farmerController.farmer.value.result?.data?[index].userType ??
                                                                                "",
                                                                        userFrom:
                                                                            farmerController.farmer.value.result?.data?[index].livesIn ??
                                                                                "",
                                                                        userName:
                                                                            farmerController.farmer.value.result?.data?[index].fullName ??
                                                                                "",
                                                                        image: farmerController.farmer.value.result?.data?[index].image ??
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
                                                                    const Icon(
                                                                      Icons
                                                                          .call,
                                                                      color: AppColor
                                                                          .DARK_GREEN,
                                                                      size: 15,
                                                                    ),
                                                                    Text(
                                                                      'Contact'
                                                                          .tr,
                                                                      style:
                                                                          const TextStyle(
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
                                                );
                                              }))
                                      : Container(
                                          margin: const EdgeInsets.symmetric(
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
                                })
                              ],
                            );
                          } else {
                            return Container(); // Return an empty container if user role is not "Land Owner"
                          }
                        } else {
                          return const CircularProgressIndicator(); // Return a loading indicator while fetching user role
                        }
                      },
                    ),

                    FutureBuilder<String>(
                      future: homecontroller.prefs.getUserRole(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData && snapshot.data == "Farmer" ||
                              snapshot.data == "Land Owner") {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                                      Text(
                                        "Calculate Crop Earning Yield".tr,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          "Select crops(upto 3)".tr,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
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
                                                      0.7,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12,
                                                                vertical: 15),
                                                        margin: const EdgeInsets
                                                            .only(bottom: 0),
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: AppColor
                                                                    .DARK_GREEN,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          12),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12),
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
                                                              "Select Crops".tr,
                                                              style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                cropgridCalculator
                                                                    .selectedCropsId
                                                                    .clear();
                                                                cropgridCalculator
                                                                    .selectedCropsName
                                                                    .clear();
                                                                cropgridCalculator
                                                                    .selectedCropsImages
                                                                    .clear();
                                                                Get.back();
                                                              },
                                                              child:
                                                                  const CircleAvatar(
                                                                radius: 10,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
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
                                                      Obx(() =>
                                                          cropgridCalculator
                                                                  .selectedCropsId
                                                                  .isEmpty
                                                              ? Container()
                                                              : Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          10.0),
                                                                      child:
                                                                          Text(
                                                                        "Selected Crop List"
                                                                            .tr,
                                                                        style: GoogleFonts.poppins(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: const Color(0xFF333333)),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: const EdgeInsets.only(
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              20,
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.12,
                                                                      width: double
                                                                          .infinity,
                                                                      child: ListView
                                                                          .builder(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount:
                                                                            cropgridCalculator.selectedCropsId.length ??
                                                                                0,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return Container(
                                                                            margin:
                                                                                const EdgeInsets.only(right: 10),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Stack(
                                                                                  children: [
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        // print("ON TAP");
                                                                                        // cropgridCalculator.removeCrop(cropgridCalculator.selectedCropsName[index], cropgridCalculator.selectedCropsId[index], cropgridCalculator.selectedCropsImages[index]);
                                                                                      },
                                                                                      child: Container(
                                                                                        height: MediaQuery.of(context).size.height * 0.075,
                                                                                        width: MediaQuery.of(context).size.width * 0.25,
                                                                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                                                                        // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(cropgridCalculator.selectedCropsImages[index] ?? ""))),
                                                                                        child: const Center(
                                                                                          child: Row(
                                                                                            children: [],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Positioned(
                                                                                      right: 0,
                                                                                      top: 0,
                                                                                      child: CircleAvatar(
                                                                                        radius: 10,
                                                                                        backgroundColor: const Color(0xFFFF3B30),
                                                                                        child: GestureDetector(
                                                                                          onTap: () {
                                                                                            cropgridCalculator.removeCrop(cropgridCalculator.selectedCropsName[index], cropgridCalculator.selectedCropsId[index], cropgridCalculator.selectedCropsImages[index]);
                                                                                          },
                                                                                          child: const Icon(
                                                                                            Icons.close,
                                                                                            color: Colors.white,
                                                                                            size: 18,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(top: 5.0),
                                                                                  child: Text(
                                                                                    cropgridCalculator.selectedCropsName[index].toString() ?? "",
                                                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 10, color: AppColor.BROWN_TEXT),
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
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 15.0,
                                                                right: 15,
                                                                bottom: 20,
                                                                top: 10),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Select up to 3 crops you are interested in"
                                                                  .tr,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColor
                                                                    .BROWN_TEXT,
                                                              ),
                                                            ),
                                                            Obx(
                                                              () => Text(
                                                                "${cropgridCalculator.selectedCropsId.length}/3",
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColor
                                                                      .GREEN_SUBTEXT,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Obx(() => Expanded(
                                                            child: GridView
                                                                .builder(
                                                              gridDelegate:
                                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    3,
                                                                crossAxisSpacing:
                                                                    8.0,
                                                                mainAxisSpacing:
                                                                    8.0,
                                                                childAspectRatio:
                                                                    1.1,
                                                              ),
                                                              itemCount: cropgridCalculator
                                                                      .farmerCropData
                                                                      .value
                                                                      .result
                                                                      ?.where((crop) => !cropgridCalculator
                                                                          .selectedCropsId
                                                                          .contains(
                                                                              crop.id))
                                                                      .length ??
                                                                  0,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                final crop = cropgridCalculator
                                                                    .farmerCropData
                                                                    .value
                                                                    .result
                                                                    ?.where((crop) => !cropgridCalculator
                                                                        .selectedCropsId
                                                                        .contains(
                                                                            crop.id))
                                                                    .toList()[index];

                                                                if (crop ==
                                                                    null)
                                                                  return const SizedBox
                                                                      .shrink();

                                                                return Column(
                                                                  children: [
                                                                    Container(
                                                                      margin: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              cropgridCalculator.selectCrop(
                                                                                crop.name ?? "",
                                                                                crop.id!.toInt(),
                                                                                crop.image ?? "",
                                                                              );
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: MediaQuery.of(context).size.height * 0.075,
                                                                              width: MediaQuery.of(context).size.width * 0.25,
                                                                              // margin: EdgeInsets.symmetric(
                                                                              //     horizontal:
                                                                              //         5),
                                                                              // padding: EdgeInsets.symmetric(
                                                                              //     vertical:
                                                                              //         10,
                                                                              //     horizontal:
                                                                              //         5),
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(12),
                                                                                image: DecorationImage(image: NetworkImage(crop.image ?? ""), fit: BoxFit.cover),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 5.0),
                                                                            child:
                                                                                Text(
                                                                              crop.name ?? "",
                                                                              maxLines: 2,
                                                                              textAlign: TextAlign.center,
                                                                              style: GoogleFonts.poppins(
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 10,
                                                                                color: AppColor.BROWN_TEXT,
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
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            // controller.marketDataList(
                                                            //     stateController.state.value,
                                                            //     districtController.district.value,
                                                            //     marketController.market.value,
                                                            //     cropController.crop.value);
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        16,
                                                                    horizontal:
                                                                        25),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: AppColor
                                                                  .DARK_GREEN,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "Proceed".tr,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                          margin:
                                              const EdgeInsets.only(bottom: 15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColor.GREY_BORDER),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Select Crop".tr,
                                                ),
                                                const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: AppColor.BROWN_TEXT),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Obx(
                                          () =>
                                              cropgridCalculator
                                                      .selectedCropsId.isEmpty
                                                  ? Container()
                                                  : Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 5,
                                                              bottom: 10,
                                                              left: 10,
                                                              right: 10),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.12,
                                                      width: double.infinity,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            cropgridCalculator
                                                                    .selectedCropsId
                                                                    .length ??
                                                                0,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 10),
                                                            child: Column(
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    const Positioned(
                                                                      right: 0,
                                                                      top: 0,
                                                                      child:
                                                                          CircleAvatar(
                                                                        radius:
                                                                            10,
                                                                        backgroundColor:
                                                                            Color(0xFFFF3B30),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              18,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        print(
                                                                            "ON TAP");
                                                                        cropgridCalculator.removeCrop(
                                                                            cropgridCalculator.selectedCropsName[index],
                                                                            cropgridCalculator.selectedCropsId[index],
                                                                            cropgridCalculator.selectedCropsImages[index]);
                                                                      },
                                                                      child:
                                                                          DottedBorder(
                                                                        borderType:
                                                                            BorderType.RRect,
                                                                        color: const Color(
                                                                            0xFFD6D6D6),
                                                                        dashPattern: const [
                                                                          2,
                                                                          2
                                                                        ],
                                                                        radius: const Radius
                                                                            .circular(
                                                                            12),
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                8,
                                                                            horizontal:
                                                                                10),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.06,
                                                                          width:
                                                                              MediaQuery.of(context).size.height * 0.06,
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 5),
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 10,
                                                                              horizontal: 5),
                                                                          decoration:
                                                                              BoxDecoration(image: DecorationImage(image: NetworkImage(cropgridCalculator.selectedCropsImages[index] ?? ""))),
                                                                          child:
                                                                              const Center(
                                                                            child:
                                                                                Row(
                                                                              children: [],
                                                                            ),
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
                                                                          top:
                                                                              5.0),
                                                                  child: Text(
                                                                    cropgridCalculator
                                                                            .selectedCropsName[index]
                                                                            .toString() ??
                                                                        "",
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            10,
                                                                        color: AppColor
                                                                            .BROWN_TEXT),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 20, top: 10),
                                        height: 1,
                                        width: double.infinity,
                                        color: const Color(0xFFE3E3E3),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Land Size".tr,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Text(
                                                "(Area)",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Obx(() {
                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0367,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF044D3A)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                border: Border.all(
                                                    color: AppColor.DARK_GREEN),
                                              ),
                                              child: Row(
                                                children: [
                                                  DropdownButton<String>(
                                                    alignment: Alignment.center,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    padding: EdgeInsets.zero,
                                                    underline: Container(),
                                                    iconEnabledColor:
                                                        Colors.transparent,
                                                    value: cropController
                                                        .selectedValue.value,
                                                    items: cropController
                                                        .dropdownItems
                                                        .map((String item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: item,
                                                        child: Text(item),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      cropController
                                                          .updateSelectedValue(
                                                              newValue);
                                                    },
                                                  ),
                                                  const Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color:
                                                          AppColor.BROWN_TEXT),
                                                ],
                                              ),
                                            );
                                          })
                                        ],
                                      ),
                                      Obx(
                                        () => Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${cropController.sliderValue.value.toStringAsFixed(2).toString()}  ",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              cropController.selectedValue
                                                          .value ==
                                                      null
                                                  ? ""
                                                  : cropController
                                                      .selectedValue.value
                                                      .toString(),
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
                                        double minValue = cropController
                                                    .selectedValue.value ==
                                                "SQFT"
                                            ? 100.0
                                            : 1.0;
                                        double maxValue = cropController
                                                    .selectedValue.value ==
                                                "SQFT"
                                            ? 10000.0
                                            : 100.0;
                                        double step = cropController
                                                    .selectedValue.value ==
                                                "SQFT"
                                            ? 100.0
                                            : 0.5;

                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Slider(
                                              value: cropController
                                                  .sliderValue.value,
                                              min: minValue,
                                              max: maxValue,
                                              divisions: ((maxValue -
                                                          minValue) /
                                                      step)
                                                  .round(), // Calculate divisions
                                              label: cropController
                                                  .sliderValue.value
                                                  .toStringAsFixed(2),
                                              onChanged: (double newValue) {
                                                cropController
                                                    .updateSliderValue(
                                                        newValue);
                                              },
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${minValue.toStringAsFixed(2)} ${cropController.selectedValue.value ?? ""}",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color:
                                                        const Color(0xFF9299B5),
                                                  ),
                                                ),
                                                Text(
                                                  "${maxValue.toStringAsFixed(2)} ${cropController.selectedValue.value ?? ""}",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color:
                                                        const Color(0xFF9299B5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      }),
                                      const Divider(
                                        height: 30,
                                        color: Color(0xFFE3E3E3),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          cropController.cropdetailsData();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 20, left: 10, right: 10),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColor.DARK_GREEN,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Calculate".tr,
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
                              ],
                            );
                          } else {
                            return Obx(() {
                              if (controller.loading.value &&
                                  controller.productData.value.result?.data
                                          ?.length ==
                                      0) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (controller.rxRequestStatus.value ==
                                  Status.ERROR) {
                                return Text('Some Error Occured'.tr);
                              } else if (controller
                                      .productData.value.result?.data?.length ==
                                  0) {
                                return const Center();
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'My Products'.tr,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF483C32),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              ' (${controller.productData.value.result?.data?.length ?? 0})',
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF483C32),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller.productData.value
                                                .result?.data?.length ??
                                            0,
                                        itemBuilder: (context, products) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // Get.to(() => Particularproduct(
                                                    //     productId: controller
                                                    //             .productDataListNew[
                                                    //                 products]
                                                    //             .id ??
                                                    //         0));
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    width: double.infinity,
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                          0xFFFFFFF7),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      shadows: const [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x19000000),
                                                          blurRadius: 24,
                                                          offset: Offset(0, 2),
                                                          spreadRadius: 0,
                                                        )
                                                      ],
                                                    ),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 8,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        controller
                                                                    .productData
                                                                    .value
                                                                    .result
                                                                    ?.data?[
                                                                        products]
                                                                    .image
                                                                    ?.length !=
                                                                0
                                                            ? SizedBox(
                                                                height:
                                                                    Get.height *
                                                                        0.14,
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount:
                                                                            controller.productData.value.result?.data?[products].image?.length ??
                                                                                0,
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        itemBuilder:
                                                                            (context,
                                                                                img) {
                                                                          return Container(
                                                                            margin:
                                                                                const EdgeInsets.only(bottom: 10, right: 8),
                                                                            height:
                                                                                Get.height * 0.14,
                                                                            width:
                                                                                Get.width * 0.3,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.black,
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                image: DecorationImage(image: NetworkImage(controller.productData.value.result?.data?[products].image?[img].image ?? ""), fit: BoxFit.cover)),
                                                                          );
                                                                        }),
                                                              )
                                                            : Container(),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 0,
                                                                  horizontal:
                                                                      0),
                                                          child: Text(
                                                            controller
                                                                    .productData
                                                                    .value
                                                                    .result
                                                                    ?.data?[
                                                                        products]
                                                                    .name ??
                                                                "",
                                                            style:
                                                                const TextStyle(
                                                              color: AppColor
                                                                  .BROWN_TEXT,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 5,
                                                                  left: 0,
                                                                  right: 10,
                                                                  top: 5),
                                                          child: Text(
                                                            controller
                                                                    .productData
                                                                    .value
                                                                    .result
                                                                    ?.data?[
                                                                        products]
                                                                    .description ??
                                                                "",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: const Color(
                                                                  0xFF61646B),
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            '${controller.productData.value.result?.data?[products].currency ?? ""} ${controller.productData.value.result?.data?[products].unitPrice}/${controller.productData.value.result?.data?[products].unitValue} ${controller.productData.value.result?.data?[products].unit}',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: AppColor
                                                                  .DARK_GREEN,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                            ),
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
                                  ],
                                );
                              }
                            });
                          }
                        } else {
                          return const CircularProgressIndicator(); // Return a loading indicator while fetching user role
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    )

                    // Obx((){})
                  ],
                ),
              ),
            )));
  }
}





// import 'package:dotted_border/dotted_border.dart';
// import 'package:farm_easy/utils/Constants/color_constants.dart';
// import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
// import 'package:farm_easy/utils/Constants/image_constant.dart';
// import 'package:farm_easy/utils/Constants/string_constant.dart';
// import 'package:farm_easy/Screens/AllEnquiries/Controller/all_enquiries_controller.dart';
// import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
// import 'package:farm_easy/Screens/Auth/CompleteProfile/View/complete_profile.dart';
// import 'package:farm_easy/Screens/ChatGpt/View/chat_gpt_start_Screen.dart';
// import 'package:farm_easy/Screens/ChatSection/view/chat_ui.dart';
// import 'package:farm_easy/Screens/Dashboard/controller/dashboard_controller.dart';
// import 'package:farm_easy/Screens/FertilizerCalculator/Controller/fertilizer_controller.dart';
// import 'package:farm_easy/Screens/HomeScreen/Controller/agri_provider_controller.dart';
// import 'package:farm_easy/Screens/HomeScreen/Controller/crop_controller.dart';
// import 'package:farm_easy/Screens/HomeScreen/Controller/crop_fertilizer_controller.dart';
// import 'package:farm_easy/Screens/HomeScreen/Controller/crop_grid_calculator.dart';
// import 'package:farm_easy/Screens/HomeScreen/Controller/farmer_controller.dart';
// import 'package:farm_easy/Screens/HomeScreen/Controller/home_controller.dart';
// import 'package:farm_easy/Screens/HomeScreen/Controller/matching_farmer.dart';
// import 'package:farm_easy/Screens/HomeScreen/Controller/recomended_land_controller.dart';
// import 'package:farm_easy/Screens/HomeScreen/Controller/recommended_landowners.dart';
// import 'package:farm_easy/Screens/HomeScreen/ProfielSection/Controller/profile_complete_controller.dart';
// import 'package:farm_easy/Screens/LandSection/LandAdd/VIew/add_land.dart';
// import 'package:farm_easy/Screens/LandSection/LandDetails/View/land_details.dart';
// import 'package:farm_easy/Screens/LandSection/MyLands/View/home_screen_land.dart';
// import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/view/recomended_land_info.dart';
// import 'package:farm_easy/Screens/LandSection/Recommended%20Lands%20List/View/view.dart';
// import 'package:farm_easy/Screens/ProductAndServices/Controller/product_view_controller.dart';
// import 'package:farm_easy/Screens/ProductAndServices/View/add_product.dart';
// import 'package:farm_easy/Screens/RecommendedLandowners/view.dart';
// import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
// import 'package:farm_easy/Screens/WeatherScreen/Controller/current_weather_controller.dart';
// import 'package:farm_easy/Screens/notification_controller.dart';
// import 'package:farm_easy/API/Services/network/status.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:percent_indicator/percent_indicator.dart';

// import '../Widgets/homeScreen_android_appbar.dart';
// import '../Widgets/homeScreen_ios_appbar.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final homecontroller = Get.put(HomeController());
//   final dashboardController = Get.put(DashboardController());
//   final profilePercentageController = Get.put(ProfilePercentageController());
//   final currentWeather = Get.put(CurrentWeatherController());
//   final recommendedlandController = Get.put(RecommendedLandController());
//   final agriController = Get.put(ListAgriProviderController());
//   final farmerController = Get.put(ListFarmerController());
//   final recoLandowner = Get.put(RecommendedLandownersController());
//   final cropController = Get.put(CropController());
//   final cropgridCalculator = Get.put(CropGridCalculator());
//   final cropFertilizer = Get.put(CropFertilizerController());
//   final cropFertilizerCalculator = Get.put(FertilizerCalculatedController());

//   final enqcontroller = Get.put(AllEnquiriesController());
//   final getProfileController = Get.put(GetProfileController());
//   final controller = Get.put(ProductViewController());
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     PushNotifications.init();
//     PushNotifications.localNotiInit();
//     getProfileController.getProfile();
//     controller.productList(
//         userId: getProfileController.getProfileData.value.result?.userId ?? 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: AppColor.BACKGROUND,
//         appBar: PreferredSize(
//           preferredSize:
//               Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
//           child: isIOS ? HomeScreenIOS_AppBar() : HomeScreenANDROID_AppBar(),
//         ),
//         body: RefreshIndicator(
//             onRefresh: () async {
//               homecontroller.landListData();
//               profilePercentageController.profilePercentage();
//               currentWeather.currentWeather();
//               farmerController.farmerList();
//               enqcontroller.refreshAllEnquiries();
//               recommendedlandController.recommendedLandData(100);
//               controller.productList(
//                   userId: getProfileController
//                           .getProfileData.value.result?.userId ??
//                       0);
//             },
//             child: SingleChildScrollView(
//               physics: BouncingScrollPhysics(),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 15.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           FutureBuilder<String>(
//                             future: homecontroller.prefs.getUserName(),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return const CircularProgressIndicator();
//                               } else if (snapshot.hasError) {
//                                 return Text('Error: ${snapshot.error}');
//                               } else {
//                                 return Container(
//                                   margin: EdgeInsets.symmetric(vertical: 0),
//                                   child: Text(
//                                     'Hi, ${snapshot.data}',
//                                     style: TextStyle(
//                                       color: Color(0xFF483C32),
//                                       fontSize: 16,
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 );
//                               }
//                             },
//                           ),
//                           FutureBuilder<String>(
//                             future: homecontroller.prefs.getUserRole(),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return const CircularProgressIndicator();
//                               } else if (snapshot.hasError) {
//                                 return Text('Error: ${snapshot.error}');
//                               } else {
//                                 String displayText =
//                                     snapshot.data == "Agri Service Provider"
//                                         ? "Partner"
//                                         : snapshot.data ?? '';
//                                 return Container(
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         "${displayText}   ",
//                                         style: TextStyle(
//                                             color: AppColor.DARK_GREEN,
//                                             fontSize: 16,
//                                             fontFamily: 'Poppins',
//                                             fontWeight: FontWeight.bold,
//                                             decorationColor:
//                                                 AppColor.DARK_GREEN),
//                                       ),
//                                       // SvgPicture.asset(
//                                       //     "assets/logos/profileswitch.svg")
//                                     ],
//                                   ),
//                                 );
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Row(
//                     //   crossAxisAlignment: CrossAxisAlignment.start,
//                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //   children: [
//                     //     Container(
//                     //       height:
//                     //           MediaQuery.of(context).size.height * 0.20,
//                     //       width: MediaQuery.of(context).size.width * 0.45,
//                     //       decoration: BoxDecoration(
//                     //           gradient: AppColor.PRIMARY_GRADIENT,
//                     //           borderRadius: BorderRadius.circular(10)),
//                     //       child: currentWeather
//                     //                   .currentWeatherData.value.name ==
//                     //               "Globe"
//                     //           ? Center(
//                     //               child: Text(
//                     //                 "Please Refresh",
//                     //                 style: GoogleFonts.poppins(
//                     //                   color: Color(0xFF483C32),
//                     //                   fontSize: 14,
//                     //                   fontWeight: FontWeight.w600,
//                     //                 ),
//                     //               ),
//                     //             )
//                     //           : GestureDetector(
//                     //               onTap: () {
//                     //                 Get.to(() => WeatherScreen(
//                     //                       lat: currentWeather
//                     //                           .currentWeatherData
//                     //                           .value
//                     //                           .coord!
//                     //                           .lat!
//                     //                           .toDouble(),
//                     //                       long: currentWeather
//                     //                           .currentWeatherData
//                     //                           .value
//                     //                           .coord!
//                     //                           .lon!
//                     //                           .toDouble(),
//                     //                     ));
//                     //               },
//                     //               child: Column(
//                     //                 crossAxisAlignment:
//                     //                     CrossAxisAlignment.center,
//                     //                 mainAxisAlignment:
//                     //                     MainAxisAlignment.spaceBetween,
//                     //                 children: [
//                     //                   Text(
//                     //                     ' ${currentWeather.currentWeatherData.value.main?.feelsLike?.toInt() ?? 0}º',
//                     //                     style: GoogleFonts.poppins(
//                     //                       color: AppColor.BROWN_TEXT,
//                     //                       fontSize: 38,
//                     //                       fontWeight: FontWeight.w500,
//                     //                     ),
//                     //                   ),
//                     //                   Row(
//                     //                     crossAxisAlignment:
//                     //                         CrossAxisAlignment.center,
//                     //                     mainAxisAlignment:
//                     //                         MainAxisAlignment.center,
//                     //                     children: [
//                     //                       Container(
//                     //                         height: 35,
//                     //                         width: 35,
//                     //                         decoration: BoxDecoration(
//                     //                             image: DecorationImage(
//                     //                                 image: NetworkImage(
//                     //                                     "http://openweathermap.org/img/wn/${currentWeather.currentWeatherData.value.weather?[0].icon}.png"),
//                     //                                 fit: BoxFit.fill)),
//                     //                       ),
//                     //                       Text(
//                     //                         '${currentWeather.currentWeatherData.value.weather?[0].main}',
//                     //                         textAlign: TextAlign.center,
//                     //                         style: TextStyle(
//                     //                           color: Color(0xFF483C32),
//                     //                           fontSize: 14,
//                     //                           fontFamily: 'Poppins',
//                     //                           fontWeight: FontWeight.w500,
//                     //                           height: 0,
//                     //                         ),
//                     //                       ),
//                     //                     ],
//                     //                   ),
//                     //                   Text(
//                     //                     'Min: ${currentWeather.currentWeatherData.value.main?.tempMin?.toInt().toInt()}º / Max: ${currentWeather.currentWeatherData.value.main?.tempMax?.toInt()}º',
//                     //                     textAlign: TextAlign.center,
//                     //                     style: GoogleFonts.poppins(
//                     //                       color: Color(0xCC61646B),
//                     //                       fontSize: 10,
//                     //                       fontWeight: FontWeight.w500,
//                     //                     ),
//                     //                   ),
//                     //                   Container(
//                     //                     width: Get.width * 0.5,
//                     //                     child: Center(
//                     //                         child: Text(
//                     //                       "----------------------",
//                     //                       style: TextStyle(
//                     //                           color: Colors.grey),
//                     //                     )),
//                     //                   ),
//                     //                   Text(
//                     //                     '${currentWeather.currentWeatherData.value.name ?? ""}',
//                     //                     style: GoogleFonts.poppins(
//                     //                       color: Color(0xFF483C32),
//                     //                       fontSize: 14,
//                     //                       fontWeight: FontWeight.w600,
//                     //                     ),
//                     //                   ),
//                     //                   SizedBox(
//                     //                     height: 5,
//                     //                   ),
//                     //                 ],
//                     //               ),
//                     //             ),
//                     //     ),
//                     //     GestureDetector(
//                     //       onTap: () {
//                     //         Get.to(() => ChatGptStartScreen());
//                     //       },
//                     //       child: Container(
//                     //         height:
//                     //             MediaQuery.of(context).size.height * 0.20,
//                     //         width:
//                     //             MediaQuery.of(context).size.width * 0.45,
//                     //         decoration: BoxDecoration(
//                     //             gradient: AppColor.BLUE_GREEN_GRADIENT,
//                     //             borderRadius: BorderRadius.circular(10)),
//                     //         child: Column(
//                     //           crossAxisAlignment:
//                     //               CrossAxisAlignment.center,
//                     //           mainAxisAlignment:
//                     //               MainAxisAlignment.spaceEvenly,
//                     //           children: [
//                     //             SvgPicture.asset(
//                     //               ImageConstants.CHATGPT,
//                     //               height: 55,
//                     //               width: 50,
//                     //             ),
//                     //             Container(
//                     //               margin:
//                     //                   EdgeInsets.symmetric(vertical: 5),
//                     //               child: Text(
//                     //                 'AI Agri-assistant',
//                     //                 textAlign: TextAlign.center,
//                     //                 style: GoogleFonts.poppins(
//                     //                   color: AppColor.BROWN_TEXT,
//                     //                   fontSize: 12,
//                     //                   fontWeight: FontWeight.w600,
//                     //                   height: 0,
//                     //                 ),
//                     //               ),
//                     //             ),
//                     //             Container(
//                     //               width: Get.width * 0.35,
//                     //               child: Text(
//                     //                 'Get a answer for all your agri related queries instantly.',
//                     //                 textAlign: TextAlign.center,
//                     //                 style: TextStyle(
//                     //                   color: Color(0xCC61646B),
//                     //                   fontSize: 10,
//                     //                   fontFamily: 'Poppins',
//                     //                   fontWeight: FontWeight.w600,
//                     //                   height: 0,
//                     //                 ),
//                     //               ),
//                     //             ),
//                     //             SizedBox(
//                     //               height: 10,
//                     //             )
//                     //           ],
//                     //         ),
//                     //       ),
//                     //     )
//                     //   ],
//                     // ),
//                     Obx(() {
//                       return profilePercentageController.profileData.value
//                                   .result?.completionPercentage ==
//                               100
//                           ? Container(
//                               margin: EdgeInsets.only(top: 20),
//                             )
//                           : Center(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   print(getProfileController
//                                       .getProfileData.value.result?.userId);
//                                   // Get.to(() => CompleteProfile());
//                                 },
//                                 child: Container(
//                                   margin: EdgeInsets.symmetric(vertical: 20),
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 10),
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                       color: Color(0xFFFFFFF7),
//                                       border: Border.all(
//                                           color: AppColor.BROWN_SUBTEXT),
//                                       borderRadius: BorderRadius.circular(30)),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Center(
//                                         child: CircularPercentIndicator(
//                                           radius: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.1,
//                                           lineWidth: 8.0,
//                                           percent: (profilePercentageController
//                                                       .profileData
//                                                       .value
//                                                       .result
//                                                       ?.completionPercentage
//                                                       ?.toDouble() ??
//                                                   0.0) /
//                                               100,
//                                           startAngle: 0.0,
//                                           linearGradient: LinearGradient(
//                                             begin: Alignment.topRight,
//                                             end: Alignment.bottomLeft,
//                                             colors: [
//                                               Color(0xfff1f881f)
//                                                   .withOpacity(0.8),
//                                               Color(0xfffFFE546)
//                                                   .withOpacity(0.4),
//                                             ],
//                                           ),
//                                           center: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text(
//                                                 "${profilePercentageController.profileData.value.result?.completionPercentage ?? "60"}%",
//                                                 style: GoogleFonts.poppins(
//                                                   color: AppColor.DARK_GREEN,
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.w600,
//                                                   height: 0,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "completed",
//                                                 style: GoogleFonts.poppins(
//                                                   color: AppColor.GREEN_SUBTEXT,
//                                                   fontSize: 8,
//                                                   fontWeight: FontWeight.w500,
//                                                   height: 0,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 12,
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             Container(
//                                               margin: EdgeInsets.only(top: 10),
//                                               child: Text(
//                                                 'Provide more information',
//                                                 style: GoogleFonts.poppins(
//                                                   color: AppColor.BROWN_TEXT,
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                               width: Get.width * 0.53,
//                                               child: Text(
//                                                 'Complete your profile to receive better recommendations.',
//                                                 style: GoogleFonts.poppins(
//                                                   color: Color(0xFF61646B),
//                                                   fontSize: 10,
//                                                   fontWeight: FontWeight.w500,
//                                                   height: 0,
//                                                 ),
//                                               ),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                   margin:
//                                                       EdgeInsets.only(left: 40),
//                                                   child: TextButton(
//                                                     onPressed: () {
//                                                       Get.to(() =>
//                                                           CompleteProfile());
//                                                     },
//                                                     child: Text(
//                                                       'Complete Profile',
//                                                       style:
//                                                           GoogleFonts.poppins(
//                                                         color:
//                                                             AppColor.DARK_GREEN,
//                                                         fontSize: 14,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                         height: 0,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () async {
//                                                     Get.to(() =>
//                                                         CompleteProfile());
//                                                     print(
//                                                         "=======================================${await homecontroller.prefs.getUserRole()}");
//                                                   },
//                                                   child: Icon(
//                                                     Icons
//                                                         .arrow_forward_ios_rounded,
//                                                     color: AppColor.DARK_GREEN,
//                                                   ),
//                                                 )
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                     }),
//                     FutureBuilder<String>(
//                       future: homecontroller.prefs.getUserRole(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           if (snapshot.data == "Land Owner") {
//                             return GestureDetector(
//                               onTap: () {
//                                 Get.to(() => AddLand());
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(bottom: 10),
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 10, horizontal: 10),
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   gradient: AppColor.YELLOW_GRADIENT,
//                                   border: Border.all(
//                                       color: AppColor.BROWN_SUBTEXT,
//                                       width: 0.2),
//                                 ),
//                                 child: Center(
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         margin:
//                                             EdgeInsets.only(right: 20, left: 5),
//                                         child: DottedBorder(
//                                           color: Colors.grey,
//                                           borderType: BorderType.RRect,
//                                           dashPattern: [4, 4],
//                                           radius: Radius.circular(12),
//                                           child: Container(
//                                             clipBehavior: Clip.antiAlias,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                             ),
//                                             child: Center(
//                                               child: IconButton(
//                                                 onPressed: () {
//                                                   Get.to(() => AddLand());
//                                                 },
//                                                 icon: Icon(
//                                                   Icons.add_rounded,
//                                                   color: AppColor.BROWN_TEXT,
//                                                   size: 35,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Add New Land',
//                                             style: GoogleFonts.poppins(
//                                               color: AppColor.BROWN_TEXT,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600,
//                                               height: 0,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 220,
//                                             child: Text(
//                                               'To find relevant farmers, Agri-Service providers and get crop suggestions.',
//                                               style: GoogleFonts.poppins(
//                                                 color: Color(0xFF666666),
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w400,
//                                                 height: 0,
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           } else if (snapshot.data ==
//                               StringConstatnt.AGRI_PROVIDER) {
//                             return GestureDetector(
//                               onTap: () {
//                                 Get.to(() => AddProduct());
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(bottom: 10),
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 10, horizontal: 10),
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   gradient: AppColor.YELLOW_GRADIENT,
//                                   border: Border.all(
//                                       color: AppColor.BROWN_SUBTEXT,
//                                       width: 0.2),
//                                 ),
//                                 child: Center(
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         margin:
//                                             EdgeInsets.only(right: 20, left: 5),
//                                         child: DottedBorder(
//                                           color: Colors.grey,
//                                           borderType: BorderType.RRect,
//                                           dashPattern: [4, 4],
//                                           radius: Radius.circular(12),
//                                           child: Container(
//                                             clipBehavior: Clip.antiAlias,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                             ),
//                                             child: Center(
//                                               child: IconButton(
//                                                 onPressed: () {
//                                                   Get.to(() => AddProduct());
//                                                 },
//                                                 icon: Icon(
//                                                   Icons.add_rounded,
//                                                   color: AppColor.BROWN_TEXT,
//                                                   size: 35,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Add New Product',
//                                             style: GoogleFonts.poppins(
//                                               color: AppColor.BROWN_TEXT,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600,
//                                               height: 0,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 220,
//                                             child: Text(
//                                               'To find relevant product and services',
//                                               style: GoogleFonts.poppins(
//                                                 color: Color(0xFF666666),
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w400,
//                                                 height: 0,
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ); // Return an empty container if user role is not "Land Owner"
//                           } else {
//                             return Container();
//                           }
//                         } else {
//                           return CircularProgressIndicator(); // Return a loading indicator while fetching user role
//                         }
//                       },
//                     ),
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //   children: [
//                     //     Text(
//                     //       'Market Prices',
//                     //       style: GoogleFonts.poppins(
//                     //         color: Color(0xFF483C32),
//                     //         fontSize: 14,
//                     //         fontWeight: FontWeight.w500,
//                     //       ),
//                     //     ),
//                     //     GestureDetector(
//                     //       onTap: () async {
//                     //         print(
//                     //             "=====================${ homecontroller.prefs
//                     //                 .getUserRole()}");
//                     //       },
//                     //       child: Text(
//                     //         'View all (66) >',
//                     //         style: GoogleFonts.poppins(
//                     //           color: Color(0xFF044D3A),
//                     //           fontSize: 12,
//                     //           fontWeight: FontWeight.w500,
//                     //         ),
//                     //       ),
//                     //     )
//                     //   ],
//                     // ),
//                     // Container(
//                     //   height: AppDimension.h * 0.21,
//                     //   child: ListView.builder(
//                     //       itemCount: 6,
//                     //       scrollDirection: Axis.horizontal,
//                     //       itemBuilder: (context, index) {
//                     //         return Container(
//                     //           margin: EdgeInsets.only(
//                     //               top: 10, bottom: 10, right: 15),
//                     //           width: AppDimension.w * 0.7,
//                     //           decoration: ShapeDecoration(
//                     //             color: Color(0xFFFFFFF7),
//                     //             shape: RoundedRectangleBorder(
//                     //               borderRadius: BorderRadius.circular(10),
//                     //             ),
//                     //             shadows: [
//                     //               BoxShadow(
//                     //                 color: Color(0x19000000),
//                     //                 blurRadius: 24,
//                     //                 offset: Offset(0, 2),
//                     //                 spreadRadius: 0,
//                     //               )
//                     //             ],
//                     //           ),
//                     //           child: Column(
//                     //             crossAxisAlignment: CrossAxisAlignment.start,
//                     //             mainAxisAlignment: MainAxisAlignment
//                     //                 .spaceEvenly,
//                     //             children: [
//                     //               Padding(
//                     //                 padding: const EdgeInsets.only(
//                     //                     left: 15,
//                     //                     right: 15,
//                     //                     top: 10,
//                     //                     bottom: 10),
//                     //                 child: Row(
//                     //                   children: [
//                     //                     Container(
//                     //                       margin: EdgeInsets.only(right: 15),
//                     //                       height: 45,
//                     //                       width: 45,
//                     //                       decoration: BoxDecoration(
//                     //                           image: DecorationImage(
//                     //                               fit: BoxFit.cover,
//                     //                               image: AssetImage(
//                     //                                   ImageConstants
//                     //                                       .TOMATO_PNG))),
//                     //                     ),
//                     //                     Column(
//                     //                       crossAxisAlignment:
//                     //                       CrossAxisAlignment.start,
//                     //                       children: [
//                     //                         Text(
//                     //                           'Tomato',
//                     //                           style: GoogleFonts.poppins(
//                     //                             color: AppColor.BROWN_TEXT,
//                     //                             fontSize: 14,
//                     //                             fontWeight: FontWeight.w500,
//                     //                           ),
//                     //                         ),
//                     //                         Text(
//                     //                           'Durg, Chhatisgarh (IN)',
//                     //                           style: TextStyle(
//                     //                             color: Color(0xCC828282),
//                     //                             fontSize: 12,
//                     //                             fontFamily: 'Poppins',
//                     //                             fontWeight: FontWeight.w400,
//                     //                           ),
//                     //                         )
//                     //                       ],
//                     //                     )
//                     //                   ],
//                     //                 ),
//                     //               ),
//                     //               Padding(
//                     //                 padding: const EdgeInsets.only(
//                     //                   left: 15,
//                     //                   right: 15,
//                     //                 ),
//                     //                 child: Column(
//                     //                   crossAxisAlignment: CrossAxisAlignment
//                     //                       .start,
//                     //                   children: [
//                     //                     Text(
//                     //                       '₹2200/Quintal',
//                     //                       style: GoogleFonts.poppins(
//                     //                         color: AppColor.LIGHT_GREEN,
//                     //                         fontSize: 18,
//                     //                         fontWeight: FontWeight.w600,
//                     //                         height: 0,
//                     //                       ),
//                     //                     ),
//                     //                     Text(
//                     //                       'Rate on 28/Nov/2023',
//                     //                       style: GoogleFonts.poppins(
//                     //                         color: Color(0xCC828282),
//                     //                         fontSize: 12,
//                     //                         fontWeight: FontWeight.w400,
//                     //                       ),
//                     //                     )
//                     //                   ],
//                     //                 ),
//                     //               )
//                     //             ],
//                     //           ),
//                     //         );
//                     //       }),
//                     // ),
//                     FutureBuilder<String>(
//                       future: homecontroller.prefs.getUserRole(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           if (snapshot.hasData &&
//                               snapshot.data == "Land Owner") {
//                             return Obx(() {
//                               return homecontroller.landData.value.result
//                                           ?.pageInfo?.totalObject !=
//                                       0
//                                   ? Column(
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               'My Lands',
//                                               style: GoogleFonts.poppins(
//                                                 color: Color(0xFF483C32),
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 Get.to(() => HomeScreenLand());
//                                                 // dashboardController.selectedIndex.value = 3;
//                                               },
//                                               child: Text(
//                                                 'View all (${homecontroller.landData.value.result?.pageInfo?.totalObject?.toInt() ?? "No land added"}) >',
//                                                 style: GoogleFonts.poppins(
//                                                   color: Color(0xFF044D3A),
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.w500,
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                         Obx(() {
//                                           return homecontroller.loading.value
//                                               ? Center(
//                                                   child:
//                                                       CircularProgressIndicator())
//                                               : ListView.builder(
//                                                   shrinkWrap: true,
//                                                   physics:
//                                                       NeverScrollableScrollPhysics(),
//                                                   itemCount: homecontroller
//                                                           .landData
//                                                           .value
//                                                           .result
//                                                           ?.data
//                                                           ?.length ??
//                                                       0,
//                                                   itemBuilder:
//                                                       (context, index) {
//                                                     int landId = homecontroller
//                                                         .landData
//                                                         .value
//                                                         .result!
//                                                         .data![index]
//                                                         .id!
//                                                         .toInt();
//                                                     final matchingfarmerController =
//                                                         Get.put(
//                                                             HomeScreenMatchingFarmerController(
//                                                                 landId),
//                                                             tag: landId
//                                                                 .toString());

//                                                     return GestureDetector(
//                                                       onTap: () {
//                                                         Get.to(() => LandDetails(
//                                                             id: homecontroller
//                                                                 .landData
//                                                                 .value
//                                                                 .result!
//                                                                 .data![index]
//                                                                 .id!
//                                                                 .toInt()));
//                                                       },
//                                                       child: Container(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 vertical: 20),
//                                                         margin: EdgeInsets
//                                                             .symmetric(
//                                                                 vertical: 10),
//                                                         width: double.infinity,
//                                                         decoration:
//                                                             ShapeDecoration(
//                                                           color:
//                                                               Color(0xFFFFFFF7),
//                                                           shape:
//                                                               RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10),
//                                                           ),
//                                                           shadows: [
//                                                             BoxShadow(
//                                                               color: Color(
//                                                                   0x19000000),
//                                                               blurRadius: 24,
//                                                               offset:
//                                                                   Offset(0, 2),
//                                                               spreadRadius: 0,
//                                                             )
//                                                           ],
//                                                         ),
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .symmetric(
//                                                                       horizontal:
//                                                                           15),
//                                                               child: Row(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .center,
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .spaceBetween,
//                                                                 children: [
//                                                                   Column(
//                                                                     crossAxisAlignment:
//                                                                         CrossAxisAlignment
//                                                                             .start,
//                                                                     children: [
//                                                                       Text(
//                                                                         homecontroller.landData.value.result?.data?[index].landTitle ??
//                                                                             "",
//                                                                         style: GoogleFonts.poppins(
//                                                                             fontWeight:
//                                                                                 FontWeight.w600,
//                                                                             color: AppColor.BROWN_TEXT,
//                                                                             fontSize: 14),
//                                                                       ),
//                                                                       Container(
//                                                                         width: MediaQuery.of(context).size.width *
//                                                                             0.35,
//                                                                         child:
//                                                                             Text(
//                                                                           overflow:
//                                                                               TextOverflow.ellipsis,
//                                                                           maxLines:
//                                                                               1,
//                                                                           "${homecontroller.landData.value.result?.data?[index].city ?? ""} ${homecontroller.landData.value.result?.data?[index].state ?? ""} ${homecontroller.landData.value.result?.data?[index].country ?? ""}",
//                                                                           style: GoogleFonts.poppins(
//                                                                               fontSize: 10,
//                                                                               fontWeight: FontWeight.w500,
//                                                                               color: Color(0xFF61646B)),
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                   Column(
//                                                                     crossAxisAlignment:
//                                                                         CrossAxisAlignment
//                                                                             .start,
//                                                                     children: [
//                                                                       Row(
//                                                                         crossAxisAlignment:
//                                                                             CrossAxisAlignment.start,
//                                                                         children: [
//                                                                           Text(
//                                                                             "${homecontroller.landData.value.result?.data?[index].weatherDetails?.temperature?.toInt() ?? ""}º",
//                                                                             style: GoogleFonts.poppins(
//                                                                                 fontWeight: FontWeight.w500,
//                                                                                 color: AppColor.BROWN_TEXT,
//                                                                                 fontSize: 15),
//                                                                           ),
//                                                                           Container(
//                                                                             height:
//                                                                                 20,
//                                                                             width:
//                                                                                 20,
//                                                                             decoration:
//                                                                                 BoxDecoration(image: DecorationImage(image: NetworkImage("http://openweathermap.org/img/wn/${homecontroller.landData.value.result?.data?[index].weatherDetails?.imgIcon}.png"), fit: BoxFit.fill)),
//                                                                           ),
//                                                                           Container(
//                                                                             width:
//                                                                                 MediaQuery.of(context).size.width * 0.25,
//                                                                             child:
//                                                                                 Text(
//                                                                               overflow: TextOverflow.ellipsis,
//                                                                               homecontroller.landData.value.result?.data?[index].weatherDetails?.description ?? "",
//                                                                               style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: AppColor.BROWN_TEXT, fontSize: 15),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                       Text(
//                                                                         "Min: ${homecontroller.landData.value.result?.data?[index].weatherDetails?.minTemp?.toInt() ?? ""}º / Max: ${homecontroller.landData.value.result?.data?[index].weatherDetails?.maxTemp?.toInt() ?? ""}º",
//                                                                         style: GoogleFonts.poppins(
//                                                                             fontWeight:
//                                                                                 FontWeight.w500,
//                                                                             color: Color(0xFF61646B),
//                                                                             fontSize: 10),
//                                                                       )
//                                                                     ],
//                                                                   )
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                             Row(
//                                                               children:
//                                                                   List.generate(
//                                                                       450 ~/ 4,
//                                                                       (index) =>
//                                                                           Expanded(
//                                                                             child:
//                                                                                 Container(
//                                                                               margin: EdgeInsets.symmetric(vertical: 12),
//                                                                               color: index % 2 == 0 ? Colors.transparent : AppColor.GREY_BORDER,
//                                                                               height: 1,
//                                                                             ),
//                                                                           )),
//                                                             ),
//                                                             Container(
//                                                                 margin: EdgeInsets
//                                                                     .symmetric(
//                                                                         horizontal:
//                                                                             15),
//                                                                 child: Container(
//                                                                     child: Column(
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .start,
//                                                                   children: [
//                                                                     Text(
//                                                                       "Matching farmers for this land",
//                                                                       style: GoogleFonts.poppins(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight: FontWeight
//                                                                               .w500,
//                                                                           color:
//                                                                               AppColor.BROWN_TEXT),
//                                                                     ),
//                                                                     Obx(() => matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?.length !=
//                                                                             0
//                                                                         ? Container(
//                                                                             margin:
//                                                                                 EdgeInsets.symmetric(
//                                                                               vertical: 20,
//                                                                             ),
//                                                                             height:
//                                                                                 Get.height * 0.14,
//                                                                             child: ListView.builder(
//                                                                                 itemCount: matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?.length ?? 0,
//                                                                                 scrollDirection: Axis.horizontal,
//                                                                                 itemBuilder: (context, index) {
//                                                                                   return GestureDetector(
//                                                                                     onTap: () {
//                                                                                       Get.to(() => UserProfileScreen(id: matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].userId!.toInt() ?? 0, userType: matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].userType ?? ""));
//                                                                                     },
//                                                                                     child: Container(
//                                                                                       margin: EdgeInsets.only(right: 20),
//                                                                                       width: Get.width * 0.8,
//                                                                                       decoration: BoxDecoration(
//                                                                                         color: Colors.white,
//                                                                                         border: Border.all(color: AppColor.GREY_BORDER),
//                                                                                         boxShadow: [
//                                                                                           AppColor.BOX_SHADOW
//                                                                                         ],
//                                                                                         borderRadius: BorderRadius.circular(18),
//                                                                                       ),
//                                                                                       child: Row(
//                                                                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                         children: [
//                                                                                           GestureDetector(
//                                                                                             onTap: () {
//                                                                                               Get.to(() => UserProfileScreen(id: matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].userId!.toInt() ?? 0, userType: matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].userType ?? ""));
//                                                                                             },
//                                                                                             child: Container(
//                                                                                               width: Get.width * 0.25,
//                                                                                               height: Get.height * 0.16,
//                                                                                               decoration: BoxDecoration(
//                                                                                                 color: AppColor.DARK_GREEN.withOpacity(0.1),
//                                                                                                 borderRadius: BorderRadius.only(
//                                                                                                   bottomLeft: Radius.circular(18),
//                                                                                                   topLeft: Radius.circular(18),
//                                                                                                 ),
//                                                                                                 image: matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].image != null && matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].image != ""
//                                                                                                     ? DecorationImage(
//                                                                                                         image: NetworkImage(
//                                                                                                           matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].image! ?? "",
//                                                                                                         ),
//                                                                                                         fit: BoxFit.cover,
//                                                                                                       )
//                                                                                                     : null, // Only apply image if it exists
//                                                                                               ),
//                                                                                               child: matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].image == null || matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].image == ""
//                                                                                                   ? Center(
//                                                                                                       child: Text(
//                                                                                                         matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].fullName![0].toUpperCase() ?? "",
//                                                                                                         style: GoogleFonts.poppins(
//                                                                                                           fontSize: 50,
//                                                                                                           color: AppColor.DARK_GREEN, // Text color contrasting the background
//                                                                                                           fontWeight: FontWeight.w500,
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     )
//                                                                                                   : SizedBox(), // Show nothing if image exists
//                                                                                             ),
//                                                                                           ),
//                                                                                           Padding(
//                                                                                             padding: EdgeInsets.only(left: 10),
//                                                                                             child: Column(
//                                                                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                                                               children: [
//                                                                                                 Text(
//                                                                                                   '${matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].fullName ?? ""}',
//                                                                                                   style: GoogleFonts.poppins(
//                                                                                                     color: AppColor.BROWN_TEXT,
//                                                                                                     fontSize: 13,
//                                                                                                     fontWeight: FontWeight.w500,
//                                                                                                   ),
//                                                                                                 ),
//                                                                                                 Row(
//                                                                                                   children: [
//                                                                                                     SvgPicture.asset(
//                                                                                                       "assets/farm/locationbrown.svg",
//                                                                                                       width: 14,
//                                                                                                     ),
//                                                                                                     Container(
//                                                                                                       width: Get.width * 0.44,
//                                                                                                       child: Text(
//                                                                                                         '  ${matchingfarmerController.matchingFarmerData.value.result?.matchingFarmerList?[index].livesIn ?? ""}',
//                                                                                                         overflow: TextOverflow.ellipsis,
//                                                                                                         style: GoogleFonts.poppins(
//                                                                                                           color: Color(0xFF61646B),
//                                                                                                           fontSize: 8,
//                                                                                                           fontWeight: FontWeight.w500,
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     )
//                                                                                                   ],
//                                                                                                 ),
//                                                                                                 Row(
//                                                                                                   children: [
//                                                                                                     SvgPicture.asset(
//                                                                                                       "assets/farm/brownPort.svg",
//                                                                                                       width: 14,
//                                                                                                     ),
//                                                                                                     Container(
//                                                                                                       margin: EdgeInsets.only(left: 5),
//                                                                                                       height: 20,
//                                                                                                       width: Get.width * 0.4,
//                                                                                                       child: ListView.builder(
//                                                                                                           scrollDirection: Axis.horizontal,
//                                                                                                           itemCount: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].expertise!.length ?? 0,
//                                                                                                           itemBuilder: (context, experties) {
//                                                                                                             return Container(
//                                                                                                               margin: const EdgeInsets.symmetric(horizontal: 5),
//                                                                                                               padding: EdgeInsets.symmetric(horizontal: 8),
//                                                                                                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0x14167C0C)),
//                                                                                                               child: Center(
//                                                                                                                 child: Text(
//                                                                                                                   '${matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].expertise![experties].name ?? ""}',
//                                                                                                                   style: GoogleFonts.poppins(
//                                                                                                                     color: AppColor.DARK_GREEN,
//                                                                                                                     fontSize: 8,
//                                                                                                                     fontWeight: FontWeight.w500,
//                                                                                                                   ),
//                                                                                                                 ),
//                                                                                                               ),
//                                                                                                             );
//                                                                                                           }),
//                                                                                                     ),
//                                                                                                   ],
//                                                                                                 ),
//                                                                                                 GestureDetector(
//                                                                                                   onTap: () {
//                                                                                                     Get.to(() => ChatScreen(
//                                                                                                           landId: homecontroller.landData.value.result!.data![index].id!.toInt(),
//                                                                                                           enquiryId: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].enquiryId?.toInt() ?? 0,
//                                                                                                           userId: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].userId?.toInt() ?? 0,
//                                                                                                           userType: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].userType ?? "",
//                                                                                                           userFrom: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].livesIn ?? "",
//                                                                                                           userName: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].fullName ?? "",
//                                                                                                           image: matchingfarmerController.matchingFarmerData.value.result!.matchingFarmerList?[index].image ?? "",
//                                                                                                           isEnquiryCreatedByMe: false,
//                                                                                                           isEnquiryDisplay: false,
//                                                                                                           enquiryData: "",
//                                                                                                         ));
//                                                                                                   },
//                                                                                                   child: Container(
//                                                                                                     margin: EdgeInsets.only(
//                                                                                                       left: 60,
//                                                                                                     ),
//                                                                                                     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
//                                                                                                     decoration: BoxDecoration(
//                                                                                                       borderRadius: BorderRadius.circular(20),
//                                                                                                       border: Border.all(color: AppColor.DARK_GREEN, width: 1),
//                                                                                                     ),
//                                                                                                     child: Row(
//                                                                                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                                                                                       mainAxisAlignment: MainAxisAlignment.center,
//                                                                                                       children: [
//                                                                                                         Icon(
//                                                                                                           Icons.call,
//                                                                                                           color: AppColor.DARK_GREEN,
//                                                                                                           size: 15,
//                                                                                                         ),
//                                                                                                         Text(
//                                                                                                           '  Contact Farmer',
//                                                                                                           style: TextStyle(
//                                                                                                             color: Color(0xFF044D3A),
//                                                                                                             fontSize: 9,
//                                                                                                             fontFamily: 'Poppins',
//                                                                                                             fontWeight: FontWeight.w500,
//                                                                                                             height: 0.16,
//                                                                                                           ),
//                                                                                                         )
//                                                                                                       ],
//                                                                                                     ),
//                                                                                                   ),
//                                                                                                 )
//                                                                                               ],
//                                                                                             ),
//                                                                                           ),
//                                                                                         ],
//                                                                                       ),
//                                                                                     ),
//                                                                                   );
//                                                                                 }),
//                                                                           )
//                                                                         : Container(
//                                                                             margin:
//                                                                                 EdgeInsets.symmetric(vertical: 10),
//                                                                             child:
//                                                                                 Column(
//                                                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                                                               children: [
//                                                                                 Container(
//                                                                                   child: Lottie.asset("assets/lotties/animation.json", height: 100, width: double.infinity),
//                                                                                 )
//                                                                               ],
//                                                                             ),
//                                                                           ))
//                                                                   ],
//                                                                 ))),
//                                                             Divider(),
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .spaceAround,
//                                                               children: [
//                                                                 Row(
//                                                                   children: [
//                                                                     SvgPicture
//                                                                         .asset(
//                                                                       ImageConstants
//                                                                           .ENQUIRIES,
//                                                                       height:
//                                                                           30,
//                                                                     ),
//                                                                     Text(
//                                                                       '  Enquiries',
//                                                                       style: GoogleFonts
//                                                                           .poppins(
//                                                                         color: AppColor
//                                                                             .DARK_GREEN,
//                                                                         fontSize:
//                                                                             12,
//                                                                         fontWeight:
//                                                                             FontWeight.w500,
//                                                                         height:
//                                                                             0.15,
//                                                                       ),
//                                                                     )
//                                                                   ],
//                                                                 ),
//                                                                 Row(
//                                                                   children: [
//                                                                     Text(
//                                                                       'Partners  ',
//                                                                       style: GoogleFonts
//                                                                           .poppins(
//                                                                         color: AppColor
//                                                                             .DARK_GREEN,
//                                                                         fontSize:
//                                                                             12,
//                                                                         fontWeight:
//                                                                             FontWeight.w500,
//                                                                         height:
//                                                                             0.15,
//                                                                       ),
//                                                                     ),
//                                                                     CircleAvatar(
//                                                                       radius:
//                                                                           16,
//                                                                       backgroundColor:
//                                                                           AppColor
//                                                                               .DARK_GREEN,
//                                                                       child:
//                                                                           Center(
//                                                                         child:
//                                                                             Text(
//                                                                           '${homecontroller.landData.value.result?.data?[index].totalAgriServiceProvider ?? "0"}',
//                                                                           style:
//                                                                               GoogleFonts.poppins(
//                                                                             color:
//                                                                                 Colors.white,
//                                                                             fontSize:
//                                                                                 13,
//                                                                             fontWeight:
//                                                                                 FontWeight.w600,
//                                                                             height:
//                                                                                 0.10,
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     )
//                                                                   ],
//                                                                 ),
//                                                                 GestureDetector(
//                                                                   onTap: () {
//                                                                     Get.to(() =>
//                                                                         ChatGptStartScreen());
//                                                                   },
//                                                                   child: Row(
//                                                                     children: [
//                                                                       SvgPicture
//                                                                           .asset(
//                                                                         ImageConstants
//                                                                             .CHATGPT,
//                                                                         width:
//                                                                             30,
//                                                                         color: AppColor
//                                                                             .DARK_GREEN,
//                                                                       ),
//                                                                       Text(
//                                                                         ' AI assistant',
//                                                                         style: GoogleFonts
//                                                                             .poppins(
//                                                                           color:
//                                                                               AppColor.DARK_GREEN,
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.w600,
//                                                                           height:
//                                                                               0,
//                                                                         ),
//                                                                       )
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     );
//                                                   });
//                                         }),
//                                       ],
//                                     )
//                                   : Container();
//                             });
//                           } else {
//                             return Container(); // Return an empty container if user role is not "Land Owner"
//                           }
//                         } else {
//                           return CircularProgressIndicator(); // Return a loading indicator while fetching user role
//                         }
//                       },
//                     ),
//                     FutureBuilder<String>(
//                       future: homecontroller.prefs.getUserRole(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           if (snapshot.hasData &&
//                               snapshot.data == "Agri Service Provider") {
//                             return Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Near by landowners',
//                                       style: GoogleFonts.poppins(
//                                         color: Color(0xFF483C32),
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     Obx(() => Row(
//                                           children: [
//                                             recoLandowner.farmer.value.result
//                                                         ?.count !=
//                                                     0
//                                                 ? GestureDetector(
//                                                     onTap: () {
//                                                       Get.to(() =>
//                                                           RecommendedLandowners());
//                                                     },
//                                                     child: Text(
//                                                       'View all (${recoLandowner.farmer.value.result?.count ?? 0}) ',
//                                                       style:
//                                                           GoogleFonts.poppins(
//                                                         color:
//                                                             Color(0xFF044D3A),
//                                                         fontSize: 12,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                   )
//                                                 : Container()
//                                           ],
//                                         ))
//                                   ],
//                                 ),
//                                 Obx(() {
//                                   return recoLandowner.farmer.value.result?.data
//                                               ?.length !=
//                                           0
//                                       ? Container(
//                                           margin: EdgeInsets.only(
//                                               bottom: 20, top: 10),
//                                           height: Get.height * 0.14,
//                                           child: ListView.builder(
//                                               itemCount: recoLandowner
//                                                       .farmer
//                                                       .value
//                                                       .result
//                                                       ?.data
//                                                       ?.length ??
//                                                   0,
//                                               scrollDirection: Axis.horizontal,
//                                               itemBuilder: (context, index) {
//                                                 return Container(
//                                                   margin: EdgeInsets.only(
//                                                       right: 20),
//                                                   width: AppDimension.w * 0.8,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.white,
//                                                     border: Border.all(
//                                                         color: AppColor
//                                                             .GREY_BORDER),
//                                                     boxShadow: [
//                                                       AppColor.BOX_SHADOW
//                                                     ],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             18),
//                                                   ),
//                                                   child: Row(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       GestureDetector(
//                                                         onTap: () {
//                                                           Get.to(() => UserProfileScreen(
//                                                               id: recoLandowner
//                                                                       .farmer
//                                                                       .value
//                                                                       .result
//                                                                       ?.data?[
//                                                                           index]
//                                                                       .userId!
//                                                                       .toInt() ??
//                                                                   0,
//                                                               userType: recoLandowner
//                                                                       .farmer
//                                                                       .value
//                                                                       .result
//                                                                       ?.data?[
//                                                                           index]
//                                                                       .userType ??
//                                                                   ""));
//                                                         },
//                                                         child: Container(
//                                                           width:
//                                                               Get.width * 0.25,
//                                                           height:
//                                                               Get.height * 0.16,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color: AppColor
//                                                                 .DARK_GREEN
//                                                                 .withOpacity(
//                                                                     0.1),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .only(
//                                                               bottomLeft: Radius
//                                                                   .circular(18),
//                                                               topLeft: Radius
//                                                                   .circular(18),
//                                                             ),
//                                                             image: recoLandowner
//                                                                             .farmer
//                                                                             .value
//                                                                             .result
//                                                                             ?.data?[
//                                                                                 index]
//                                                                             .image !=
//                                                                         null &&
//                                                                     recoLandowner
//                                                                             .farmer
//                                                                             .value
//                                                                             .result
//                                                                             ?.data?[index]
//                                                                             .image !=
//                                                                         ""
//                                                                 ? DecorationImage(
//                                                                     image:
//                                                                         NetworkImage(
//                                                                       recoLandowner
//                                                                               .farmer
//                                                                               .value
//                                                                               .result
//                                                                               ?.data?[index]
//                                                                               .image! ??
//                                                                           "",
//                                                                     ),
//                                                                     fit: BoxFit
//                                                                         .cover,
//                                                                   )
//                                                                 : null, // Only apply image if it exists
//                                                           ),
//                                                           child: recoLandowner
//                                                                           .farmer
//                                                                           .value
//                                                                           .result
//                                                                           ?.data?[
//                                                                               index]
//                                                                           .image ==
//                                                                       null ||
//                                                                   recoLandowner
//                                                                           .farmer
//                                                                           .value
//                                                                           .result
//                                                                           ?.data?[
//                                                                               index]
//                                                                           .image ==
//                                                                       ""
//                                                               ? Center(
//                                                                   child: Text(
//                                                                     recoLandowner
//                                                                             .farmer
//                                                                             .value
//                                                                             .result
//                                                                             ?.data?[index]
//                                                                             .fullName![0] ??
//                                                                         "",
//                                                                     style: GoogleFonts
//                                                                         .poppins(
//                                                                       fontSize:
//                                                                           50,
//                                                                       color: AppColor
//                                                                           .DARK_GREEN, // Text color contrasting the background
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500,
//                                                                     ),
//                                                                   ),
//                                                                 )
//                                                               : SizedBox(), // Show nothing if image exists
//                                                         ),
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             EdgeInsets.only(
//                                                                 left: 10),
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceEvenly,
//                                                           children: [
//                                                             Text(
//                                                               '${recoLandowner.farmer.value.result?.data?[index].fullName ?? ""}',
//                                                               style: GoogleFonts
//                                                                   .poppins(
//                                                                 color: AppColor
//                                                                     .BROWN_TEXT,
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                               ),
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 SvgPicture
//                                                                     .asset(
//                                                                   "assets/farm/locationbrown.svg",
//                                                                   width: 14,
//                                                                 ),
//                                                                 Container(
//                                                                   width:
//                                                                       Get.width *
//                                                                           0.45,
//                                                                   child: Text(
//                                                                     '  ${recoLandowner.farmer.value.result?.data?[index].livesIn ?? ""}',
//                                                                     overflow:
//                                                                         TextOverflow
//                                                                             .ellipsis,
//                                                                     style: GoogleFonts
//                                                                         .poppins(
//                                                                       color: Color(
//                                                                           0xFF61646B),
//                                                                       fontSize:
//                                                                           8,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500,
//                                                                     ),
//                                                                   ),
//                                                                 )
//                                                               ],
//                                                             ),
//                                                             // Container(
//                                                             //   height: 20,
//                                                             //   width:
//                                                             //       Get.width *
//                                                             //           0.43,
//                                                             //   child: ListView
//                                                             //       .builder(
//                                                             //           scrollDirection: Axis
//                                                             //               .horizontal,
//                                                             //           itemCount: recoLandowner.farmer.value.result?.data?[index].expertise!.length ?? 0,
//                                                             //           itemBuilder:
//                                                             //               (context, indexes) {
//                                                             //             return Container(
//                                                             //               margin: EdgeInsets.symmetric(horizontal: 5),
//                                                             //               padding: EdgeInsets.symmetric(horizontal: 8),
//                                                             //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0x14167C0C)),
//                                                             //               child: Center(
//                                                             //                 child: Text(
//                                                             //                   '${recoLandowner.farmer.value.result?.data?[index].expertise![indexes].name ?? ""}',
//                                                             //                   style: GoogleFonts.poppins(
//                                                             //                     color: AppColor.DARK_GREEN,
//                                                             //                     fontSize: 8,
//                                                             //                     fontWeight: FontWeight.w500,
//                                                             //                   ),
//                                                             //                 ),
//                                                             //               ),
//                                                             //             );
//                                                             //           }),
//                                                             // ),
//                                                             Container(
//                                                               margin: EdgeInsets
//                                                                   .only(
//                                                                       left: 80),
//                                                               padding: EdgeInsets
//                                                                   .symmetric(
//                                                                       horizontal:
//                                                                           15,
//                                                                       vertical:
//                                                                           4),
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             20),
//                                                                 border: Border.all(
//                                                                     color: AppColor
//                                                                         .DARK_GREEN,
//                                                                     width: 1),
//                                                               ),
//                                                               child:
//                                                                   GestureDetector(
//                                                                 onTap: () {
//                                                                   Get.to(() =>
//                                                                       ChatScreen(
//                                                                         landId:
//                                                                             0,
//                                                                         enquiryId:
//                                                                             recoLandowner.farmer.value.result?.data?[index].enquiryId?.toInt() ??
//                                                                                 0,
//                                                                         userId:
//                                                                             recoLandowner.farmer.value.result?.data?[index].userId?.toInt() ??
//                                                                                 0,
//                                                                         userType:
//                                                                             recoLandowner.farmer.value.result?.data?[index].userType ??
//                                                                                 "",
//                                                                         userFrom:
//                                                                             recoLandowner.farmer.value.result?.data?[index].livesIn ??
//                                                                                 "",
//                                                                         userName:
//                                                                             recoLandowner.farmer.value.result?.data?[index].fullName ??
//                                                                                 "",
//                                                                         image: recoLandowner.farmer.value.result?.data?[index].image ??
//                                                                             "",
//                                                                         isEnquiryCreatedByMe:
//                                                                             false,
//                                                                         isEnquiryDisplay:
//                                                                             false,
//                                                                         enquiryData:
//                                                                             "",
//                                                                       ));
//                                                                 },
//                                                                 child: Row(
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .center,
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .center,
//                                                                   children: [
//                                                                     Icon(
//                                                                       Icons
//                                                                           .call,
//                                                                       color: AppColor
//                                                                           .DARK_GREEN,
//                                                                       size: 15,
//                                                                     ),
//                                                                     Text(
//                                                                       '  Contact ',
//                                                                       style:
//                                                                           TextStyle(
//                                                                         color: Color(
//                                                                             0xFF044D3A),
//                                                                         fontSize:
//                                                                             9,
//                                                                         fontFamily:
//                                                                             'Poppins',
//                                                                         fontWeight:
//                                                                             FontWeight.w500,
//                                                                         height:
//                                                                             0.16,
//                                                                       ),
//                                                                     )
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               }))
//                                       : Center(
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 20.0),
//                                             child: Text(
//                                               "There are no Partners",
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Colors.black),
//                                             ),
//                                           ),
//                                         );
//                                 })
//                               ],
//                             );
//                           } else {
//                             return Container();
//                           }
//                         } else {
//                           return CircularProgressIndicator(); // Return a loading indicator while fetching user role
//                         }
//                       },
//                     ),
//                     FutureBuilder<String>(
//                       future: homecontroller.prefs.getUserRole(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           if (snapshot.hasData && snapshot.data == "Farmer" ||
//                               snapshot.data == "Land Owner") {
//                             return Container(
//                               color: Colors.black,
//                             );
//                           } else {
//                             return Container();
//                           }
//                         } else {
//                           return CircularProgressIndicator(); // Return a loading indicator while fetching user role
//                         }
//                       },
//                     ),
//                     FutureBuilder<String>(
//                       future: homecontroller.prefs.getUserRole(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           if (snapshot.hasData && snapshot.data == "Farmer") {
//                             return Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Near by Partners',
//                                       style: GoogleFonts.poppins(
//                                         color: Color(0xFF483C32),
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     Obx(() => Row(
//                                           children: [
//                                             agriController
//                                                         .agriData
//                                                         .value
//                                                         .result
//                                                         ?.pageInfo
//                                                         ?.totalObject !=
//                                                     0
//                                                 ? GestureDetector(
//                                                     onTap: () {
//                                                       dashboardController
//                                                           .selectedIndex
//                                                           .value = 6;
//                                                       //  Get.to(()=>agriData(id: controller.landId.value,));
//                                                     },
//                                                     child: Text(
//                                                       'View all (${agriController.agriData.value.result?.pageInfo?.totalObject ?? 0}) ',
//                                                       style:
//                                                           GoogleFonts.poppins(
//                                                         color:
//                                                             Color(0xFF044D3A),
//                                                         fontSize: 12,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                   )
//                                                 : Container()
//                                           ],
//                                         ))
//                                   ],
//                                 ),
//                                 Obx(() {
//                                   return agriController.agriData.value.result
//                                               ?.data?.length !=
//                                           0
//                                       ? Container(
//                                           margin: EdgeInsets.only(
//                                               bottom: 20, top: 10),
//                                           height: Get.height * 0.14,
//                                           child: ListView.builder(
//                                               itemCount: agriController
//                                                       .agriData
//                                                       .value
//                                                       .result
//                                                       ?.data
//                                                       ?.length ??
//                                                   0,
//                                               scrollDirection: Axis.horizontal,
//                                               itemBuilder: (context, index) {
//                                                 return Container(
//                                                   margin: EdgeInsets.only(
//                                                       right: 20),
//                                                   width: AppDimension.w * 0.8,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.white,
//                                                     border: Border.all(
//                                                         color: AppColor
//                                                             .GREY_BORDER),
//                                                     boxShadow: [
//                                                       AppColor.BOX_SHADOW
//                                                     ],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             18),
//                                                   ),
//                                                   child: Row(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       GestureDetector(
//                                                         onTap: () {
//                                                           Get.to(() => UserProfileScreen(
//                                                               id: agriController
//                                                                       .agriData
//                                                                       .value
//                                                                       .result
//                                                                       ?.data?[
//                                                                           index]
//                                                                       .userId!
//                                                                       .toInt() ??
//                                                                   0,
//                                                               userType: agriController
//                                                                       .agriData
//                                                                       .value
//                                                                       .result
//                                                                       ?.data?[
//                                                                           index]
//                                                                       .userType ??
//                                                                   ""));
//                                                         },
//                                                         child: Container(
//                                                           width:
//                                                               Get.width * 0.25,
//                                                           height:
//                                                               Get.height * 0.16,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color: AppColor
//                                                                 .DARK_GREEN
//                                                                 .withOpacity(
//                                                                     0.1),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .only(
//                                                               bottomLeft: Radius
//                                                                   .circular(18),
//                                                               topLeft: Radius
//                                                                   .circular(18),
//                                                             ),
//                                                             image: agriController
//                                                                             .agriData
//                                                                             .value
//                                                                             .result
//                                                                             ?.data?[
//                                                                                 index]
//                                                                             .image !=
//                                                                         null &&
//                                                                     agriController
//                                                                             .agriData
//                                                                             .value
//                                                                             .result
//                                                                             ?.data?[index]
//                                                                             .image !=
//                                                                         ""
//                                                                 ? DecorationImage(
//                                                                     image:
//                                                                         NetworkImage(
//                                                                       agriController
//                                                                               .agriData
//                                                                               .value
//                                                                               .result
//                                                                               ?.data?[index]
//                                                                               .image! ??
//                                                                           "",
//                                                                     ),
//                                                                     fit: BoxFit
//                                                                         .cover,
//                                                                   )
//                                                                 : null, // Only apply image if it exists
//                                                           ),
//                                                           child: agriController
//                                                                           .agriData
//                                                                           .value
//                                                                           .result
//                                                                           ?.data?[
//                                                                               index]
//                                                                           .image ==
//                                                                       null ||
//                                                                   agriController
//                                                                           .agriData
//                                                                           .value
//                                                                           .result
//                                                                           ?.data?[
//                                                                               index]
//                                                                           .image ==
//                                                                       ""
//                                                               ? Center(
//                                                                   child: Text(
//                                                                     agriController.agriData.value.result?.data?[index].fullName !=
//                                                                                 null &&
//                                                                             agriController.agriData.value.result?.data?[index].fullName !=
//                                                                                 ""
//                                                                         ? agriController.agriData.value.result?.data![index].fullName![0].toUpperCase() ??
//                                                                             "".toUpperCase()
//                                                                         : '',
//                                                                     style: GoogleFonts
//                                                                         .poppins(
//                                                                       fontSize:
//                                                                           50,
//                                                                       color: AppColor
//                                                                           .DARK_GREEN, // Text color contrasting the background
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500,
//                                                                     ),
//                                                                   ),
//                                                                 )
//                                                               : SizedBox(), // Show nothing if image exists
//                                                         ),
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             EdgeInsets.only(
//                                                                 left: 10),
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceEvenly,
//                                                           children: [
//                                                             Text(
//                                                               '${agriController.agriData.value.result?.data?[index].fullName ?? ""}',
//                                                               style: GoogleFonts
//                                                                   .poppins(
//                                                                 color: AppColor
//                                                                     .BROWN_TEXT,
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                               ),
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 SvgPicture
//                                                                     .asset(
//                                                                   "assets/farm/locationbrown.svg",
//                                                                   width: 14,
//                                                                 ),
//                                                                 Container(
//                                                                   width:
//                                                                       Get.width *
//                                                                           0.45,
//                                                                   child: Text(
//                                                                     '  ${agriController.agriData.value.result?.data?[index].livesIn ?? ""}',
//                                                                     overflow:
//                                                                         TextOverflow
//                                                                             .ellipsis,
//                                                                     style: GoogleFonts
//                                                                         .poppins(
//                                                                       color: Color(
//                                                                           0xFF61646B),
//                                                                       fontSize:
//                                                                           8,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500,
//                                                                     ),
//                                                                   ),
//                                                                 )
//                                                               ],
//                                                             ),
//                                                             Container(
//                                                               height: 20,
//                                                               width: Get.width *
//                                                                   0.43,
//                                                               child: ListView
//                                                                   .builder(
//                                                                       scrollDirection:
//                                                                           Axis
//                                                                               .horizontal,
//                                                                       itemCount: agriController
//                                                                               .agriData
//                                                                               .value
//                                                                               .result
//                                                                               ?.data?[
//                                                                                   index]
//                                                                               .roles
//                                                                               ?.length ??
//                                                                           0,
//                                                                       itemBuilder:
//                                                                           (context,
//                                                                               indexes) {
//                                                                         return Container(
//                                                                           margin:
//                                                                               EdgeInsets.symmetric(horizontal: 5),
//                                                                           padding:
//                                                                               EdgeInsets.symmetric(horizontal: 8),
//                                                                           decoration: BoxDecoration(
//                                                                               borderRadius: BorderRadius.circular(20),
//                                                                               color: Color(0x14167C0C)),
//                                                                           child:
//                                                                               Center(
//                                                                             child:
//                                                                                 Text(
//                                                                               '${agriController.agriData.value.result?.data?[index].roles![indexes].name ?? ""}',
//                                                                               style: GoogleFonts.poppins(
//                                                                                 color: AppColor.DARK_GREEN,
//                                                                                 fontSize: 8,
//                                                                                 fontWeight: FontWeight.w500,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         );
//                                                                       }),
//                                                             ),
//                                                             Container(
//                                                               margin: EdgeInsets
//                                                                   .only(
//                                                                       left: 80),
//                                                               padding: EdgeInsets
//                                                                   .symmetric(
//                                                                       horizontal:
//                                                                           15,
//                                                                       vertical:
//                                                                           4),
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             20),
//                                                                 border: Border.all(
//                                                                     color: AppColor
//                                                                         .DARK_GREEN,
//                                                                     width: 1),
//                                                               ),
//                                                               child:
//                                                                   GestureDetector(
//                                                                 onTap: () {
//                                                                   Get.to(() =>
//                                                                       ChatScreen(
//                                                                         landId:
//                                                                             0,
//                                                                         enquiryId:
//                                                                             agriController.agriData.value.result?.data?[index].enquiryId?.toInt() ??
//                                                                                 0,
//                                                                         userId:
//                                                                             agriController.agriData.value.result?.data?[index].userId?.toInt() ??
//                                                                                 0,
//                                                                         userType:
//                                                                             agriController.agriData.value.result?.data?[index].userType ??
//                                                                                 "",
//                                                                         userFrom:
//                                                                             agriController.agriData.value.result?.data?[index].livesIn ??
//                                                                                 "",
//                                                                         userName:
//                                                                             agriController.agriData.value.result?.data?[index].fullName ??
//                                                                                 "",
//                                                                         image: agriController.agriData.value.result?.data?[index].image ??
//                                                                             "",
//                                                                         isEnquiryCreatedByMe:
//                                                                             false,
//                                                                         isEnquiryDisplay:
//                                                                             false,
//                                                                         enquiryData:
//                                                                             "",
//                                                                       ));
//                                                                 },
//                                                                 child: Row(
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .center,
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .center,
//                                                                   children: [
//                                                                     Icon(
//                                                                       Icons
//                                                                           .call,
//                                                                       color: AppColor
//                                                                           .DARK_GREEN,
//                                                                       size: 15,
//                                                                     ),
//                                                                     Text(
//                                                                       '  Contact ',
//                                                                       style:
//                                                                           TextStyle(
//                                                                         color: Color(
//                                                                             0xFF044D3A),
//                                                                         fontSize:
//                                                                             9,
//                                                                         fontFamily:
//                                                                             'Poppins',
//                                                                         fontWeight:
//                                                                             FontWeight.w500,
//                                                                         height:
//                                                                             0.16,
//                                                                       ),
//                                                                     )
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               }))
//                                       : Container(
//                                           margin: EdgeInsets.symmetric(
//                                               vertical: 10),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Container(
//                                                 child: Lottie.asset(
//                                                     "assets/lotties/animation.json",
//                                                     width: double.infinity),
//                                               )
//                                             ],
//                                           ),
//                                         );
//                                 }),
//                                 Column(
//                                   children: [
//                                     Obx(() {
//                                       return recommendedlandController.landData
//                                                   .value.result?.count !=
//                                               0
//                                           ? Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   'Near by lands',
//                                                   style: GoogleFonts.poppins(
//                                                     color: Color(0xFF483C32),
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     Get.to(() =>
//                                                         RecommendedLandsList());
//                                                   },
//                                                   child: Text(
//                                                     'View all (${recommendedlandController.landData.value.result?.count ?? 0}) >',
//                                                     style: GoogleFonts.poppins(
//                                                       color: Color(0xFF044D3A),
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             )
//                                           : Container();
//                                     }),
//                                     Obx(() {
//                                       return ListView.builder(
//                                           shrinkWrap: true,
//                                           physics:
//                                               NeverScrollableScrollPhysics(),
//                                           itemCount: recommendedlandController
//                                                       .landData
//                                                       .value
//                                                       .result
//                                                       ?.recommendedLands
//                                                       ?.length !=
//                                                   null
//                                               ? (recommendedlandController
//                                                           .landData
//                                                           .value
//                                                           .result!
//                                                           .recommendedLands!
//                                                           .length >
//                                                       2
//                                                   ? 2
//                                                   : recommendedlandController
//                                                       .landData
//                                                       .value
//                                                       .result!
//                                                       .recommendedLands!
//                                                       .length)
//                                               : 0,
//                                           itemBuilder: (context, index) {
//                                             return GestureDetector(
//                                               onTap: () {
//                                                 Get.to(
//                                                     () => RecommendedLandInfo(
//                                                           id: recommendedlandController
//                                                                   .landData
//                                                                   .value
//                                                                   .result
//                                                                   ?.recommendedLands?[
//                                                                       index]
//                                                                   .id ??
//                                                               0,
//                                                           name: recommendedlandController
//                                                                   .landData
//                                                                   .value
//                                                                   .result
//                                                                   ?.recommendedLands?[
//                                                                       index]
//                                                                   .landOwnerName ??
//                                                               "",
//                                                         ));
//                                               },
//                                               child: Column(
//                                                 children: [
//                                                   Container(
//                                                     margin: EdgeInsets.only(
//                                                       top: 10,
//                                                     ),
//                                                     padding:
//                                                         EdgeInsets.symmetric(
//                                                       vertical: 10,
//                                                     ),
//                                                     decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius.only(
//                                                                 topRight: Radius
//                                                                     .circular(
//                                                                         20),
//                                                                 topLeft: Radius
//                                                                     .circular(
//                                                                         20)),
//                                                         color: Colors.white,
//                                                         boxShadow: [
//                                                           AppColor.BOX_SHADOW
//                                                         ]),
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Obx(() {
//                                                           return recommendedlandController
//                                                                       .landData
//                                                                       .value
//                                                                       .result
//                                                                       ?.recommendedLands?[
//                                                                           index]
//                                                                       .landImages
//                                                                       ?.length !=
//                                                                   0
//                                                               ? Column(
//                                                                   children: [
//                                                                     Container(
//                                                                       height: Get
//                                                                               .height *
//                                                                           0.17,
//                                                                       child: ListView.builder(
//                                                                           itemCount: recommendedlandController.landData.value.result?.recommendedLands?[index].landImages?.length ?? 0,
//                                                                           scrollDirection: Axis.horizontal,
//                                                                           itemBuilder: (context, imgindex) {
//                                                                             return Container(
//                                                                               margin: EdgeInsets.symmetric(horizontal: 10),
//                                                                               height: Get.height * 0.17,
//                                                                               width: Get.width * 0.34,
//                                                                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: NetworkImage("${recommendedlandController.landData.value.result?.recommendedLands?[index].landImages?[imgindex].image}"), fit: BoxFit.cover)),
//                                                                             );
//                                                                           }),
//                                                                     ),
//                                                                     Row(
//                                                                       children: List.generate(
//                                                                           450 ~/ 4,
//                                                                           (index) => Expanded(
//                                                                                 child: Container(
//                                                                                   margin: EdgeInsets.symmetric(vertical: 10),
//                                                                                   color: index % 2 == 0 ? Colors.transparent : AppColor.GREY_BORDER,
//                                                                                   height: 1,
//                                                                                 ),
//                                                                               )),
//                                                                     ),
//                                                                   ],
//                                                                 )
//                                                               : Container();
//                                                         }),
//                                                         Row(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceEvenly,
//                                                           children: [
//                                                             Column(
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .center,
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .start,
//                                                               children: [
//                                                                 SvgPicture
//                                                                     .asset(
//                                                                   ImageConstants
//                                                                       .LAND,
//                                                                   height: 28,
//                                                                   width: 28,
//                                                                 ),
//                                                                 Container(
//                                                                   margin: EdgeInsets
//                                                                       .only(
//                                                                           top:
//                                                                               5),
//                                                                   child: Text(
//                                                                     "Land #${recommendedlandController.landData.value.result?.recommendedLands?[index].id ?? 0}",
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .center,
//                                                                     style: GoogleFonts
//                                                                         .poppins(
//                                                                       color: AppColor
//                                                                           .DARK_GREEN,
//                                                                       fontSize:
//                                                                           10,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w600,
//                                                                       height:
//                                                                           2.5,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 Container(
//                                                                   width:
//                                                                       Get.width *
//                                                                           0.25,
//                                                                   child: Text(
//                                                                     "${recommendedlandController.landData.value.result?.recommendedLands?[index].city ?? ""} ${recommendedlandController.landData.value.result?.recommendedLands?[index].state ?? ""} ${recommendedlandController.landData.value.result?.recommendedLands?[index].country ?? ""}",
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .center,
//                                                                     style: GoogleFonts
//                                                                         .poppins(
//                                                                       color: AppColor
//                                                                           .GREEN_SUBTEXT,
//                                                                       fontSize:
//                                                                           10,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500,
//                                                                     ),
//                                                                   ),
//                                                                 )
//                                                               ],
//                                                             ),
//                                                             Container(
//                                                               height:
//                                                                   Get.height *
//                                                                       0.12,
//                                                               child: Column(
//                                                                 children: List
//                                                                     .generate(
//                                                                   450 ~/ 10,
//                                                                   (index) =>
//                                                                       Expanded(
//                                                                     child:
//                                                                         Container(
//                                                                       color: index %
//                                                                                   2 ==
//                                                                               0
//                                                                           ? Colors
//                                                                               .transparent
//                                                                           : AppColor
//                                                                               .GREY_BORDER,
//                                                                       width:
//                                                                           1, // Height changed to width
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Container(
//                                                               height:
//                                                                   Get.height *
//                                                                       0.13,
//                                                               width: Get.width *
//                                                                   0.3,
//                                                               child: Center(
//                                                                 child: Column(
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .center,
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .start,
//                                                                   children: [
//                                                                     SvgPicture
//                                                                         .asset(
//                                                                       ImageConstants
//                                                                           .AREA,
//                                                                       height:
//                                                                           28,
//                                                                       width: 28,
//                                                                     ),
//                                                                     Container(
//                                                                       margin: EdgeInsets
//                                                                           .only(
//                                                                               top: 5),
//                                                                       child:
//                                                                           Text(
//                                                                         'Area',
//                                                                         textAlign:
//                                                                             TextAlign.center,
//                                                                         style: GoogleFonts
//                                                                             .poppins(
//                                                                           color:
//                                                                               AppColor.DARK_GREEN,
//                                                                           fontSize:
//                                                                               10,
//                                                                           fontWeight:
//                                                                               FontWeight.w600,
//                                                                           height:
//                                                                               2.5,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     SizedBox(
//                                                                       width: AppDimension
//                                                                               .w *
//                                                                           0.5,
//                                                                       child:
//                                                                           Text(
//                                                                         "${recommendedlandController.landData.value.result?.recommendedLands?[index].landSize ?? ""}",
//                                                                         textAlign:
//                                                                             TextAlign.center,
//                                                                         style: GoogleFonts
//                                                                             .poppins(
//                                                                           color:
//                                                                               AppColor.GREEN_SUBTEXT,
//                                                                           fontSize:
//                                                                               10,
//                                                                           fontWeight:
//                                                                               FontWeight.w500,
//                                                                         ),
//                                                                       ),
//                                                                     )
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Container(
//                                                               height:
//                                                                   Get.height *
//                                                                       0.12,
//                                                               child: Column(
//                                                                 children: List
//                                                                     .generate(
//                                                                   450 ~/ 10,
//                                                                   (index) =>
//                                                                       Expanded(
//                                                                     child:
//                                                                         Container(
//                                                                       // Adjusted to horizontal margin
//                                                                       color: index %
//                                                                                   2 ==
//                                                                               0
//                                                                           ? Colors
//                                                                               .transparent
//                                                                           : AppColor
//                                                                               .GREY_BORDER,
//                                                                       width:
//                                                                           1, // Height changed to width
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Container(
//                                                               width: Get.width *
//                                                                   0.3,
//                                                               child: Center(
//                                                                 child: Column(
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .center,
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .spaceEvenly,
//                                                                   children: [
//                                                                     SvgPicture
//                                                                         .asset(
//                                                                       ImageConstants
//                                                                           .CROP,
//                                                                       height:
//                                                                           28,
//                                                                       width: 28,
//                                                                     ),
//                                                                     Container(
//                                                                       margin: EdgeInsets
//                                                                           .only(
//                                                                               top: 5),
//                                                                       child:
//                                                                           Text(
//                                                                         'Crop Preferences',
//                                                                         textAlign:
//                                                                             TextAlign.center,
//                                                                         style: GoogleFonts
//                                                                             .poppins(
//                                                                           color:
//                                                                               AppColor.DARK_GREEN,
//                                                                           fontSize:
//                                                                               10,
//                                                                           fontWeight:
//                                                                               FontWeight.w600,
//                                                                           height:
//                                                                               2.5,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     SizedBox(
//                                                                       height:
//                                                                           40,
//                                                                       width: Get
//                                                                               .width *
//                                                                           0.2,
//                                                                       child: ListView
//                                                                           .builder(
//                                                                         scrollDirection:
//                                                                             Axis.vertical,
//                                                                         itemCount:
//                                                                             recommendedlandController.landData.value.result?.recommendedLands?[index].cropToGrow?.length ??
//                                                                                 0,
//                                                                         itemBuilder:
//                                                                             (context,
//                                                                                 cropdata) {
//                                                                           return Text(
//                                                                             "${recommendedlandController.landData.value.result?.recommendedLands?[index].cropToGrow?[cropdata].name ?? ""}",
//                                                                             textAlign:
//                                                                                 TextAlign.center,
//                                                                             style:
//                                                                                 GoogleFonts.poppins(
//                                                                               color: AppColor.GREEN_SUBTEXT,
//                                                                               fontSize: 10,
//                                                                               fontWeight: FontWeight.w500,
//                                                                             ),
//                                                                           );
//                                                                         },
//                                                                       ),
//                                                                     )
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         Center(
//                                                           child: Container(
//                                                             margin: EdgeInsets
//                                                                 .symmetric(
//                                                                     vertical:
//                                                                         10,
//                                                                     horizontal:
//                                                                         10),
//                                                             width:
//                                                                 double.infinity,
//                                                             child: DottedBorder(
//                                                                 color: AppColor
//                                                                     .GREY_BORDER,
//                                                                 radius: Radius
//                                                                     .circular(
//                                                                         12),
//                                                                 borderType:
//                                                                     BorderType
//                                                                         .RRect,
//                                                                 dashPattern: [
//                                                                   5,
//                                                                   2
//                                                                 ],
//                                                                 child:
//                                                                     Container(
//                                                                   padding: EdgeInsets.symmetric(
//                                                                       vertical:
//                                                                           10,
//                                                                       horizontal:
//                                                                           10),
//                                                                   child: Center(
//                                                                     child:
//                                                                         Column(
//                                                                       crossAxisAlignment:
//                                                                           CrossAxisAlignment
//                                                                               .center,
//                                                                       mainAxisAlignment:
//                                                                           MainAxisAlignment
//                                                                               .center,
//                                                                       children: [
//                                                                         Text(
//                                                                             'Land Owner’s Purpose',
//                                                                             style:
//                                                                                 GoogleFonts.poppins(
//                                                                               color: Color(0xFF044D3A),
//                                                                               fontSize: 10,
//                                                                               fontWeight: FontWeight.w500,
//                                                                               decoration: TextDecoration.underline,
//                                                                               decorationColor: AppColor.DARK_GREEN,
//                                                                             )),
//                                                                         Text(
//                                                                           '${recommendedlandController.landData.value.result?.recommendedLands?[index].purpose?.name ?? ""}',
//                                                                           style:
//                                                                               GoogleFonts.poppins(
//                                                                             color:
//                                                                                 Color(0xFF044D3A),
//                                                                             fontSize:
//                                                                                 12,
//                                                                             fontWeight:
//                                                                                 FontWeight.w500,
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 )),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     padding:
//                                                         EdgeInsets.symmetric(
//                                                             vertical: 15),
//                                                     margin: EdgeInsets.only(
//                                                         bottom: 20),
//                                                     decoration: BoxDecoration(
//                                                         color:
//                                                             Color(0x38044D3A),
//                                                         borderRadius:
//                                                             BorderRadius.only(
//                                                                 bottomLeft: Radius
//                                                                     .circular(
//                                                                         20),
//                                                                 bottomRight: Radius
//                                                                     .circular(
//                                                                         20))),
//                                                     child: Row(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         SvgPicture.asset(
//                                                           ImageConstants
//                                                               .ENQUIRIES,
//                                                           width:
//                                                               Get.width * 0.06,
//                                                         ),
//                                                         Text(
//                                                           'Contact Land Owner',
//                                                           style: GoogleFonts
//                                                               .poppins(
//                                                             color: AppColor
//                                                                 .DARK_GREEN,
//                                                             fontSize: 11,
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             );
//                                           });
//                                     }),
//                                   ],
//                                 )
//                               ],
//                             );
//                           } else {
//                             return Container(); // Return an empty container if user role is not "Land Owner"
//                           }
//                         } else {
//                           return CircularProgressIndicator(); // Return a loading indicator while fetching user role
//                         }
//                       },
//                     ),
//                     FutureBuilder<String>(
//                       future: homecontroller.prefs.getUserRole(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           if (snapshot.hasData &&
//                               snapshot.data == "Agri Service Provider") {
//                             return Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Farmers',
//                                       style: GoogleFonts.poppins(
//                                         color: Color(0xFF483C32),
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     Obx(() {
//                                       return Row(
//                                         children: [
//                                           farmerController.farmer.value.result
//                                                       ?.pageInfo?.totalObject !=
//                                                   0
//                                               ? GestureDetector(
//                                                   onTap: () {
//                                                     dashboardController
//                                                         .selectedIndex
//                                                         .value = 4;
//                                                   },
//                                                   child: Text(
//                                                     'View all (${farmerController.farmer.value.result?.pageInfo?.totalObject ?? 0}) ',
//                                                     style: GoogleFonts.poppins(
//                                                       color: Color(0xFF044D3A),
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                 )
//                                               : Container()
//                                         ],
//                                       );
//                                     })
//                                   ],
//                                 ),
//                                 Obx(() {
//                                   return farmerController.farmer.value.result
//                                               ?.data?.length !=
//                                           0
//                                       ? Container(
//                                           margin: EdgeInsets.only(
//                                               bottom: 20, top: 10),
//                                           height: Get.height * 0.14,
//                                           child: ListView.builder(
//                                               itemCount: farmerController
//                                                       .farmer
//                                                       .value
//                                                       .result
//                                                       ?.data
//                                                       ?.length ??
//                                                   0,
//                                               scrollDirection: Axis.horizontal,
//                                               itemBuilder: (context, index) {
//                                                 return Container(
//                                                   margin: EdgeInsets.only(
//                                                       right: 20),
//                                                   width: AppDimension.w * 0.8,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.white,
//                                                     border: Border.all(
//                                                         color: AppColor
//                                                             .GREY_BORDER),
//                                                     boxShadow: [
//                                                       AppColor.BOX_SHADOW
//                                                     ],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             18),
//                                                   ),
//                                                   child: Row(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       GestureDetector(
//                                                         onTap: () {
//                                                           Get.to(() => UserProfileScreen(
//                                                               id: farmerController
//                                                                       .farmer
//                                                                       .value
//                                                                       .result
//                                                                       ?.data?[
//                                                                           index]
//                                                                       .userId!
//                                                                       .toInt() ??
//                                                                   0,
//                                                               userType: farmerController
//                                                                       .farmer
//                                                                       .value
//                                                                       .result
//                                                                       ?.data?[
//                                                                           index]
//                                                                       .userType ??
//                                                                   ""));
//                                                         },
//                                                         child: Container(
//                                                           width:
//                                                               Get.width * 0.25,
//                                                           height:
//                                                               Get.height * 0.16,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color: AppColor
//                                                                 .DARK_GREEN
//                                                                 .withOpacity(
//                                                                     0.1),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .only(
//                                                               bottomLeft: Radius
//                                                                   .circular(18),
//                                                               topLeft: Radius
//                                                                   .circular(18),
//                                                             ),
//                                                             image: farmerController
//                                                                             .farmer
//                                                                             .value
//                                                                             .result
//                                                                             ?.data?[
//                                                                                 index]
//                                                                             .image !=
//                                                                         null &&
//                                                                     farmerController
//                                                                             .farmer
//                                                                             .value
//                                                                             .result
//                                                                             ?.data?[index]
//                                                                             .image !=
//                                                                         ""
//                                                                 ? DecorationImage(
//                                                                     image:
//                                                                         NetworkImage(
//                                                                       farmerController
//                                                                               .farmer
//                                                                               .value
//                                                                               .result
//                                                                               ?.data?[index]
//                                                                               .image! ??
//                                                                           "",
//                                                                     ),
//                                                                     fit: BoxFit
//                                                                         .cover,
//                                                                   )
//                                                                 : null,
//                                                           ),
//                                                           child: farmerController
//                                                                           .farmer
//                                                                           .value
//                                                                           .result
//                                                                           ?.data?[
//                                                                               index]
//                                                                           .image ==
//                                                                       null ||
//                                                                   farmerController
//                                                                           .farmer
//                                                                           .value
//                                                                           .result
//                                                                           ?.data?[
//                                                                               index]
//                                                                           .image ==
//                                                                       ""
//                                                               ? Center(
//                                                                   child: Text(
//                                                                     farmerController
//                                                                             .farmer
//                                                                             .value
//                                                                             .result
//                                                                             ?.data?[index]
//                                                                             .fullName![0] ??
//                                                                         "",
//                                                                     style: GoogleFonts
//                                                                         .poppins(
//                                                                       fontSize:
//                                                                           50,
//                                                                       color: AppColor
//                                                                           .DARK_GREEN, // Text color contrasting the background
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500,
//                                                                     ),
//                                                                   ),
//                                                                 )
//                                                               : SizedBox(), // Show nothing if image exists
//                                                         ),
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             EdgeInsets.only(
//                                                                 left: 10),
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceEvenly,
//                                                           children: [
//                                                             SizedBox(
//                                                               height: 8,
//                                                             ),
//                                                             Text(
//                                                               '${farmerController.farmer.value.result?.data?[index].fullName ?? ""}',
//                                                               style: GoogleFonts
//                                                                   .poppins(
//                                                                 color: AppColor
//                                                                     .BROWN_TEXT,
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                               ),
//                                                             ),
//                                                             SizedBox(
//                                                               height: 5,
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 SvgPicture
//                                                                     .asset(
//                                                                   "assets/farm/locationbrown.svg",
//                                                                   width: 14,
//                                                                 ),
//                                                                 Container(
//                                                                   width:
//                                                                       Get.width *
//                                                                           0.45,
//                                                                   child: Text(
//                                                                     '  ${farmerController.farmer.value.result?.data?[index].livesIn ?? ""}',
//                                                                     overflow:
//                                                                         TextOverflow
//                                                                             .ellipsis,
//                                                                     style: GoogleFonts
//                                                                         .poppins(
//                                                                       color: Color(
//                                                                           0xFF61646B),
//                                                                       fontSize:
//                                                                           8,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500,
//                                                                     ),
//                                                                   ),
//                                                                 )
//                                                               ],
//                                                             ),
//                                                             Container(
//                                                               height: 20,
//                                                               width: Get.width *
//                                                                   0.43,
//                                                               child: ListView
//                                                                   .builder(
//                                                                       scrollDirection:
//                                                                           Axis
//                                                                               .horizontal,
//                                                                       itemCount: farmerController
//                                                                               .farmer
//                                                                               .value
//                                                                               .result
//                                                                               ?.data?[
//                                                                                   index]
//                                                                               .expertise!
//                                                                               .length ??
//                                                                           0,
//                                                                       itemBuilder:
//                                                                           (context,
//                                                                               indexes) {
//                                                                         return Container(
//                                                                           margin:
//                                                                               EdgeInsets.symmetric(horizontal: 5),
//                                                                           padding:
//                                                                               EdgeInsets.symmetric(horizontal: 8),
//                                                                           decoration: BoxDecoration(
//                                                                               borderRadius: BorderRadius.circular(20),
//                                                                               color: Color(0x14167C0C)),
//                                                                           child:
//                                                                               Center(
//                                                                             child:
//                                                                                 Text(
//                                                                               '${farmerController.farmer.value.result?.data?[index].expertise![indexes].name ?? ""}',
//                                                                               style: GoogleFonts.poppins(
//                                                                                 color: AppColor.DARK_GREEN,
//                                                                                 fontSize: 8,
//                                                                                 fontWeight: FontWeight.w500,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         );
//                                                                       }),
//                                                             ),
//                                                             Container(
//                                                               margin: EdgeInsets
//                                                                   .only(
//                                                                       left: 80,
//                                                                       bottom:
//                                                                           11),
//                                                               padding: EdgeInsets
//                                                                   .symmetric(
//                                                                       horizontal:
//                                                                           15,
//                                                                       vertical:
//                                                                           4),
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             20),
//                                                                 border: Border.all(
//                                                                     color: AppColor
//                                                                         .DARK_GREEN,
//                                                                     width: 1),
//                                                               ),
//                                                               child:
//                                                                   GestureDetector(
//                                                                 onTap: () {
//                                                                   Get.to(() =>
//                                                                       ChatScreen(
//                                                                         landId:
//                                                                             0,
//                                                                         enquiryId:
//                                                                             farmerController.farmer.value.result?.data?[index].enquiryId?.toInt() ??
//                                                                                 0,
//                                                                         userId:
//                                                                             farmerController.farmer.value.result?.data?[index].userId?.toInt() ??
//                                                                                 0,
//                                                                         userType:
//                                                                             farmerController.farmer.value.result?.data?[index].userType ??
//                                                                                 "",
//                                                                         userFrom:
//                                                                             farmerController.farmer.value.result?.data?[index].livesIn ??
//                                                                                 "",
//                                                                         userName:
//                                                                             farmerController.farmer.value.result?.data?[index].fullName ??
//                                                                                 "",
//                                                                         image: farmerController.farmer.value.result?.data?[index].image ??
//                                                                             "",
//                                                                         isEnquiryCreatedByMe:
//                                                                             false,
//                                                                         isEnquiryDisplay:
//                                                                             false,
//                                                                         enquiryData:
//                                                                             "",
//                                                                       ));
//                                                                 },
//                                                                 child: Row(
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .center,
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .center,
//                                                                   children: [
//                                                                     Icon(
//                                                                       Icons
//                                                                           .call,
//                                                                       color: AppColor
//                                                                           .DARK_GREEN,
//                                                                       size: 15,
//                                                                     ),
//                                                                     Text(
//                                                                       '  Contact ',
//                                                                       style:
//                                                                           TextStyle(
//                                                                         color: Color(
//                                                                             0xFF044D3A),
//                                                                         fontSize:
//                                                                             9,
//                                                                         fontFamily:
//                                                                             'Poppins',
//                                                                         fontWeight:
//                                                                             FontWeight.w500,
//                                                                         height:
//                                                                             0.16,
//                                                                       ),
//                                                                     )
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               }))
//                                       : Container(
//                                           margin: EdgeInsets.symmetric(
//                                               vertical: 10),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Container(
//                                                 child: Lottie.asset(
//                                                     "assets/lotties/animation.json",
//                                                     height: 100,
//                                                     width: double.infinity),
//                                               )
//                                             ],
//                                           ),
//                                         );
//                                 })
//                               ],
//                             );
//                           } else {
//                             return Container(); // Return an empty container if user role is not "Land Owner"
//                           }
//                         } else {
//                           return CircularProgressIndicator(); // Return a loading indicator while fetching user role
//                         }
//                       },
//                     ),
//                     FutureBuilder<String>(
//                       future: homecontroller.prefs.getUserRole(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           if (snapshot.hasData && snapshot.data == "Farmer" ||
//                               snapshot.data == "Land Owner") {
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 20, horizontal: 15),
//                                   margin: EdgeInsets.symmetric(vertical: 10),
//                                   width: double.infinity,
//                                   decoration: ShapeDecoration(
//                                     color: Color(0xFFFFFFF7),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     shadows: [
//                                       BoxShadow(
//                                         color: Color(0x19000000),
//                                         blurRadius: 24,
//                                         offset: Offset(0, 2),
//                                         spreadRadius: 0,
//                                       )
//                                     ],
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Calculate Crop Earning Yield",
//                                         style: GoogleFonts.poppins(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                       Container(
//                                         margin:
//                                             EdgeInsets.symmetric(vertical: 10),
//                                         child: Text(
//                                           "Select crops(upto 3)",
//                                           style: GoogleFonts.poppins(
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 13,
//                                           ),
//                                         ),
//                                       ),
//                                       GestureDetector(
//                                         onTap: () {
//                                           showModalBottomSheet(
//                                             context: context,
//                                             isScrollControlled: true,
//                                             builder: (context) {
//                                               return Container(
//                                                   height: MediaQuery.of(context)
//                                                           .size
//                                                           .height *
//                                                       0.7,
//                                                   child: Column(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     children: [
//                                                       Container(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 horizontal: 12,
//                                                                 vertical: 15),
//                                                         margin: EdgeInsets.only(
//                                                             bottom: 0),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                                 color: AppColor
//                                                                     .DARK_GREEN,
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .only(
//                                                                   topLeft: Radius
//                                                                       .circular(
//                                                                           12),
//                                                                   topRight: Radius
//                                                                       .circular(
//                                                                           12),
//                                                                 )),
//                                                         child: Row(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .center,
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             Text(
//                                                               "Select Crops",
//                                                               style: GoogleFonts.poppins(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 16,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500),
//                                                             ),
//                                                             GestureDetector(
//                                                               onTap: () {
//                                                                 cropgridCalculator
//                                                                     .selectedCropsId
//                                                                     .clear();
//                                                                 cropgridCalculator
//                                                                     .selectedCropsName
//                                                                     .clear();
//                                                                 cropgridCalculator
//                                                                     .selectedCropsImages
//                                                                     .clear();
//                                                                 Get.back();
//                                                               },
//                                                               child:
//                                                                   CircleAvatar(
//                                                                 radius: 10,
//                                                                 backgroundColor:
//                                                                     Colors
//                                                                         .white,
//                                                                 child: Icon(
//                                                                   Icons.close,
//                                                                   color: AppColor
//                                                                       .DARK_GREEN,
//                                                                   size: 18,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Obx(() =>
//                                                           cropgridCalculator
//                                                                   .selectedCropsId
//                                                                   .isEmpty
//                                                               ? Container()
//                                                               : Column(
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .start,
//                                                                   children: [
//                                                                     Padding(
//                                                                       padding: const EdgeInsets
//                                                                           .all(
//                                                                           10.0),
//                                                                       child:
//                                                                           Text(
//                                                                         "Selected Crop List",
//                                                                         style: GoogleFonts.poppins(
//                                                                             fontSize:
//                                                                                 12,
//                                                                             fontWeight:
//                                                                                 FontWeight.w500,
//                                                                             color: Color(0xFF333333)),
//                                                                       ),
//                                                                     ),
//                                                                     Container(
//                                                                       margin: EdgeInsets.only(
//                                                                           top:
//                                                                               5,
//                                                                           bottom:
//                                                                               20,
//                                                                           left:
//                                                                               10,
//                                                                           right:
//                                                                               10),
//                                                                       height: MediaQuery.of(context)
//                                                                               .size
//                                                                               .height *
//                                                                           0.12,
//                                                                       width: double
//                                                                           .infinity,
//                                                                       child: ListView
//                                                                           .builder(
//                                                                         scrollDirection:
//                                                                             Axis.horizontal,
//                                                                         shrinkWrap:
//                                                                             true,
//                                                                         itemCount:
//                                                                             cropgridCalculator.selectedCropsId.length ??
//                                                                                 0,
//                                                                         itemBuilder:
//                                                                             (context,
//                                                                                 index) {
//                                                                           return Container(
//                                                                             margin:
//                                                                                 EdgeInsets.only(right: 10),
//                                                                             child:
//                                                                                 Column(
//                                                                               children: [
//                                                                                 Stack(
//                                                                                   children: [
//                                                                                     GestureDetector(
//                                                                                       onTap: () {
//                                                                                         // print("ON TAP");
//                                                                                         // cropgridCalculator.removeCrop(cropgridCalculator.selectedCropsName[index], cropgridCalculator.selectedCropsId[index], cropgridCalculator.selectedCropsImages[index]);
//                                                                                       },
//                                                                                       child: Container(
//                                                                                         height: MediaQuery.of(context).size.height * 0.075,
//                                                                                         width: MediaQuery.of(context).size.width * 0.25,
//                                                                                         margin: EdgeInsets.symmetric(horizontal: 5),
//                                                                                         // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//                                                                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(cropgridCalculator.selectedCropsImages[index] ?? ""))),
//                                                                                         child: Center(
//                                                                                           child: Row(
//                                                                                             children: [],
//                                                                                           ),
//                                                                                         ),
//                                                                                       ),
//                                                                                     ),
//                                                                                     Positioned(
//                                                                                       right: 0,
//                                                                                       top: 0,
//                                                                                       child: CircleAvatar(
//                                                                                         radius: 10,
//                                                                                         backgroundColor: Color(0xFFFF3B30),
//                                                                                         child: GestureDetector(
//                                                                                           onTap: () {
//                                                                                             cropgridCalculator.removeCrop(cropgridCalculator.selectedCropsName[index], cropgridCalculator.selectedCropsId[index], cropgridCalculator.selectedCropsImages[index]);
//                                                                                           },
//                                                                                           child: Icon(
//                                                                                             Icons.close,
//                                                                                             color: Colors.white,
//                                                                                             size: 18,
//                                                                                           ),
//                                                                                         ),
//                                                                                       ),
//                                                                                     ),
//                                                                                   ],
//                                                                                 ),
//                                                                                 Padding(
//                                                                                   padding: const EdgeInsets.only(top: 5.0),
//                                                                                   child: Text(
//                                                                                     cropgridCalculator.selectedCropsName[index].toString() ?? "",
//                                                                                     style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 10, color: AppColor.BROWN_TEXT),
//                                                                                   ),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           );
//                                                                         },
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 )),
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .only(
//                                                                 left: 15.0,
//                                                                 right: 15,
//                                                                 bottom: 20,
//                                                                 top: 10),
//                                                         child: Row(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             Text(
//                                                               "Select up to 3 crops you are interested in",
//                                                               style: GoogleFonts
//                                                                   .poppins(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 color: AppColor
//                                                                     .BROWN_TEXT,
//                                                               ),
//                                                             ),
//                                                             Obx(
//                                                               () => Text(
//                                                                 "${cropgridCalculator.selectedCropsId.length}/3",
//                                                                 style:
//                                                                     GoogleFonts
//                                                                         .poppins(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500,
//                                                                   color: AppColor
//                                                                       .GREEN_SUBTEXT,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Obx(() => Expanded(
//                                                             child: GridView
//                                                                 .builder(
//                                                               gridDelegate:
//                                                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                                                 crossAxisCount:
//                                                                     3,
//                                                                 crossAxisSpacing:
//                                                                     8.0,
//                                                                 mainAxisSpacing:
//                                                                     8.0,
//                                                                 childAspectRatio:
//                                                                     1.1,
//                                                               ),
//                                                               itemCount: cropgridCalculator
//                                                                       .farmerCropData
//                                                                       .value
//                                                                       .result
//                                                                       ?.where((crop) => !cropgridCalculator
//                                                                           .selectedCropsId
//                                                                           .contains(
//                                                                               crop.id))
//                                                                       .length ??
//                                                                   0,
//                                                               itemBuilder:
//                                                                   (context,
//                                                                       index) {
//                                                                 final crop = cropgridCalculator
//                                                                     .farmerCropData
//                                                                     .value
//                                                                     .result
//                                                                     ?.where((crop) => !cropgridCalculator
//                                                                         .selectedCropsId
//                                                                         .contains(
//                                                                             crop.id))
//                                                                     .toList()[index];

//                                                                 if (crop ==
//                                                                     null)
//                                                                   return SizedBox
//                                                                       .shrink();

//                                                                 return Column(
//                                                                   children: [
//                                                                     Container(
//                                                                       margin: EdgeInsets.only(
//                                                                           right:
//                                                                               10),
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           GestureDetector(
//                                                                             onTap:
//                                                                                 () {
//                                                                               cropgridCalculator.selectCrop(
//                                                                                 crop.name ?? "",
//                                                                                 crop.id!.toInt(),
//                                                                                 crop.image ?? "",
//                                                                               );
//                                                                             },
//                                                                             child:
//                                                                                 Container(
//                                                                               height: MediaQuery.of(context).size.height * 0.075,
//                                                                               width: MediaQuery.of(context).size.width * 0.25,
//                                                                               // margin: EdgeInsets.symmetric(
//                                                                               //     horizontal:
//                                                                               //         5),
//                                                                               // padding: EdgeInsets.symmetric(
//                                                                               //     vertical:
//                                                                               //         10,
//                                                                               //     horizontal:
//                                                                               //         5),
//                                                                               decoration: BoxDecoration(
//                                                                                 borderRadius: BorderRadius.circular(12),
//                                                                                 image: DecorationImage(image: NetworkImage(crop.image ?? ""), fit: BoxFit.cover),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Padding(
//                                                                             padding:
//                                                                                 const EdgeInsets.only(top: 5.0),
//                                                                             child:
//                                                                                 Text(
//                                                                               crop.name ?? "",
//                                                                               maxLines: 2,
//                                                                               textAlign: TextAlign.center,
//                                                                               style: GoogleFonts.poppins(
//                                                                                 fontWeight: FontWeight.w400,
//                                                                                 fontSize: 10,
//                                                                                 color: AppColor.BROWN_TEXT,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 );
//                                                               },
//                                                             ),
//                                                           )),
//                                                       Center(
//                                                         child: GestureDetector(
//                                                           onTap: () {
//                                                             // controller.marketDataList(
//                                                             //     stateController.state.value,
//                                                             //     districtController.district.value,
//                                                             //     marketController.market.value,
//                                                             //     cropController.crop.value);
//                                                             Get.back();
//                                                           },
//                                                           child: Container(
//                                                             margin: EdgeInsets
//                                                                 .symmetric(
//                                                                     vertical:
//                                                                         16,
//                                                                     horizontal:
//                                                                         25),
//                                                             padding: EdgeInsets
//                                                                 .symmetric(
//                                                                     vertical:
//                                                                         10,
//                                                                     horizontal:
//                                                                         10),
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           10),
//                                                               color: AppColor
//                                                                   .DARK_GREEN,
//                                                             ),
//                                                             child: Center(
//                                                               child: Text(
//                                                                 "Proceed",
//                                                                 style:
//                                                                     GoogleFonts
//                                                                         .poppins(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 16,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w600,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ));
//                                             },
//                                           );
//                                         },
//                                         child: Container(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 10, horizontal: 15),
//                                           margin: EdgeInsets.only(bottom: 15),
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             border: Border.all(
//                                                 color: AppColor.GREY_BORDER),
//                                           ),
//                                           child: Center(
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "Select Crop",
//                                                 ),
//                                                 Icon(
//                                                     Icons
//                                                         .keyboard_arrow_down_rounded,
//                                                     color: AppColor.BROWN_TEXT),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Obx(
//                                           () =>
//                                               cropgridCalculator
//                                                       .selectedCropsId.isEmpty
//                                                   ? Container()
//                                                   : Container(
//                                                       margin: EdgeInsets.only(
//                                                           top: 5,
//                                                           bottom: 10,
//                                                           left: 10,
//                                                           right: 10),
//                                                       height:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .height *
//                                                               0.12,
//                                                       width: double.infinity,
//                                                       child: ListView.builder(
//                                                         scrollDirection:
//                                                             Axis.horizontal,
//                                                         shrinkWrap: true,
//                                                         itemCount:
//                                                             cropgridCalculator
//                                                                     .selectedCropsId
//                                                                     .length ??
//                                                                 0,
//                                                         itemBuilder:
//                                                             (context, index) {
//                                                           return Container(
//                                                             margin:
//                                                                 EdgeInsets.only(
//                                                                     right: 10),
//                                                             child: Column(
//                                                               children: [
//                                                                 Stack(
//                                                                   children: [
//                                                                     Positioned(
//                                                                       right: 0,
//                                                                       top: 0,
//                                                                       child:
//                                                                           CircleAvatar(
//                                                                         radius:
//                                                                             10,
//                                                                         backgroundColor:
//                                                                             Color(0xFFFF3B30),
//                                                                         child:
//                                                                             Icon(
//                                                                           Icons
//                                                                               .close,
//                                                                           color:
//                                                                               Colors.white,
//                                                                           size:
//                                                                               18,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     GestureDetector(
//                                                                       onTap:
//                                                                           () {
//                                                                         print(
//                                                                             "ON TAP");
//                                                                         cropgridCalculator.removeCrop(
//                                                                             cropgridCalculator.selectedCropsName[index],
//                                                                             cropgridCalculator.selectedCropsId[index],
//                                                                             cropgridCalculator.selectedCropsImages[index]);
//                                                                       },
//                                                                       child:
//                                                                           DottedBorder(
//                                                                         borderType:
//                                                                             BorderType.RRect,
//                                                                         color: Color(
//                                                                             0xFFD6D6D6),
//                                                                         dashPattern: [
//                                                                           2,
//                                                                           2
//                                                                         ],
//                                                                         radius:
//                                                                             Radius.circular(12),
//                                                                         padding: EdgeInsets.symmetric(
//                                                                             vertical:
//                                                                                 8,
//                                                                             horizontal:
//                                                                                 10),
//                                                                         child:
//                                                                             Container(
//                                                                           height:
//                                                                               MediaQuery.of(context).size.height * 0.06,
//                                                                           width:
//                                                                               MediaQuery.of(context).size.height * 0.06,
//                                                                           margin:
//                                                                               EdgeInsets.symmetric(horizontal: 5),
//                                                                           padding: EdgeInsets.symmetric(
//                                                                               vertical: 10,
//                                                                               horizontal: 5),
//                                                                           decoration:
//                                                                               BoxDecoration(image: DecorationImage(image: NetworkImage(cropgridCalculator.selectedCropsImages[index] ?? ""))),
//                                                                           child:
//                                                                               Center(
//                                                                             child:
//                                                                                 Row(
//                                                                               children: [],
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                                 Padding(
//                                                                   padding:
//                                                                       const EdgeInsets
//                                                                           .only(
//                                                                           top:
//                                                                               5.0),
//                                                                   child: Text(
//                                                                     cropgridCalculator
//                                                                             .selectedCropsName[index]
//                                                                             .toString() ??
//                                                                         "",
//                                                                     style: GoogleFonts.poppins(
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w400,
//                                                                         fontSize:
//                                                                             10,
//                                                                         color: AppColor
//                                                                             .BROWN_TEXT),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           );
//                                                         },
//                                                       ),
//                                                     )),
//                                       // Obx(() {
//                                       //   return cropgridCalculator
//                                       //               .selectedCropsName.length !=
//                                       //           0
//                                       //       ? Container(
//                                       //           margin: EdgeInsets.symmetric(
//                                       //               horizontal: 10, vertical: 10),
//                                       //           height: 30,
//                                       //           width: double.infinity,
//                                       //           child: ListView.builder(
//                                       //             itemCount: cropgridCalculator
//                                       //                 .selectedCropsName.length,
//                                       //             scrollDirection: Axis.horizontal,
//                                       //             itemBuilder: (context, index) {
//                                       //               final cropName = cropController
//                                       //                   .selectedItems[index];
//                                       //               final cropId = cropController
//                                       //                   .selectedItemsId[index];
//                                       //               return Container(
//                                       //                 margin:
//                                       //                     EdgeInsets.only(right: 10),
//                                       //                 padding: EdgeInsets.symmetric(
//                                       //                     vertical: 5, horizontal: 10),
//                                       //                 decoration: BoxDecoration(
//                                       //                     border: Border.all(
//                                       //                         color: Colors.black12),
//                                       //                     borderRadius:
//                                       //                         BorderRadius.circular(
//                                       //                             15)),
//                                       //                 child: Row(
//                                       //                   children: [
//                                       //                     Text(
//                                       //                       "$cropName  ",
//                                       //                       style:
//                                       //                           TextStyle(fontSize: 13),
//                                       //                     ),
//                                       //                     GestureDetector(
//                                       //                       onTap: () {
//                                       //                         cropController
//                                       //                             .removeItem(cropName);
//                                       //                         cropController
//                                       //                             .removeItemId(cropId);
//                                       //                       },
//                                       //                       child: Icon(
//                                       //                         Icons.close,
//                                       //                         color: Color(0xFF61646B),
//                                       //                         size: 18,
//                                       //                       ),
//                                       //                     )
//                                       //                   ],
//                                       //                 ),
//                                       //               );
//                                       //             },
//                                       //           ),
//                                       //         )
//                                       //       : Container();
//                                       // }),
//                                       Container(
//                                         margin: EdgeInsets.only(
//                                             bottom: 20, top: 10),
//                                         height: 1,
//                                         width: double.infinity,
//                                         color: Color(0xFFE3E3E3),
//                                       ),
//                                       Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             "Land Size(Area)",
//                                             style: GoogleFonts.poppins(
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 13,
//                                             ),
//                                           ),
//                                           Obx(() {
//                                             return Container(
//                                               height: MediaQuery.of(context)
//                                                       .size
//                                                       .height *
//                                                   0.0367,
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 10),
//                                               decoration: BoxDecoration(
//                                                 color: Color(0xFF044D3A)
//                                                     .withOpacity(0.1),
//                                                 borderRadius:
//                                                     BorderRadius.circular(40),
//                                                 border: Border.all(
//                                                     color: AppColor.DARK_GREEN),
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   DropdownButton<String>(
//                                                     alignment: Alignment.center,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             20),
//                                                     padding: EdgeInsets.zero,
//                                                     underline: Container(),
//                                                     iconEnabledColor:
//                                                         Colors.transparent,
//                                                     value: cropController
//                                                         .selectedValue.value,
//                                                     items: cropController
//                                                         .dropdownItems
//                                                         .map((String item) {
//                                                       return DropdownMenuItem<
//                                                           String>(
//                                                         value: item,
//                                                         child: Text(item),
//                                                       );
//                                                     }).toList(),
//                                                     onChanged:
//                                                         (String? newValue) {
//                                                       cropController
//                                                           .updateSelectedValue(
//                                                               newValue);
//                                                     },
//                                                   ),
//                                                   Icon(
//                                                       Icons
//                                                           .keyboard_arrow_down_rounded,
//                                                       color:
//                                                           AppColor.BROWN_TEXT),
//                                                 ],
//                                               ),
//                                             );
//                                           })
//                                         ],
//                                       ),
//                                       Obx(
//                                         () => Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "${cropController.sliderValue.value.toStringAsFixed(2).toString()}  ",
//                                               style: GoogleFonts.poppins(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 18,
//                                               ),
//                                             ),
//                                             Text(
//                                               cropController.selectedValue
//                                                           .value ==
//                                                       null
//                                                   ? ""
//                                                   : cropController
//                                                       .selectedValue.value
//                                                       .toString(),
//                                               style: GoogleFonts.poppins(
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Obx(() {
//                                         // Define min and max values based on selected unit
//                                         double minValue = cropController
//                                                     .selectedValue.value ==
//                                                 "SQFT"
//                                             ? 100.0
//                                             : 1.0;
//                                         double maxValue = cropController
//                                                     .selectedValue.value ==
//                                                 "SQFT"
//                                             ? 10000.0
//                                             : 100.0;
//                                         double step = cropController
//                                                     .selectedValue.value ==
//                                                 "SQFT"
//                                             ? 100.0
//                                             : 0.5;

//                                         return Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Slider(
//                                               value: cropController
//                                                   .sliderValue.value,
//                                               min: minValue,
//                                               max: maxValue,
//                                               divisions: ((maxValue -
//                                                           minValue) /
//                                                       step)
//                                                   .round(), // Calculate divisions
//                                               label: cropController
//                                                   .sliderValue.value
//                                                   .toStringAsFixed(2),
//                                               onChanged: (double newValue) {
//                                                 cropController
//                                                     .updateSliderValue(
//                                                         newValue);
//                                               },
//                                             ),
//                                             Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "${minValue.toStringAsFixed(2)} ${cropController.selectedValue.value ?? ""}",
//                                                   style: GoogleFonts.poppins(
//                                                     fontWeight: FontWeight.w400,
//                                                     fontSize: 12,
//                                                     color: Color(0xFF9299B5),
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   "${maxValue.toStringAsFixed(2)} ${cropController.selectedValue.value ?? ""}",
//                                                   style: GoogleFonts.poppins(
//                                                     fontWeight: FontWeight.w400,
//                                                     fontSize: 12,
//                                                     color: Color(0xFF9299B5),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         );
//                                       }),
//                                       Divider(
//                                         height: 30,
//                                         color: Color(0xFFE3E3E3),
//                                       ),
//                                       GestureDetector(
//                                         onTap: () {
//                                           cropController.cropdetailsData();
//                                         },
//                                         child: Container(
//                                           margin: EdgeInsets.only(
//                                               top: 20, left: 10, right: 10),
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 14),
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                               color: AppColor.DARK_GREEN,
//                                             ),
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               "Calculate",
//                                               style: GoogleFonts.poppins(
//                                                 color: AppColor.DARK_GREEN,
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),

//                                 ///FERTILIZER CALCULATOR
//                                 // Container(
//                                 //   padding: EdgeInsets.symmetric(
//                                 //       vertical: 20, horizontal: 15),
//                                 //   margin: EdgeInsets.symmetric(vertical: 10),
//                                 //   width: double.infinity,
//                                 //   decoration: ShapeDecoration(
//                                 //     color: Color(0xFFFFFFF7),
//                                 //     shape: RoundedRectangleBorder(
//                                 //       borderRadius: BorderRadius.circular(10),
//                                 //     ),
//                                 //     shadows: [
//                                 //       BoxShadow(
//                                 //         color: Color(0x19000000),
//                                 //         blurRadius: 24,
//                                 //         offset: Offset(0, 2),
//                                 //         spreadRadius: 0,
//                                 //       )
//                                 //     ],
//                                 //   ),
//                                 //   child: Column(
//                                 //     crossAxisAlignment:
//                                 //         CrossAxisAlignment.start,
//                                 //     children: [
//                                 //       Text(
//                                 //         "Calculate Fertiliser Requirements ",
//                                 //         style: GoogleFonts.poppins(
//                                 //           fontWeight: FontWeight.w600,
//                                 //           fontSize: 16,
//                                 //         ),
//                                 //       ),
//                                 //       Container(
//                                 //         margin:
//                                 //             EdgeInsets.symmetric(vertical: 10),
//                                 //         child: Text(
//                                 //           "Select crops",
//                                 //           style: GoogleFonts.poppins(
//                                 //             fontWeight: FontWeight.w500,
//                                 //             fontSize: 13,
//                                 //           ),
//                                 //         ),
//                                 //       ),
//                                 //       GestureDetector(
//                                 //         onTap: () {
//                                 //           showModalBottomSheet(
//                                 //             context: context,
//                                 //             isScrollControlled: true,
//                                 //             builder: (context) {
//                                 //               return Container(
//                                 //                   height: MediaQuery.of(context)
//                                 //                           .size
//                                 //                           .height *
//                                 //                       0.7,
//                                 //                   child: Column(
//                                 //                     mainAxisSize:
//                                 //                         MainAxisSize.min,
//                                 //                     children: [
//                                 //                       Container(
//                                 //                         padding: EdgeInsets
//                                 //                             .symmetric(
//                                 //                                 horizontal: 12,
//                                 //                                 vertical: 15),
//                                 //                         margin: EdgeInsets.only(
//                                 //                             bottom: 20),
//                                 //                         decoration:
//                                 //                             BoxDecoration(
//                                 //                                 color: AppColor
//                                 //                                     .DARK_GREEN,
//                                 //                                 borderRadius:
//                                 //                                     BorderRadius
//                                 //                                         .only(
//                                 //                                   topLeft: Radius
//                                 //                                       .circular(
//                                 //                                           12),
//                                 //                                   topRight: Radius
//                                 //                                       .circular(
//                                 //                                           12),
//                                 //                                 )),
//                                 //                         child: Row(
//                                 //                           crossAxisAlignment:
//                                 //                               CrossAxisAlignment
//                                 //                                   .center,
//                                 //                           mainAxisAlignment:
//                                 //                               MainAxisAlignment
//                                 //                                   .spaceBetween,
//                                 //                           children: [
//                                 //                             Text(
//                                 //                               "Select Crops",
//                                 //                               style: GoogleFonts.poppins(
//                                 //                                   color: Colors
//                                 //                                       .white,
//                                 //                                   fontSize: 16,
//                                 //                                   fontWeight:
//                                 //                                       FontWeight
//                                 //                                           .w500),
//                                 //                             ),
//                                 //                             GestureDetector(
//                                 //                               onTap: () {
//                                 //                                 Get.back();
//                                 //                               },
//                                 //                               child:
//                                 //                                   CircleAvatar(
//                                 //                                 radius: 10,
//                                 //                                 backgroundColor:
//                                 //                                     Colors
//                                 //                                         .white,
//                                 //                                 child: Icon(
//                                 //                                   Icons.close,
//                                 //                                   color: AppColor
//                                 //                                       .DARK_GREEN,
//                                 //                                   size: 18,
//                                 //                                 ),
//                                 //                               ),
//                                 //                             ),
//                                 //                           ],
//                                 //                         ),
//                                 //                       ),
//                                 //                       Obx(() => Expanded(
//                                 //                             child: GridView
//                                 //                                 .builder(
//                                 //                               gridDelegate:
//                                 //                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 //                                 crossAxisCount:
//                                 //                                     3,
//                                 //                                 crossAxisSpacing:
//                                 //                                     8.0,
//                                 //                                 mainAxisSpacing:
//                                 //                                     8.0,
//                                 //                                 childAspectRatio:
//                                 //                                     1.1,
//                                 //                               ),
//                                 //                               itemCount: cropController
//                                 //                                       .farmerCropData
//                                 //                                       .value
//                                 //                                       .result
//                                 //                                       ?.length ??
//                                 //                                   0,
//                                 //                               itemBuilder:
//                                 //                                   (context,
//                                 //                                       index) {
//                                 //                                 int cropId = cropController
//                                 //                                         .farmerCropData
//                                 //                                         .value
//                                 //                                         .result?[
//                                 //                                             index]
//                                 //                                         .id
//                                 //                                         ?.toInt() ??
//                                 //                                     0;
//                                 //                                 String cropName = cropController
//                                 //                                         .farmerCropData
//                                 //                                         .value
//                                 //                                         .result?[
//                                 //                                             index]
//                                 //                                         .name
//                                 //                                         ?.toString() ??
//                                 //                                     "";
//                                 //                                 final crop =
//                                 //                                     cropController
//                                 //                                         .farmerCropData
//                                 //                                         .value
//                                 //                                         .result?[
//                                 //                                             index]
//                                 //                                         .image;
//                                 //                                 return Column(
//                                 //                                   children: [
//                                 //                                     Container(
//                                 //                                       margin: EdgeInsets.only(
//                                 //                                           right:
//                                 //                                               10),
//                                 //                                       child:
//                                 //                                           Column(
//                                 //                                         children: [
//                                 //                                           GestureDetector(
//                                 //                                             onTap:
//                                 //                                                 () {
//                                 //                                               cropController.selectedCropsId.value = cropId;
//                                 //                                               cropController.selectedCropsName.value = cropName;
//                                 //                                               cropFertilizer.cropfertilizer(cropId);
//                                 //                                               print("NEW CROP ID${cropController.selectedCropsId.value}");
//                                 //                                               print("NEW CROP NAME${cropController.selectedCropsName.value}");
//                                 //                                               Get.back();
//                                 //                                             },
//                                 //                                             child:
//                                 //                                                 Container(
//                                 //                                               height: MediaQuery.of(context).size.height * 0.075,
//                                 //                                               width: MediaQuery.of(context).size.width * 0.25,
//                                 //                                               decoration: BoxDecoration(
//                                 //                                                 borderRadius: BorderRadius.circular(15),
//                                 //                                                 image: DecorationImage(
//                                 //                                                   fit: BoxFit.cover,
//                                 //                                                   image: NetworkImage(crop ?? ""),
//                                 //                                                 ),
//                                 //                                               ),
//                                 //                                             ),
//                                 //                                           ),
//                                 //                                           Padding(
//                                 //                                             padding:
//                                 //                                                 const EdgeInsets.only(top: 5.0),
//                                 //                                             child:
//                                 //                                                 Text(
//                                 //                                               cropName ?? "",
//                                 //                                               maxLines: 2,
//                                 //                                               textAlign: TextAlign.center,
//                                 //                                               style: GoogleFonts.poppins(
//                                 //                                                 fontWeight: FontWeight.w400,
//                                 //                                                 fontSize: 10,
//                                 //                                                 color: AppColor.BROWN_TEXT,
//                                 //                                               ),
//                                 //                                             ),
//                                 //                                           ),
//                                 //                                         ],
//                                 //                                       ),
//                                 //                                     ),
//                                 //                                   ],
//                                 //                                 );
//                                 //                               },
//                                 //                             ),
//                                 //                           )),
//                                 //                     ],
//                                 //                   ));
//                                 //             },
//                                 //           );
//                                 //         },
//                                 //         child: Container(
//                                 //           padding: EdgeInsets.symmetric(
//                                 //               vertical: 10, horizontal: 15),
//                                 //           decoration: BoxDecoration(
//                                 //             borderRadius:
//                                 //                 BorderRadius.circular(10),
//                                 //             border: Border.all(
//                                 //                 color: AppColor.GREY_BORDER),
//                                 //           ),
//                                 //           child: Row(
//                                 //             crossAxisAlignment:
//                                 //                 CrossAxisAlignment.center,
//                                 //             mainAxisAlignment:
//                                 //                 MainAxisAlignment.spaceBetween,
//                                 //             children: [
//                                 //               Obx(
//                                 //                 () => Text(
//                                 //                   cropController
//                                 //                               .selectedCropsName
//                                 //                               .value ==
//                                 //                           ""
//                                 //                       ? "Search"
//                                 //                       : cropController
//                                 //                           .selectedCropsName
//                                 //                           .value,
//                                 //                   style: TextStyle(
//                                 //                     color: Color(0xCC61646B),
//                                 //                     fontSize: 12,
//                                 //                     fontFamily: 'Poppins',
//                                 //                     fontWeight: FontWeight.w500,
//                                 //                     height: 0,
//                                 //                   ),
//                                 //                 ),
//                                 //               ),
//                                 //               Icon(
//                                 //                   Icons
//                                 //                       .keyboard_arrow_down_rounded,
//                                 //                   color: AppColor.BROWN_TEXT),
//                                 //             ],
//                                 //           ),
//                                 //         ),
//                                 //       ),
//                                 //       Container(
//                                 //         margin: EdgeInsets.only(
//                                 //             bottom: 20, top: 10),
//                                 //         height: 1,
//                                 //         width: double.infinity,
//                                 //         color: Color(0xFFE3E3E3),
//                                 //       ),
//                                 //       Row(
//                                 //         crossAxisAlignment:
//                                 //             CrossAxisAlignment.center,
//                                 //         mainAxisAlignment:
//                                 //             MainAxisAlignment.spaceBetween,
//                                 //         children: [
//                                 //           Text(
//                                 //             "Land Size(Area)",
//                                 //             style: GoogleFonts.poppins(
//                                 //               fontWeight: FontWeight.w500,
//                                 //               fontSize: 13,
//                                 //             ),
//                                 //           ),
//                                 //           Obx(() {
//                                 //             return Container(
//                                 //               height: MediaQuery.of(context)
//                                 //                       .size
//                                 //                       .height *
//                                 //                   0.0367,
//                                 //               padding: EdgeInsets.symmetric(
//                                 //                   horizontal: 10),
//                                 //               decoration: BoxDecoration(
//                                 //                 color: Color(0xFF044D3A)
//                                 //                     .withOpacity(0.1),
//                                 //                 borderRadius:
//                                 //                     BorderRadius.circular(40),
//                                 //                 border: Border.all(
//                                 //                     color: AppColor.DARK_GREEN),
//                                 //               ),
//                                 //               child: Row(
//                                 //                 children: [
//                                 //                   DropdownButton<String>(
//                                 //                     alignment: Alignment.center,
//                                 //                     borderRadius:
//                                 //                         BorderRadius.circular(
//                                 //                             20),
//                                 //                     padding: EdgeInsets.zero,
//                                 //                     underline: Container(),
//                                 //                     iconEnabledColor:
//                                 //                         Colors.transparent,
//                                 //                     value: cropController
//                                 //                         .selectedValuefertilizer
//                                 //                         .value,
//                                 //                     items: cropController
//                                 //                         .dropdownItemsfertilizer
//                                 //                         .map((String item) {
//                                 //                       return DropdownMenuItem<
//                                 //                           String>(
//                                 //                         value: item,
//                                 //                         child: Text(item),
//                                 //                       );
//                                 //                     }).toList(),
//                                 //                     onChanged:
//                                 //                         (String? newValue) {
//                                 //                       cropController
//                                 //                           .updateSelectedValuefertilizer(
//                                 //                               newValue);
//                                 //                     },
//                                 //                   ),
//                                 //                   Icon(
//                                 //                       Icons
//                                 //                           .keyboard_arrow_down_rounded,
//                                 //                       color:
//                                 //                           AppColor.BROWN_TEXT),
//                                 //                 ],
//                                 //               ),
//                                 //             );
//                                 //           })
//                                 //         ],
//                                 //       ),
//                                 //       Obx(
//                                 //         () => Row(
//                                 //           crossAxisAlignment:
//                                 //               CrossAxisAlignment.center,
//                                 //           mainAxisAlignment:
//                                 //               MainAxisAlignment.start,
//                                 //           children: [
//                                 //             Text(
//                                 //               "${cropController.sliderValuefertilizer.value.toStringAsFixed(2).toString()}  ",
//                                 //               style: GoogleFonts.poppins(
//                                 //                 fontWeight: FontWeight.w600,
//                                 //                 fontSize: 18,
//                                 //               ),
//                                 //             ),
//                                 //             Text(
//                                 //               cropController
//                                 //                           .selectedValuefertilizer
//                                 //                           .value ==
//                                 //                       null
//                                 //                   ? ""
//                                 //                   : cropController
//                                 //                       .selectedValuefertilizer
//                                 //                       .value
//                                 //                       .toString(),
//                                 //               style: GoogleFonts.poppins(
//                                 //                 fontWeight: FontWeight.w500,
//                                 //                 fontSize: 12,
//                                 //               ),
//                                 //             ),
//                                 //           ],
//                                 //         ),
//                                 //       ),
//                                 //       Obx(() {
//                                 //         // Define min and max values based on the selected unit
//                                 //         double minValue = cropController
//                                 //                     .selectedValuefertilizer
//                                 //                     .value ==
//                                 //                 "SQFT"
//                                 //             ? 100.0
//                                 //             : 1.0;
//                                 //         double maxValue = cropController
//                                 //                     .selectedValuefertilizer
//                                 //                     .value ==
//                                 //                 "SQFT"
//                                 //             ? 10000000.0
//                                 //             : 100.0;
//                                 //         double step = cropController
//                                 //                     .selectedValuefertilizer
//                                 //                     .value ==
//                                 //                 "SQFT"
//                                 //             ? 100.0
//                                 //             : 0.5; // Step size for slider
//                                 //
//                                 //         return Column(
//                                 //           mainAxisAlignment:
//                                 //               MainAxisAlignment.center,
//                                 //           children: [
//                                 //             Slider(
//                                 //               value: cropController
//                                 //                   .sliderValuefertilizer.value,
//                                 //               min: minValue,
//                                 //               max: maxValue,
//                                 //               divisions: ((maxValue -
//                                 //                           minValue) /
//                                 //                       step)
//                                 //                   .round(), // Calculate divisions for slider steps
//                                 //               label: cropController
//                                 //                   .sliderValuefertilizer.value
//                                 //                   .toStringAsFixed(2),
//                                 //               onChanged: (double newValue) {
//                                 //                 cropController
//                                 //                     .updateSliderValuefertilizer(
//                                 //                         newValue); // Update value in the controller
//                                 //               },
//                                 //             ),
//                                 //             Row(
//                                 //               crossAxisAlignment:
//                                 //                   CrossAxisAlignment.start,
//                                 //               mainAxisAlignment:
//                                 //                   MainAxisAlignment
//                                 //                       .spaceBetween,
//                                 //               children: [
//                                 //                 Text(
//                                 //                   "${minValue.toStringAsFixed(2)} ${cropController.selectedValuefertilizer.value}",
//                                 //                   style: GoogleFonts.poppins(
//                                 //                     fontWeight: FontWeight.w400,
//                                 //                     fontSize: 12,
//                                 //                     color: Color(0xFF9299B5),
//                                 //                   ),
//                                 //                 ),
//                                 //                 Text(
//                                 //                   "${maxValue.toStringAsFixed(2)} ${cropController.selectedValuefertilizer.value}",
//                                 //                   style: GoogleFonts.poppins(
//                                 //                     fontWeight: FontWeight.w400,
//                                 //                     fontSize: 12,
//                                 //                     color: Color(0xFF9299B5),
//                                 //                   ),
//                                 //                 ),
//                                 //               ],
//                                 //             ),
//                                 //           ],
//                                 //         );
//                                 //       }),
//                                 //       Divider(
//                                 //         height: 30,
//                                 //         color: Color(0xFFE3E3E3),
//                                 //       ),
//                                 //       Padding(
//                                 //         padding: const EdgeInsets.symmetric(
//                                 //             vertical: 10.0),
//                                 //         child: Text(
//                                 //           "Nitrogen Fertiliser",
//                                 //           style: GoogleFonts.poppins(
//                                 //               fontWeight: FontWeight.w500,
//                                 //               fontSize: 13,
//                                 //               color: Color(0xFF272727)),
//                                 //         ),
//                                 //       ),
//                                 //       Container(
//                                 //           decoration: BoxDecoration(
//                                 //             borderRadius:
//                                 //                 BorderRadius.circular(10),
//                                 //             border: Border.all(
//                                 //                 color: AppColor.GREY_BORDER),
//                                 //           ),
//                                 //           child: Obx(
//                                 //             () => TextFormField(
//                                 //               onChanged: (value) {
//                                 //                 int? parsedValue =
//                                 //                     int.tryParse(value);
//                                 //                 cropFertilizer
//                                 //                     .cropData
//                                 //                     .value
//                                 //                     .result
//                                 //                     ?.nitrogen = parsedValue;
//                                 //                 if (parsedValue != null) {
//                                 //                   cropFertilizer.nitrogen
//                                 //                       .value = parsedValue;
//                                 //                 }
//                                 //               },
//                                 //               controller: TextEditingController(
//                                 //                   text: cropFertilizer.cropData
//                                 //                       .value.result?.nitrogen
//                                 //                       ?.toString()),
//                                 //               decoration: InputDecoration(
//                                 //                 contentPadding:
//                                 //                     EdgeInsets.symmetric(
//                                 //                         vertical: 10,
//                                 //                         horizontal: 10),
//                                 //                 border: InputBorder.none,
//                                 //                 hintText: "Nitrogen  ",
//                                 //                 hintStyle: TextStyle(
//                                 //                   color: Color(0xCC61646B),
//                                 //                   fontSize: 12,
//                                 //                   fontFamily: 'Poppins',
//                                 //                   fontWeight: FontWeight.w500,
//                                 //                   height: 0,
//                                 //                 ),
//                                 //               ),
//                                 //             ),
//                                 //           )),
//                                 //       Padding(
//                                 //         padding: const EdgeInsets.symmetric(
//                                 //             vertical: 10.0),
//                                 //         child: Text(
//                                 //           "Phosphorus Fertiliser",
//                                 //           style: GoogleFonts.poppins(
//                                 //               fontWeight: FontWeight.w500,
//                                 //               fontSize: 13,
//                                 //               color: Color(0xFF272727)),
//                                 //         ),
//                                 //       ),
//                                 //       Container(
//                                 //           decoration: BoxDecoration(
//                                 //             borderRadius:
//                                 //                 BorderRadius.circular(10),
//                                 //             border: Border.all(
//                                 //                 color: AppColor.GREY_BORDER),
//                                 //           ),
//                                 //           child: Obx(
//                                 //             () => TextFormField(
//                                 //               onChanged: (value) {
//                                 //                 int? parsedValue =
//                                 //                     int.tryParse(value);
//                                 //                 cropFertilizer
//                                 //                     .cropData
//                                 //                     .value
//                                 //                     .result
//                                 //                     ?.phosphorus = parsedValue;
//                                 //                 if (parsedValue != null) {
//                                 //                   cropFertilizer.phosphorus
//                                 //                       .value = parsedValue;
//                                 //                 }
//                                 //               },
//                                 //               controller: TextEditingController(
//                                 //                   text: cropFertilizer.cropData
//                                 //                       .value.result?.phosphorus
//                                 //                       ?.toString()),
//                                 //               decoration: InputDecoration(
//                                 //                 contentPadding:
//                                 //                     EdgeInsets.symmetric(
//                                 //                         vertical: 10,
//                                 //                         horizontal: 10),
//                                 //                 border: InputBorder.none,
//                                 //                 hintText: "Phosphorus  ",
//                                 //                 hintStyle: TextStyle(
//                                 //                   color: Color(0xCC61646B),
//                                 //                   fontSize: 12,
//                                 //                   fontFamily: 'Poppins',
//                                 //                   fontWeight: FontWeight.w500,
//                                 //                   height: 0,
//                                 //                 ),
//                                 //               ),
//                                 //             ),
//                                 //           )),
//                                 //       Padding(
//                                 //         padding: const EdgeInsets.symmetric(
//                                 //             vertical: 10.0),
//                                 //         child: Text(
//                                 //           "Potassium Fertiliser",
//                                 //           style: GoogleFonts.poppins(
//                                 //               fontWeight: FontWeight.w500,
//                                 //               fontSize: 13,
//                                 //               color: Color(0xFF272727)),
//                                 //         ),
//                                 //       ),
//                                 //       Container(
//                                 //           decoration: BoxDecoration(
//                                 //             borderRadius:
//                                 //                 BorderRadius.circular(10),
//                                 //             border: Border.all(
//                                 //                 color: AppColor.GREY_BORDER),
//                                 //           ),
//                                 //           child: Obx(
//                                 //             () => TextFormField(
//                                 //               onChanged: (value) {
//                                 //                 int? parsedValue =
//                                 //                     int.tryParse(value);
//                                 //                 cropFertilizer
//                                 //                     .cropData
//                                 //                     .value
//                                 //                     .result
//                                 //                     ?.potassium = parsedValue;
//                                 //                 if (parsedValue != null) {
//                                 //                   cropFertilizer.potassium
//                                 //                       .value = parsedValue;
//                                 //                 }
//                                 //               },
//                                 //               controller: TextEditingController(
//                                 //                   text: cropFertilizer.cropData
//                                 //                       .value.result?.potassium
//                                 //                       ?.toString()),
//                                 //               decoration: InputDecoration(
//                                 //                 contentPadding:
//                                 //                     EdgeInsets.symmetric(
//                                 //                         vertical: 10,
//                                 //                         horizontal: 10),
//                                 //                 border: InputBorder.none,
//                                 //                 hintText: "Potassium  ",
//                                 //                 hintStyle: TextStyle(
//                                 //                   color: Color(0xCC61646B),
//                                 //                   fontSize: 12,
//                                 //                   fontFamily: 'Poppins',
//                                 //                   fontWeight: FontWeight.w500,
//                                 //                   height: 0,
//                                 //                 ),
//                                 //               ),
//                                 //             ),
//                                 //           )),
//                                 //       GestureDetector(
//                                 //         onTap: () {
//                                 //           cropFertilizerCalculator.fertilizer(
//                                 //               cropController
//                                 //                   .sliderValuefertilizer.value
//                                 //                   .toString(),
//                                 //               cropController
//                                 //                   .selectedValuefertilizer.value
//                                 //                   .toString(),
//                                 //               cropFertilizer.nitrogen.value,
//                                 //               cropFertilizer.phosphorus.value,
//                                 //               cropFertilizer.potassium.value,
//                                 //               cropController
//                                 //                   .selectedCropsId.value);
//                                 //         },
//                                 //         child: Container(
//                                 //           margin: EdgeInsets.only(
//                                 //               top: 20, left: 10, right: 10),
//                                 //           padding: EdgeInsets.symmetric(
//                                 //               vertical: 14),
//                                 //           decoration: BoxDecoration(
//                                 //             border: Border.all(
//                                 //               color: AppColor.DARK_GREEN,
//                                 //             ),
//                                 //             borderRadius:
//                                 //                 BorderRadius.circular(10),
//                                 //           ),
//                                 //           child: Center(
//                                 //             child: Text(
//                                 //               "Calculate",
//                                 //               style: GoogleFonts.poppins(
//                                 //                 color: AppColor.DARK_GREEN,
//                                 //                 fontSize: 14,
//                                 //                 fontWeight: FontWeight.w500,
//                                 //               ),
//                                 //             ),
//                                 //           ),
//                                 //         ),
//                                 //       ),
//                                 //     ],
//                                 //   ),
//                                 // ),
//                               ],
//                             );
//                           } else {
//                             return Obx(() {
//                               if (controller.loading.value &&
//                                   controller.productData.value.result?.data
//                                           ?.length ==
//                                       0) {
//                                 return Center(
//                                     child: CircularProgressIndicator());
//                               } else if (controller.rxRequestStatus.value ==
//                                   Status.ERROR) {
//                                 return Text('Error fetching data');
//                               } else if (controller
//                                       .productData.value.result?.data?.length ==
//                                   0) {
//                                 return Center();
//                               } else {
//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           ' My Products (${controller.productData.value.result?.data?.length ?? 0})',
//                                           style: GoogleFonts.poppins(
//                                             color: Color(0xFF483C32),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     ListView.builder(
//                                         scrollDirection: Axis.vertical,
//                                         shrinkWrap: true,
//                                         physics: NeverScrollableScrollPhysics(),
//                                         itemCount: controller.productData.value
//                                                 .result?.data?.length ??
//                                             0,
//                                         itemBuilder: (context, products) {
//                                           return Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 0),
//                                             child: Column(
//                                               children: [
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     // Get.to(() => Particularproduct(
//                                                     //     productId: controller
//                                                     //             .productDataListNew[
//                                                     //                 products]
//                                                     //             .id ??
//                                                     //         0));
//                                                   },
//                                                   child: Container(
//                                                     padding:
//                                                         EdgeInsets.symmetric(
//                                                             vertical: 10,
//                                                             horizontal: 10),
//                                                     width: double.infinity,
//                                                     decoration: ShapeDecoration(
//                                                       color: Color(0xFFFFFFF7),
//                                                       shape:
//                                                           RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                       ),
//                                                       shadows: [
//                                                         BoxShadow(
//                                                           color:
//                                                               Color(0x19000000),
//                                                           blurRadius: 24,
//                                                           offset: Offset(0, 2),
//                                                           spreadRadius: 0,
//                                                         )
//                                                       ],
//                                                     ),
//                                                     margin:
//                                                         EdgeInsets.symmetric(
//                                                       vertical: 8,
//                                                     ),
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         controller
//                                                                     .productData
//                                                                     .value
//                                                                     .result
//                                                                     ?.data?[
//                                                                         products]
//                                                                     .image
//                                                                     ?.length !=
//                                                                 0
//                                                             ? Container(
//                                                                 height:
//                                                                     Get.height *
//                                                                         0.14,
//                                                                 child: ListView
//                                                                     .builder(
//                                                                         itemCount:
//                                                                             controller.productData.value.result?.data?[products].image?.length ??
//                                                                                 0,
//                                                                         scrollDirection:
//                                                                             Axis
//                                                                                 .horizontal,
//                                                                         itemBuilder:
//                                                                             (context,
//                                                                                 img) {
//                                                                           return Container(
//                                                                             margin:
//                                                                                 EdgeInsets.only(bottom: 10, right: 8),
//                                                                             height:
//                                                                                 Get.height * 0.14,
//                                                                             width:
//                                                                                 Get.width * 0.3,
//                                                                             decoration: BoxDecoration(
//                                                                                 color: Colors.black,
//                                                                                 borderRadius: BorderRadius.circular(10),
//                                                                                 image: DecorationImage(image: NetworkImage(controller.productData.value.result?.data?[products].image?[img].image ?? ""), fit: BoxFit.cover)),
//                                                                           );
//                                                                         }),
//                                                               )
//                                                             : Container(),
//                                                         Container(
//                                                           margin: EdgeInsets
//                                                               .symmetric(
//                                                                   vertical: 0,
//                                                                   horizontal:
//                                                                       0),
//                                                           child: Text(
//                                                             '${controller.productData.value.result?.data?[products].name ?? ""}',
//                                                             style: TextStyle(
//                                                               color: AppColor
//                                                                   .BROWN_TEXT,
//                                                               fontSize: 16,
//                                                               fontFamily:
//                                                                   'Poppins',
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                               height: 0,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           margin:
//                                                               EdgeInsets.only(
//                                                                   bottom: 5,
//                                                                   left: 0,
//                                                                   right: 10,
//                                                                   top: 5),
//                                                           child: Text(
//                                                             '${controller.productData.value.result?.data?[products].description ?? ""}',
//                                                             style: GoogleFonts
//                                                                 .poppins(
//                                                               color: Color(
//                                                                   0xFF61646B),
//                                                               fontSize: 10,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400,
//                                                               height: 0,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           child: Text(
//                                                             '${controller.productData.value.result?.data?[products].currency ?? ""} ${controller.productData.value.result?.data?[products].unitPrice}/${controller.productData.value.result?.data?[products].unitValue} ${controller.productData.value.result?.data?[products].unit}',
//                                                             style: GoogleFonts
//                                                                 .poppins(
//                                                               color: AppColor
//                                                                   .DARK_GREEN,
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                               height: 0,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         }),
//                                   ],
//                                 );
//                               }
//                             });
//                           }
//                         } else {
//                           return CircularProgressIndicator(); // Return a loading indicator while fetching user role
//                         }
//                       },
//                     ),
//                     SizedBox(
//                       height: 30,
//                     )

//                     // Obx((){})
//                   ],
//                 ),
//               ),
//             )));
//   }
// }
