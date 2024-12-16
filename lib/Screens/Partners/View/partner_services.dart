import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
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
          isbackButton: false,
          title: 'Partners',
        ),
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.services();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.8,
                          ),
                          itemCount:
                              controller.servicesData.value.result?.length ?? 0,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                controller.selectedIndex.value = index;
                                Get.to(() => AllPartners(
                                    id: controller.servicesData.value
                                            .result?[index].id!
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
                                        image: DecorationImage(
                                            image: NetworkImage(controller
                                                    .servicesData
                                                    .value
                                                    .result?[index]
                                                    .image ??
                                                ""),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  Text(
                                    controller.servicesData.value.result?[index]
                                            .name ??
                                        "",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.BROWN_TEXT,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
