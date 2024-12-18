import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/string_constant.dart';
import 'package:farm_easy/Screens/AllEnquiries/View/all_enquiries.dart';
import 'package:farm_easy/Screens/Dashboard/controller/dashboard_controller.dart';
import 'package:farm_easy/Screens/Directory/View/directory_screen.dart';
import 'package:farm_easy/Screens/HomeScreen/View/home_screen.dart';
import 'package:farm_easy/Screens/LandSection/MyLands/View/my_land.dart';
import 'package:farm_easy/Screens/MoreSection/View/more_section.dart';
import 'package:farm_easy/Screens/Partners/View/partner_services.dart';
import 'package:farm_easy/Screens/Threads/View/threads.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoard extends StatelessWidget {
  // final int initialIndex;
  // DashBoard({this.initialIndex = 0});
  final controller = Get.put(DashboardController());
  final prefs = AppPreferences();
  final List<Widget> contentWidgets = [
    const HomeScreen(),
    AllEnquiries(),
    const Threads(),
    const MyLands(),
    const DirectoryScreen(),
    const MoreSection(),
    const PartnerServices()
  ];

  DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.selectedIndex.value = initialIndex;
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedIndex.value == 0) {
          return true;
        } else {
          controller.selectedIndex.value = 0;
          return false;
        }
      },
      child: Scaffold(
        body: Obx(() => IndexedStack(
              index: controller.selectedIndex.value,
              children: contentWidgets,
            )),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.096,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            color: Color(0xFFF9F9DF),
            border: Border(
              left: BorderSide(color: Color(0xFFE3E3E3)),
              top: BorderSide(width: 1, color: Color(0xFFE3E3E3)),
              right: BorderSide(color: Color(0xFFE3E3E3)),
              bottom: BorderSide(color: Color(0xFFE3E3E3)),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 24,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildNavItem(0, 'assets/logos/home.svg', 'Home'.tr),
              FutureBuilder<String>(
                future: prefs.getUserRole(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (snapshot.data == StringConstatnt.LANDOWNER) {
                      return buildNavItem(
                          6, 'assets/logos/land.svg', 'Partners'.tr);
                    } else if (snapshot.data == StringConstatnt.FARMER) {
                      return buildNavItem(
                          6, 'assets/logos/chat 1.svg', 'Partners'.tr);
                    } else if (snapshot.data == StringConstatnt.AGRI_PROVIDER) {
                      return buildNavItem(
                          1, 'assets/logos/chat 1.svg', 'Enquiry'.tr);
                    } else {
                      return Container();
                    }
                    //snapshot.data=="${StringConstatnt.LANDOWNER}"? buildNavItem(3, 'assets/logos/land.svg', 'My Land'): buildNavItem(4, 'assets/logos/contact.svg', 'Directory');
                  }
                },
              ),
              buildNavItem(2, 'assets/logos/Image.svg', 'Community'.tr),
              FutureBuilder<String>(
                future: prefs.getUserRole(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (snapshot.data == StringConstatnt.LANDOWNER) {
                      return buildNavItem(
                          4, 'assets/logos/contact.svg', 'Directory'.tr);
                    } else if (snapshot.data == StringConstatnt.FARMER) {
                      return buildNavItem(
                          4, 'assets/logos/contact.svg', 'Directory'.tr);
                    } else if (snapshot.data == StringConstatnt.AGRI_PROVIDER) {
                      return buildNavItem(
                          4, 'assets/logos/contact.svg', 'Directory'.tr);
                    } else {
                      return Container();
                    }
                    //snapshot.data=="${StringConstatnt.LANDOWNER}"? buildNavItem(3, 'assets/logos/land.svg', 'My Land'): buildNavItem(4, 'assets/logos/contact.svg', 'Directory');
                  }
                },
              ),
              buildNavItem(5, 'assets/logos/application.svg', 'More'.tr),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(int index, String iconPath, String label) {
    return Obx(() => InkWell(
          onTap: () {
            controller.selectedIndex.value = index;
          },
          child: Container(
            height: Get.height * 0.088,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: ShapeDecoration(
              color: controller.selectedIndex.value == index
                  ? const Color(0x14044D3A)
                  : const Color(0xFFF9F9DF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  iconPath,
                  height: Get.height * 0.026,
                  color: controller.selectedIndex.value == index
                      ? AppColor.DARK_GREEN
                      : Colors.black,
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    fontWeight: controller.selectedIndex.value == index
                        ? FontWeight.w600
                        : FontWeight.w500,
                    color: controller.selectedIndex.value == index
                        ? AppColor.DARK_GREEN
                        : const Color(0xFF4F4F4F),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
