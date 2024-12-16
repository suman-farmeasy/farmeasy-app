import 'package:farm_easy/Utils/Constants/color_constants.dart';
import 'package:farm_easy/Utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Utils/CustomWidgets/Res/CommonWidget/app_appbar.dart';
import 'package:farm_easy/Screens/FertilizerCalculator/Controller/fertilizer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FertilizerCalculator extends StatefulWidget {
  const FertilizerCalculator({super.key});

  @override
  State<FertilizerCalculator> createState() => _FertilizerCalculatorState();
}

class _FertilizerCalculatorState extends State<FertilizerCalculator> {
  final controller = Get.put(FertilizerCalculatedController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.08),
        child: CommonAppBar(
          title: '  Fertiliser Calculator',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recommended amount of fertilizer ",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF333333)),
              ),
              Text(
                "Refer below recommended fertilizer combination for one season",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    color: Color(0xFF333333)),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                margin: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFEE),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFFE3E3E3)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 24,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        "Combination 1 - ${controller.cropData.value.result?.fertilizerRequirement?.sspRequirement == 0.0 ? "DAP" : "SSP"}/MOP/Urea ",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF333333)),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Obx(
                          () => Text(
                            controller
                                        .cropData
                                        .value
                                        .result
                                        ?.fertilizerRequirement
                                        ?.sspRequirement ==
                                    0.0
                                ? "DAP"
                                : "SSP",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xFF272727)),
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.GREY_BORDER),
                      ),
                      child: Center(
                          child: Obx(
                        () => Text(
                          "${controller.cropData.value.result?.fertilizerRequirement?.dap?.phosphorusRequirement ?? ""} Kg",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF272727)),
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "MOP",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Color(0xFF272727)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.GREY_BORDER),
                      ),
                      child: Center(
                          child: Obx(
                        () => Text(
                          "${controller.cropData.value.result?.fertilizerRequirement?.mopRequirement ?? ""} Kg",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF272727)),
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Urea",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Color(0xFF272727)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.GREY_BORDER),
                      ),
                      child: Center(
                          child: Obx(
                        () => Text(
                          "${controller.cropData.value.result?.fertilizerRequirement?.ureaRequirement ?? ""} Kg",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF272727)),
                        ),
                      )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
