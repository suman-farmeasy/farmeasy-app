import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/FertilizerCalculator/Controller/fertilizer_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/crop_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/crop_fertilizer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Fertilizercalculatorview extends StatefulWidget {
  const Fertilizercalculatorview({super.key});

  @override
  State<Fertilizercalculatorview> createState() =>
      _FertilizercalculatorviewState();
}

class _FertilizercalculatorviewState extends State<Fertilizercalculatorview> {
  final cropController = Get.put(CropController());
  final cropFertilizer = Get.put(CropFertilizerController());
  final cropFertilizerCalculator = Get.put(FertilizerCalculatedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.08),
        child: CommonAppBar(
          isbackButton: true,
          title: 'Crop Fertilizer Calculator',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                    "Calculate Fertiliser Requirements ",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Select crops",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 15),
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                        color: AppColor.DARK_GREEN,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        )),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Select Crops",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.close,
                                              color: AppColor.DARK_GREEN,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(() => Expanded(
                                        child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 8.0,
                                            mainAxisSpacing: 8.0,
                                            childAspectRatio: 1.1,
                                          ),
                                          itemCount: cropController
                                                  .farmerCropData
                                                  .value
                                                  .result
                                                  ?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            int cropId = cropController
                                                    .farmerCropData
                                                    .value
                                                    .result?[index]
                                                    .id
                                                    ?.toInt() ??
                                                0;
                                            String cropName = cropController
                                                    .farmerCropData
                                                    .value
                                                    .result?[index]
                                                    .name
                                                    ?.toString() ??
                                                "";
                                            final crop = cropController
                                                .farmerCropData
                                                .value
                                                .result?[index]
                                                .image;
                                            return Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  child: Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          cropController
                                                              .selectedCropsId
                                                              .value = cropId;
                                                          cropController
                                                              .selectedCropsName
                                                              .value = cropName;

                                                          cropFertilizer
                                                              .cropfertilizer(
                                                                  cropId);
                                                          print(
                                                              "NEW CROP ID${cropController.selectedCropsId.value}");
                                                          print(
                                                              "NEW CROP NAME${cropController.selectedCropsName.value}");
                                                          Get.back();
                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.075,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  NetworkImage(
                                                                      crop ??
                                                                          ""),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                          cropName ?? "",
                                                          maxLines: 2,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 10,
                                                            color: AppColor
                                                                .BROWN_TEXT,
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
                                ],
                              ));
                        },
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.GREY_BORDER),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Text(
                              cropController.selectedCropsName.value == ""
                                  ? "Search"
                                  : cropController.selectedCropsName.value,
                              style: TextStyle(
                                color: Color(0xCC61646B),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down_rounded,
                              color: AppColor.BROWN_TEXT),
                        ],
                      ),
                    ),
                  ),
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
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF044D3A).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: AppColor.DARK_GREEN),
                          ),
                          child: Row(
                            children: [
                              DropdownButton<String>(
                                alignment: Alignment.center,
                                borderRadius: BorderRadius.circular(20),
                                padding: EdgeInsets.zero,
                                underline: Container(),
                                iconEnabledColor: Colors.transparent,
                                value: cropController
                                    .selectedValuefertilizer.value,
                                items: cropController.dropdownItemsfertilizer
                                    .map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  cropController
                                      .updateSelectedValuefertilizer(newValue);
                                },
                              ),
                              Icon(Icons.keyboard_arrow_down_rounded,
                                  color: AppColor.BROWN_TEXT),
                            ],
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
                          "${cropController.sliderValuefertilizer.value.toStringAsFixed(2).toString()}  ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          cropController.selectedValuefertilizer.value == null
                              ? ""
                              : cropController.selectedValuefertilizer.value
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
                    // Define min and max values based on the selected unit
                    double minValue =
                        cropController.selectedValuefertilizer.value == "SQFT"
                            ? 100.0
                            : 1.0;
                    double maxValue =
                        cropController.selectedValuefertilizer.value == "SQFT"
                            ? 10000000.0
                            : 100.0;
                    double step =
                        cropController.selectedValuefertilizer.value == "SQFT"
                            ? 100.0
                            : 0.5; // Step size for slider

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Slider(
                          value: cropController.sliderValuefertilizer.value,
                          min: minValue,
                          max: maxValue,
                          divisions: ((maxValue - minValue) / step)
                              .round(), // Calculate divisions for slider steps
                          label: cropController.sliderValuefertilizer.value
                              .toStringAsFixed(2),
                          onChanged: (double newValue) {
                            cropController.updateSliderValuefertilizer(
                                newValue); // Update value in the controller
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${minValue.toStringAsFixed(2)} ${cropController.selectedValuefertilizer.value}",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xFF9299B5),
                              ),
                            ),
                            Text(
                              "${maxValue.toStringAsFixed(2)} ${cropController.selectedValuefertilizer.value}",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xFF9299B5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                  Divider(
                    height: 30,
                    color: Color(0xFFE3E3E3),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Nitrogen Fertiliser",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xFF272727)),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.GREY_BORDER),
                      ),
                      child: Obx(
                        () => TextFormField(
                          onChanged: (value) {
                            int? parsedValue = int.tryParse(value);
                            cropFertilizer.cropData.value.result?.nitrogen =
                                parsedValue;
                            if (parsedValue != null) {
                              cropFertilizer.nitrogen.value = parsedValue;
                            }
                          },
                          controller: TextEditingController(
                              text: cropFertilizer
                                  .cropData.value.result?.nitrogen
                                  ?.toString()),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: InputBorder.none,
                            hintText: "Nitrogen  ",
                            hintStyle: TextStyle(
                              color: Color(0xCC61646B),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Phosphorus Fertiliser",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xFF272727)),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.GREY_BORDER),
                      ),
                      child: Obx(
                        () => TextFormField(
                          onChanged: (value) {
                            int? parsedValue = int.tryParse(value);
                            cropFertilizer.cropData.value.result?.phosphorus =
                                parsedValue;
                            if (parsedValue != null) {
                              cropFertilizer.phosphorus.value = parsedValue;
                            }
                          },
                          controller: TextEditingController(
                              text: cropFertilizer
                                  .cropData.value.result?.phosphorus
                                  ?.toString()),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: InputBorder.none,
                            hintText: "Phosphorus  ",
                            hintStyle: TextStyle(
                              color: Color(0xCC61646B),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Potassium Fertiliser",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xFF272727)),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.GREY_BORDER),
                      ),
                      child: Obx(
                        () => TextFormField(
                          onChanged: (value) {
                            int? parsedValue = int.tryParse(value);
                            cropFertilizer.cropData.value.result?.potassium =
                                parsedValue;
                            if (parsedValue != null) {
                              cropFertilizer.potassium.value = parsedValue;
                            }
                          },
                          controller: TextEditingController(
                              text: cropFertilizer
                                  .cropData.value.result?.potassium
                                  ?.toString()),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: InputBorder.none,
                            hintText: "Potassium  ",
                            hintStyle: TextStyle(
                              color: Color(0xCC61646B),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      cropFertilizerCalculator.fertilizer(
                          cropController.sliderValuefertilizer.value.toString(),
                          cropController.selectedValuefertilizer.value
                              .toString(),
                          cropFertilizer.nitrogen.value,
                          cropFertilizer.phosphorus.value,
                          cropFertilizer.potassium.value,
                          cropController.selectedCropsId.value);
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
            ),
          ],
        ),
      ),
    );
  }
}
