import 'package:farm_easy/Utils/Constants/color_constants.dart';
import 'package:farm_easy/Utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Utils/CustomWidgets/Res/CommonWidget/app_appbar.dart';
import 'package:farm_easy/Screens/MarketPrices/Controller/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CropListMarket extends StatefulWidget {
  const CropListMarket({super.key});

  @override
  State<CropListMarket> createState() => _CropListMarketState();
}

class _CropListMarketState extends State<CropListMarket> {
  final controller = Get.put(FilterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.08),
        child: CommonAppBar(
          title: "Crop Filter",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.GREY_BORDER),
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              child: TextFormField(
                controller: controller.cropController.value,
                onChanged: (value) {
                  controller.getCropList(controller
                      .cropController.value.text); // Call API on every change
                },
                decoration: InputDecoration(
                    hintText: "Enter Crop",
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    border: InputBorder.none),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Obx(() {
                return controller.loading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount:
                            controller.cropData.value.result?.length ?? 0,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              controller.cropId.value = controller
                                      .cropData.value.result?[index].id!
                                      .toInt() ??
                                  0;
                              controller.crop.value = controller
                                      .cropData.value.result?[index].name ??
                                  "";
                              // print("MARKET ${controller.district.value}");
                              // print("STATE ${controller.districtId.value}");
                              // print(
                              //     "EDUCATION ${controller.education.value}");
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(),
                              child: Text(controller
                                      .cropData.value.result?[index].name ??
                                  ""),
                            ),
                          );
                        });
              }),
            )
          ],
        ),
      ),
    );
  }
}
