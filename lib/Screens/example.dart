import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/crop_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CRRRRR extends StatefulWidget {
  const CRRRRR({super.key});

  @override
  State<CRRRRR> createState() => _CRRRRRState();
}

final controller = Get.put(CropController());

class _CRRRRRState extends State<CRRRRR> {
  final cropController = Get.put(CropController());
  @override
  Widget build(BuildContext context) {
    double radius1 = 79.5;

    double radius2 = 20.5;
    return DefaultTabController(
      length: 3,
      child: Scaffold(body: Obx(() {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          margin: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          decoration: ShapeDecoration(
            color: Color(0xFFFFFFF7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: [
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
              Text(
                "Calculate Crop Earning Yield",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Select crops(Upto 3)",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.GREY_BORDER),
                ),
                child: TextFormField(
                  controller: cropController.searchCrop.value,
                  onChanged: (query) {
                    cropController.cropListData(query);
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText: "Search  ",
                      hintStyle: TextStyle(
                        color: Color(0xCC61646B),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.keyboard_arrow_down_rounded,
                            color: AppColor.BROWN_TEXT),
                      ),
                      prefixIcon: InkWell(
                        // onTap: () async {
                        //   String userRole =
                        //       await landownerController.prefs
                        //           .getUserRole();
                        //   print("User Role: $userRole");
                        // },
                        child: Icon(Icons.search, color: AppColor.BROWN_TEXT),
                      )),
                ),
              ),
              Obx(() {
                return cropController.cropData.value.result?.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            cropController.cropData.value.result?.length ?? 0,
                        itemBuilder: (context, index) {
                          final cropName = cropController
                                  .cropData.value.result?[index].name ??
                              "";
                          int cropId =
                              cropController.cropData.value.result?[index].id ??
                                  0;
                          return ListTile(
                            title: Text(
                              cropName,
                              style: TextStyle(fontSize: 13),
                            ),
                            onTap: () {
                              cropController.addItem(cropName);
                              cropController.addItemId(cropId);
                            },
                          );
                        },
                      )
                    : Container();
              }),
              Obx(() {
                return cropController.selectedItems.length != 0
                    ? Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        height: 30,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: cropController.selectedItems.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final cropName =
                                cropController.selectedItems[index];
                            final cropId =
                                cropController.selectedItemsId[index];
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Text(
                                    "$cropName  ",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cropController.removeItem(cropName);
                                      cropController.removeItemId(cropId);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Color(0xFF61646B),
                                      size: 18,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Container();
              }),
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 10),
                height: 1,
                width: double.infinity,
                color: Color(0xFFE3E3E3),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Land Size(Area)",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  Obx(() {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.0367,
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      decoration: BoxDecoration(
                        color: Color(0xFF044D3A).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: AppColor.DARK_GREEN),
                      ),
                      child: DropdownButton<String>(
                        alignment: Alignment.center,
                        borderRadius: BorderRadius.circular(20),
                        padding: EdgeInsets.zero,
                        underline: Container(),
                        iconEnabledColor: Colors.transparent,
                        value: cropController.selectedValue.value,
                        hint: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '  Select area  ',
                              style: TextStyle(fontSize: 10),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColor.DARK_GREEN,
                            ),
                          ],
                        ),
                        items: cropController.dropdownItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          cropController.updateSelectedValue(newValue);
                        },
                      ),
                    );
                  })
                ],
              ),
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${cropController.sliderValue.value.toStringAsFixed(2).toString()}  ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      cropController.selectedValue.value == null
                          ? ""
                          : cropController.selectedValue.value.toString(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                double minValue =
                    cropController.selectedValue.value == "SQFT" ? 100.0 : 0.0;
                double maxValue = cropController.selectedValue.value == "SQFT"
                    ? 10000000.0
                    : 100.0;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Slider(
                      value: cropController.sliderValue.value,
                      min: minValue,
                      max: maxValue,
                      label:
                          cropController.sliderValue.value.toStringAsFixed(2),
                      onChanged: (double newValue) {
                        cropController.updateSliderValue(newValue);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${minValue}  ${cropController.selectedValue.value == null ? "" : cropController.selectedValue.value}  ",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF9299B5)),
                        ),
                        Text(
                          "${maxValue}  ${cropController.selectedValue.value == null ? "" : cropController.selectedValue.value}  ",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF9299B5)),
                        ),
                      ],
                    )
                  ],
                );
              }),
              Divider(
                height: 30,
                color: Color(0xFFE3E3E3),
              ),
              GestureDetector(
                onTap: () {
                  cropController.cropdetailsData();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.DARK_GREEN,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Calculate",
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
        );
      })),
    );
  }
}
