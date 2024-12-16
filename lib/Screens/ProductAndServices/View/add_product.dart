import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/Utils/Constants/color_constants.dart';
import 'package:farm_easy/Utils/CustomWidgets/Res/CommonWidget/app_appbar.dart';
import 'package:farm_easy/Screens/ProductAndServices/Controller/add_product_controller.dart';
import 'package:farm_easy/Screens/ProductAndServices/Controller/product_img_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final controller = Get.put(AddProductController());
  final imageController = Get.put(ProductImgController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.width * 0.16),
          child: CommonAppBar(
            title: 'Add Products/Services',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Obx(() {
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: imageController.photos.length < 3
                      ? imageController.photos.length + 1
                      : 3,
                  itemBuilder: (context, index) {
                    if (index < imageController.photos.length) {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                    File(imageController.photos[index])),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                imageController.deleteImage(index);
                              },
                              child: Container(
                                height: 28,
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 244, 67, 54),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (index == imageController.photos.length &&
                        index < 3) {
                      return Visibility(
                        visible: imageController.photos.length < 3,
                        child: InkWell(
                          onTap: () {
                            imageController.getImage(ImageSource.gallery);
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: AppColor.DARK_GREEN,
                            dashPattern: [9, 4],
                            radius: Radius.circular(12),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                color: Color(0x1E044D3A),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 25, bottom: 15),
                                        child: SvgPicture.asset(
                                          'assets/logos/gallary.svg',
                                          height: 24,
                                        ),
                                      ),
                                      Text(
                                        "Add",
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.DARK_GREEN,
                                        ),
                                      ),
                                      Text(
                                        "Photos",
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF73817B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }),
              SizedBox(
                height: 25,
              ),
              Container(
                height: Get.height * 0.065,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.GREY_BORDER),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: controller.productName.value,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    border: InputBorder.none,
                    hintText: "Product name",
                    hintStyle: GoogleFonts.poppins(
                      color: Color(0xFF757575),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: Get.height * 0.17,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.GREY_BORDER),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: controller.descriptionController.value,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    border: InputBorder.none,
                    hintText: "Description..",
                    hintStyle: GoogleFonts.poppins(
                      color: Color(0xFF757575),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 15),
                                    margin: EdgeInsets.only(bottom: 0),
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
                                  Container(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: ListView.builder(
                                        itemCount:
                                            controller.currencyList.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                controller.currency.value =
                                                    controller
                                                        .currencyList[index];
                                                controller.currencySym.value =
                                                    controller
                                                        .currencySymbol[index];
                                                print(
                                                    "Selected Currency Symbol: ${controller.currencySym.value}");
                                              });
                                              Get.back();
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0),
                                                  child: Text(
                                                    controller
                                                        .currencyList[index],
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColor.BROWN_TEXT,
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ));
                        },
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      width: MediaQuery.of(context).size.width * 0.46,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: AppColor.GREY_BORDER)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              controller.currency.value == ""
                                  ? "Select Currency  "
                                  : "  ${controller.currency.value}  ",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF757575CC)),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF757575CC))
                        ],
                      ),
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      width: MediaQuery.of(context).size.width * 0.46,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: AppColor.GREY_BORDER)),
                      child: TextFormField(
                        controller: controller.unitPrice.value,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: AppColor.BROWN_TEXT),
                        keyboardType: TextInputType.number,
                        // controller:

                        decoration: InputDecoration(
                          // contentPadding: EdgeInsets.only(top: 12),
                          hintText: "Unit Price ",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF757575CC)),
                          // suffixIcon: Icon(Icons.keyboard_arrow_down_rounded,
                          //     color: Color(0xFF757575CC)),
                          border: InputBorder.none,
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter a phone number';
                        //   }
                        //   if (!value.startsWith(controller.countryCode.value)) {
                        //     return 'Phone number must start with the country code';
                        //   }
                        //   return null;
                        // },
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 15),
                                      margin: EdgeInsets.only(bottom: 0),
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
                                    Container(
                                      child: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: ListView.builder(
                                              itemCount:
                                                  controller.unitsList.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      controller.unit.value =
                                                          controller
                                                              .unitsList[index];
                                                      print(
                                                          "${controller.unit.value}");
                                                    });
                                                    Get.back();
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 15.0),
                                                        child: Text(
                                                          controller
                                                              .unitsList[index],
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColor
                                                                      .BROWN_TEXT),
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 20,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })),
                                    )
                                  ],
                                ));
                          },
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        width: MediaQuery.of(context).size.width * 0.46,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: AppColor.GREY_BORDER)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.unit.value == ""
                                  ? "Select Unit  "
                                  : "  ${controller.unit.value}  ",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF757575CC)),
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded,
                                color: Color(0xFF757575CC))
                          ],
                        ),
                      ),
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        width: MediaQuery.of(context).size.width * 0.46,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: AppColor.GREY_BORDER)),
                        child: TextFormField(
                          controller: controller.unitValue.value,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: AppColor.BROWN_TEXT),
                          keyboardType: TextInputType.number,
                          // controller:

                          decoration: InputDecoration(
                            hintText: "Unit value ",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF757575CC)),
                            // suffixIcon: Icon(Icons.keyboard_arrow_down_rounded,
                            //     color: Color(0xFF757575CC)),
                            border: InputBorder.none,
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter a phone number';
                          //   }
                          //   if (!value.startsWith(controller.countryCode.value)) {
                          //     return 'Phone number must start with the country code';
                          //   }
                          //   return null;
                          // },
                        )),
                  ],
                ),
              ),
              Text(
                " Please enter per unit price of your service/product",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: AppColor.BROWN_TEXT,
                ),
              ),
            ]),
          ),
        ),
        bottomNavigationBar: Obx(() {
          return InkWell(
            onTap: () {
              controller.productUpload();
            },
            child: controller.loading.value
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    height: Get.height * 0.06,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.DARK_GREEN),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    height: Get.height * 0.06,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.DARK_GREEN),
                    child: Center(
                      child: Text(
                        'Add Product/Service',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
