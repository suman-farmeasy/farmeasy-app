import 'package:farm_easy/Screens/SplashScreen/View/splash_screen.dart';
import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/AllEnquiries/View/all_enquiries.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
import 'package:farm_easy/Screens/ChatGpt/View/chat_gpt_start_Screen.dart';
import 'package:farm_easy/Screens/Crop%20Yield%20Calculator/View/crop_yield_calculator.dart';
import 'package:farm_easy/Screens/Feedback/View/feedback.dart';
import 'package:farm_easy/Screens/FertilizerCalculator/View/fertilizerCalculatorView.dart';
import 'package:farm_easy/Screens/LandSection/MyLands/View/my_land.dart';
import 'package:farm_easy/Screens/MarketPrices/View/market_prices.dart';
import 'package:farm_easy/Screens/MoreSection/Controller/controller.dart';
import 'package:farm_easy/Screens/MyProfile/View/my_profile.dart';
import 'package:farm_easy/Screens/ProductAndServices/View/product_view.dart';
import 'package:farm_easy/Screens/SOP/view.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../utils/Constants/dimensions_constatnts.dart';
import '../../../utils/localization/localization_controller.dart';
import '../../../widget/choose_language_widget.dart';

class MoreSection extends StatefulWidget {
  const MoreSection({super.key});

  @override
  State<MoreSection> createState() => _MoreSectionState();
}

class _MoreSectionState extends State<MoreSection> {
  final controller = Get.put(MoreController());
  final getProfile = Get.put(GetProfileController());
  final localeController = Get.put(LocaleController());
  var db = Hive.box('appData');
  String? selectedLanguage;

  void _showLanguageDialog(BuildContext context) async {
    selectedLanguage = await showDialog(
      context: context,
      builder: (context) {
        return const LanguageSelectionDialog();
      },
    );

    if (selectedLanguage != null) {
      setState(() {
        db.put('selectedLanguage', selectedLanguage);
        localeController.changeLocale(selectedLanguage == 'Hindi'
            ? 'hi'
            : selectedLanguage == 'English'
                ? 'en'
                : selectedLanguage == 'Punjabi'
                    ? 'pa'
                    : 'en');
        Get.to(SplashScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.08),
        child: CommonAppBar(
          isbackButton: false,
          title: 'More'.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: (getProfile.getProfileData.value.result?.image !=
                                  null &&
                              getProfile.getProfileData.value.result?.image !=
                                  "")
                          ? DecorationImage(
                              image: NetworkImage(
                                getProfile.getProfileData.value.result?.image ??
                                    "",
                              ),
                              fit: BoxFit.cover,
                            )
                          : null, // Remove the image if it's empty or null
                      color: AppColor.DARK_GREEN.withOpacity(0.2),
                    ),
                    child: (getProfile.getProfileData.value.result?.image ==
                                null ||
                            getProfile.getProfileData.value.result?.image == "")
                        ? Center(
                            child: Text(
                              getProfile
                                      .getProfileData.value.result?.fullName?[0]
                                      .toUpperCase() ??
                                  "", // Show the first letter if no image
                              style: GoogleFonts.poppins(
                                fontSize: 50,
                                color: AppColor.DARK_GREEN,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : Container(), // If an image is present, show nothing
                  ),
                )),

            FutureBuilder<String>(
              future: controller.prefs.getUserName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Center(
                    child: Text(
                      snapshot.data.toString(),
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF111719),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
              },
            ),
            FutureBuilder<String>(
              future: controller.prefs.getUserRole(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data == "Farmer") {
                    return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [AppColor.BOX_SHADOW],
                            color: const Color(0xFFFFFFF7)),
                        child: ListTile(
                          leading: Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: AppColor.YELLOW_GRADIENT,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Text(
                                    '${getProfile.getProfileData.value.result?.farmeasyRating ?? 0.0}  ',
                                    style: GoogleFonts.poppins(
                                      color: AppColor.BROWN_TEXT,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                  "assets/logos/star.svg",
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          title: Text(
                            'Farmeasy ${"Rating".tr}',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'This score is automatically calculated based on the information provided by you'
                                .tr,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF62666E),
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ));
                  } else {
                    return Container(); // Return an empty container if user role is not "Land Owner"
                  }
                } else {
                  return const CircularProgressIndicator(); // Return a loading indicator while fetching user role
                }
              },
            ),
            InkWell(
              onTap: () {
                Get.to(() => const MyProfileScreen());
              },
              child: ListTilesWidget(
                img: "assets/more/user.svg",
                title: "My Profile".tr,
              ),
            ),
            FutureBuilder<String>(
              future: controller.prefs.getUserRole(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data == "Land Owner") {
                    return InkWell(
                      onTap: () {
                        Get.to(() => const MyLands());
                      },
                      child: ListTilesWidget(
                        img: "assets/img/land.svg",
                        color: const Color(0xFF484848),
                        title: "My Lands".tr,
                      ),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data == "Agri Service Provider") {
                    return InkWell(
                      onTap: () {
                        Get.to(() => const ProductView());
                      },
                      child: ListTilesWidget(
                        img: "assets/img/categoryP.svg",
                        color: const Color(0xFF484848),
                        title: "Products/Services".tr,
                      ),
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return const CircularProgressIndicator(); // Return a loading indicator while fetching user role
                }
              },
            ),
            InkWell(
              onTap: () {
                _showLanguageDialog(context);
              },
              child: ListTilesWidget(
                img: "assets/logos/app_translate.svg",
                title:
                    "${'App Language'.tr} : ${db.get('selectedLanguage') ?? 'English'}",
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => AllEnquiries(
                      isbackButton: true,
                    ));
              },
              child: ListTilesWidget(
                img: "assets/logos/chat 1.svg",
                title: "My Conversation".tr,
              ),
            ),
            // ListTilesWidget(
            //   img: "assets/more/guarantee.svg",
            //   title: "Subscription",
            // ),
            InkWell(
              onTap: () {
                Get.to(() => const CropYieldCalculator());
              },
              child: ListTilesWidget(
                img: "assets/more/calculator.svg",
                title: "Crop Yield Calculator".tr,
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const Fertilizercalculatorview());
              },
              child: ListTilesWidget(
                img: "assets/more/calculator.svg",
                title: "Crop Fertilizer Calculator".tr,
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const ChatGptStartScreen());
              },
              child: ListTilesWidget(
                img: "assets/more/Vector.svg",
                title: "AI ${'Assistant'.tr}",
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const MarketPrices());
              },
              child: ListTilesWidget(
                img: "assets/more/price.svg",
                title: "Market Prices".tr,
              ),
            ),
            ListTilesWidget(
              img: "assets/more/customer.svg",
              title: "Contact Us".tr,
            ),
            ListTilesWidget(
              img: "assets/more/about.svg",
              title: "About Us".tr,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const FeedBackScreen());
              },
              child: ListTilesWidget(
                img: "assets/img/feedback.svg",
                title: "Feedback".tr,
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const SOP());
              },
              child: ListTilesWidget(
                img: "assets/more/sop.svg",
                title: "Standard Operating Procedure".tr,
              ),
            ),
            InkWell(
              onTap: () async {
                final shouldDelete = await Get.dialog<bool>(
                  AlertDialog(
                    title: Text(
                      'Confirm Delete'.tr,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: AppColor.BROWN_TEXT),
                    ),
                    content: Text(
                      'Are you sure you want to delete your account?'.tr,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: AppColor.BROWN_SUBTEXT),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(
                            result: false), // Dismiss dialog with false
                        child: Text(
                          'No'.tr,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppColor.DARK_GREEN),
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Get.back(result: true), // Confirm dialog with true
                        child: Text(
                          'Yes'.tr,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppColor.DARK_GREEN),
                        ),
                      ),
                    ],
                  ),
                );

                if (shouldDelete == true) {
                  controller.deleteAccount();
                }
              },
              child: ListTilesWidget(
                img: "assets/more/deactivate.svg",
                title: "Delete your account".tr,
                color: const Color(0xFF484848),
              ),
            ),
            InkWell(
              onTap: () async {
                await AppPreferences().logout();
              },
              child: ListTilesWidget(
                img: "assets/more/power.svg",
                title: "Logout".tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListTilesWidget extends StatefulWidget {
  ListTilesWidget(
      {super.key, required this.title, required this.img, this.color});
  String img = "";
  String title = "";
  Color? color;

  @override
  State<ListTilesWidget> createState() => _ListTilesWidgetState();
}

class _ListTilesWidgetState extends State<ListTilesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: SvgPicture.asset(
              widget.img,
              width: 25,
              color: widget.color,
            ),
            title: Text(
              widget.title,
              style: GoogleFonts.poppins(
                color: const Color(0xFF484848),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            ),
          ),
        ),
        Row(
          children: List.generate(
              450 ~/ 4,
              (index) => Expanded(
                    child: Container(
                      color: index % 2 == 0
                          ? Colors.transparent
                          : AppColor.GREY_BORDER,
                      height: 1,
                    ),
                  )),
        ),
      ],
    );
  }
}
