import 'package:farm_easy/Utils/Constants/color_constants.dart';
import 'package:farm_easy/Utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Utils/CustomWidgets/Res/CommonWidget/app_appbar.dart';
import 'package:farm_easy/Screens/Partners/Controller/partner_services_controller.dart';
import 'package:farm_easy/Screens/Partners/View/partners.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PartnerServices extends StatefulWidget {
  const PartnerServices({super.key});

  @override
  State<PartnerServices> createState() => _PartnerServicesState();
}

class _PartnerServicesState extends State<PartnerServices> {
  final controller = Get.put(PartnerServicesController());
  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.08),
        child: CommonAppBar(
          title: 'Partners',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Select Service",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: AppColor.BROWN_TEXT,
                    fontSize: 20),
              ),
            ),
            Obx(() {
              return controller.loading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      width: double.infinity,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.9,
                        ),
                        itemCount:
                            (controller.servicesData.value.result?.length ??
                                    0) +
                                1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return InkWell(
                              onTap: () {
                                controller.selectedIndex.value = index;
                                Get.to(() => AllPartners(id: 0));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    height: MediaQuery.of(context).size.height *
                                        0.11,
                                    width: MediaQuery.of(context).size.height *
                                        0.14,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/allservices.jpg"),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      "All Services",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.BROWN_TEXT,
                                          fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            final serviceIndex = index - 1;
                            return InkWell(
                              onTap: () {
                                controller.selectedIndex.value = index;
                                Get.to(() => AllPartners(
                                    id: controller.servicesData.value
                                            .result?[serviceIndex].id!
                                            .toInt() ??
                                        0));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    height: MediaQuery.of(context).size.height *
                                        0.11,
                                    width: MediaQuery.of(context).size.height *
                                        0.13,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        image: DecorationImage(
                                            image: NetworkImage(controller
                                                    .servicesData
                                                    .value
                                                    .result?[serviceIndex]
                                                    .image ??
                                                ""),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  Text(
                                    controller.servicesData.value
                                            .result?[serviceIndex].name ??
                                        "",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.BROWN_TEXT,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    );
            })
          ],
        ),
      ),
    );
  }
}
