import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Screens/Dashboard/controller/dashboard_controller.dart';
import 'package:farm_easy/Screens/Dashboard/view/dashboard.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Enquiries/Controller/enquiries_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Enquiries/View/enquiries.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/check_land_details_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/crop_suggestion_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/image_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/landpercentage_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/update_landDetails_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/View/info.dart';
import 'package:farm_easy/Screens/LandSection/MatchingAgriProvider/Controller/agri_controller.dart';
import 'package:farm_easy/Screens/LandSection/MatchingFarmer/Controller/matching_farmer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Constants/dimensions_constatnts.dart';

class LandDetails extends StatefulWidget {
  LandDetails({super.key, required this.id});
  int id;

  @override
  State<LandDetails> createState() => _LandDetailsState();
}

class _LandDetailsState extends State<LandDetails> {
  final enquiriesController = Get.put(EnquiriesController());
  final landDetailsController = Get.put(ChecklandDetailsController());
  final updateLandDetailsController = Get.put(UpdateLandDetailsController());
  final matchingfarmer = Get.put(MatchingFarmerController());
  final agriController = Get.put(AgriController());
  final imageController = Get.put(ImageController());
  final landPercentageController = Get.put(LandPercentageController());
  final cropSuggest = Get.put(CropSuggestionController());
  final controller = Get.put(LandInfoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getLandDetails();
    enquiriesController.enquiriesListData();
  }

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    controller.landId.value = widget.id;
    enquiriesController.landId.value = widget.id;
    landDetailsController.landId.value = widget.id;
    updateLandDetailsController.landId.value = widget.id;
    matchingfarmer.landId.value = widget.id;
    agriController.landId.value = widget.id;
    imageController.landId.value = widget.id;
    landPercentageController.landId.value = widget.id;
    cropSuggest.landId.value = widget.id;
    return WillPopScope(
      onWillPop: () async {
        Get.off(() => DashBoard());
        return false;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColor.BACKGROUND,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppDimension.h * 0.08),
            child: AppBar(
              backgroundColor: AppColor.DARK_GREEN,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(
                    top: isIOS ? 70 : 60, left: 10, right: 30, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Get.off(() => DashBoard());
                          final dashboardControllers =
                              Get.find<DashboardController>();
                          if (dashboardControllers != null) {
                            dashboardControllers.homecontroller.landListData();
                          }
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20,
                        )),
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
          body: Obx(() {
            return Column(
              children: [
                TabBar(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
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
                    tabs: [
                      Tab(
                        text: "     Info     ",
                      ),
                      Tab(
                        text:
                            "Enquiries (${enquiriesController.enquiriesData.value.result?.pageInfo?.totalObject ?? 0})",
                      )
                    ]),
                Expanded(
                    child: TabBarView(
                  children: [
                    InfoView(),
                    EnquiriesView(),
                  ],
                ))
              ],
            );
          }),
        ),
      ),
    );
  }
}
