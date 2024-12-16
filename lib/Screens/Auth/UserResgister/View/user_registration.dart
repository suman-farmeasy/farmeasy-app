import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/utils/Constants/string_constant.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Controller/partner_services_list.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Controller/select_corp.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Controller/user_controller.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;

import '../../../../API/ApiUrls/api_urls.dart';

class UserRegistration extends StatefulWidget {
  UserRegistration({super.key, required this.userType});
  String userType;
  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final controller = Get.put(UserController());
  final serviceController = Get.put(PartnerServicesList());
  final cropcontroller = Get.put(FarmerCrops());
  @override
  Widget build(BuildContext context) {
    controller.userType.value = widget.userType;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppDimension.h * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      CupertinoIcons.back,
                      color: AppColor.BROWN_TEXT,
                    )),
                SvgPicture.asset(
                  ImageConstants.IMG_TEXT,
                  height: AppDimension.h * 0.05,
                  width: AppDimension.w * 0.7,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                )
              ],
            ),
            SizedBox(
              height: AppDimension.h * 0.04,
            ),
            Center(child: StringConstatnt.REGISTER_TEXT),
            SizedBox(
              height: AppDimension.h * 0.04,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: ShapeDecoration(
                color: Color(0xFFFFFFF7),
                shape: RoundedRectangleBorder(
                  // side: BorderSide(color: Color(0xFF483C32)),
                  borderRadius: BorderRadius.circular(20),
                ),
                shadows: [AppColor.BOX_SHADOW],
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(),
                        padding: EdgeInsets.symmetric(vertical: 3),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                color: AppColor.GREY_BORDER, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          focusNode: controller.focusNodeName,
                          controller: controller.nameController.value,
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 12),
                            hintText: "Enter Full Name ",
                            hintStyle: GoogleFonts.poppins(
                              color: Color(0xFF757575),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: SvgPicture.asset(
                                "assets/logos/profile_img.svg",
                                height: 20,
                                width: 20,
                              ),
                            ),
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
                    Container(
                      child: Text(
                          ' Please make sure it matches the name on your Govt. ID',
                          style: GoogleFonts.poppins(
                            color: AppColor.BROWN_SUBTEXT,
                            fontSize: 8,
                            fontStyle: FontStyle.italic,
                            height: 2,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 0),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: AppColor.GREY_BORDER),
                            borderRadius: BorderRadius.circular(5)),
                        child: GooglePlaceAutoCompleteTextField(
                          textEditingController:
                              controller.locationController.value,
                          googleAPIKey: StringConstatnt.GOOGLE_PLACES_API,
                          focusNode: controller.focusNode,
                          boxDecoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent)),
                          inputDecoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.h),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: SvgPicture.asset(
                                "assets/logos/house.svg",
                              ),
                            ),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.locationController.value.clear();
                                  print(
                                      "${controller.locationController.value.text}");
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.close,
                                )),
                            hintText: "Search your location",
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.poppins(
                              color: Color(0xFF757575),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          debounceTime: 400,
                          isLatLngRequired: true,
                          getPlaceDetailWithLatLng:
                              (Prediction prediction) async {
                            controller.selectedLatitude =
                                double.parse(prediction.lat!);
                            controller.selectedLongitude =
                                double.parse(prediction.lng!);
                            await controller
                                .fetchPlaceDetails(prediction.placeId!);
                            // print("#####################${selectedLatitude}");
                            // print("#####################${selectedLongitude}");
                          },
                          itemClick: (Prediction prediction) async {
                            setState(() {});
                            String location = prediction.description ?? "";
                            controller.locationController.value.text = location;
                            print('NEW LOCATION ${location.length}');
                            controller.fetchPlaceDetails(prediction.placeId!);
                            String url = ApiUrls.ADD_SERVICABLE_AREA +
                                '?city=${controller.cityValue.value}&state=${controller.stateValue.value}&country=${controller.countryValue.value}';
                            try {
                              var response = await http.get(Uri.parse(url));

                              if (response.statusCode == 200) {
                                await controller.servicesArea(url);
                                print(
                                    "Serviceable area data: ${response.body}");
                              } else {
                                // Handle error response
                                print("Failed to fetch serviceable area data");
                              }
                            } catch (e) {
                              print("Error: $e");
                            }
                            controller.locationController.value.selection =
                                TextSelection.fromPosition(
                              TextPosition(offset: location.length),
                            );

                            if (location.isNotEmpty) {}
                          },
                          seperatedBuilder: Divider(),
                          itemBuilder: (context, index, Prediction prediction) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: AppColor.DARK_GREEN,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                      child: Text(
                                          "${prediction.description ?? ""}"))
                                ],
                              ),
                            );
                          },
                          isCrossBtnShown: false,
                        )),
                    Container(
                      margin: EdgeInsets.only(bottom: 0),
                      child: Text(' ',
                          style: GoogleFonts.poppins(
                            color: AppColor.BROWN_SUBTEXT,
                            fontSize: 8,
                            fontStyle: FontStyle.italic,
                            height: 2,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    Obx(() {
                      if (controller.userType == StringConstatnt.LANDOWNER) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(' What defines you best?',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                  color: AppColor.BROWN_TEXT,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.14,
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Container(
                                height: Get.height * 0.12,
                                child: ListView.builder(
                                    itemCount: controller.title.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          if (controller.select!.value ==
                                              index) {
                                            controller.select!.value = -1;
                                            controller.userProfieType.value =
                                                controller.select!.value
                                                    .toString();
                                          } else {
                                            controller.select!.value = index;
                                            controller.userProfieType.value =
                                                controller.title[index];
                                          }
                                          print(
                                              "=====================================${controller.userProfieType.value}===========================");
                                        },
                                        child: Obx(() {
                                          return Stack(
                                            children: [
                                              Center(
                                                child: AnimatedContainer(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  width: Get.width * 0.36,
                                                  decoration: ShapeDecoration(
                                                    gradient: controller
                                                                .select ==
                                                            index
                                                        ? AppColor
                                                            .PRIMARY_GRADIENT
                                                        : AppColor
                                                            .WHITE_GRADIENT,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xFFE3E3E3)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    shadows: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x14000000),
                                                        blurRadius: 12,
                                                        offset: Offset(0, 0),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                  duration:
                                                      Duration(microseconds: 2),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        controller.title[index],
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .DARK_GREEN,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0,
                                                        ),
                                                      ),
                                                      Text(
                                                        controller
                                                            .subtitle[index],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColor
                                                              .GREEN_SUBTEXT,
                                                          fontSize: 9,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  top: Get.height * 0.09,
                                                  left: Get.width * 0.3,
                                                  child: Icon(
                                                    Icons.task_alt_outlined,
                                                    size: 18,
                                                    color: controller.select ==
                                                            index
                                                        ? AppColor.DARK_GREEN
                                                        : Colors.transparent,
                                                  ))
                                            ],
                                          );
                                        }),
                                      );
                                    }),
                              ),
                            ),
                            controller.select!.value == -1 ||
                                    controller.locationController.value.text ==
                                        ""
                                ? Container(
                                    margin: EdgeInsets.only(top: 40),
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0x19044D3A),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Proceed",
                                        style: GoogleFonts.poppins(
                                          color: Color(0xFFA0A6A3),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      controller.landowner();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 40),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.DARK_GREEN,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Proceed",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        );
                      } else if (controller.userType ==
                          StringConstatnt.AGRI_PROVIDER) {
                        return Column(
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
                                            MediaQuery.of(context).size.height *
                                                0.7,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 15),
                                              margin:
                                                  EdgeInsets.only(bottom: 0),
                                              decoration: BoxDecoration(
                                                  color: AppColor.DARK_GREEN,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                    topRight:
                                                        Radius.circular(12),
                                                  )),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "serviceable area ",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(
                                                        Icons.close,
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.6,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                child: ListView.builder(
                                                  itemCount: controller
                                                          .serviceData
                                                          .value
                                                          .result
                                                          ?.length ??
                                                      0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        controller
                                                            .servicableAreaName
                                                            .value = controller
                                                                .serviceData
                                                                .value
                                                                .result?[index]
                                                                .name ??
                                                            "";
                                                        controller
                                                            .servicableAreaId
                                                            .value = controller
                                                                .serviceData
                                                                .value
                                                                .result?[index]
                                                                .id ??
                                                            0;
                                                        // setState(() {
                                                        //   controller.currency
                                                        //       .value = controller
                                                        //           .currencyList[
                                                        //       index];
                                                        //   controller.currencySym
                                                        //       .value = controller
                                                        //           .currencySymbol[
                                                        //       index];
                                                        //   print(
                                                        //       "Selected Currency Symbol: ${controller.currencySym.value}");
                                                        // });
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
                                                                      .serviceData
                                                                      .value
                                                                      .result?[
                                                                          index]
                                                                      .name ??
                                                                  "",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColor
                                                                    .BROWN_TEXT,
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
                                  margin: EdgeInsets.only(bottom: 10),
                                  height: AppDimension.h * 0.07,
                                  width: AppDimension.w * 0.85,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColor.GREY_BORDER)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SvgPicture.asset(
                                              "assets/img/servicearea.svg"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Obx(() {
                                            return controller.servicableAreaName
                                                        .value ==
                                                    ""
                                                ? Text(
                                                    'Select Serviceable Area',
                                                    style: GoogleFonts.poppins(
                                                      color: Color(0xFF757575),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  )
                                                : Text(
                                                    controller
                                                        .servicableAreaName
                                                        .value,
                                                    style: GoogleFonts.poppins(
                                                      color: Color(0xFF757575),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  );
                                          }),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Color(0xFF757575),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Select Services(s) ',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF272727),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '(5 Max)',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF61646B),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '*',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFFEB5757),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ',
                                    style: TextStyle(
                                      color: Color(0xFF272727),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Obx(() {
                              if (serviceController.loading.value) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: AppColor.DARK_GREEN,
                                ));
                              } else if (serviceController
                                      .rxRequestStatus.value ==
                                  Status.SUCCESS) {
                                return Wrap(
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: List.generate(
                                    serviceController.servicesData.value.result
                                            ?.length ??
                                        0,
                                    (index) {
                                      bool isSelected = serviceController
                                          .agriItems
                                          .contains(serviceController
                                              .servicesData
                                              .value
                                              .result![index]
                                              .id);
                                      return InkWell(
                                          onTap: () {
                                            if (isSelected) {
                                              serviceController.agriItems
                                                  .remove(serviceController
                                                      .servicesData
                                                      .value
                                                      .result![index]
                                                      .id);
                                            } else {
                                              if (serviceController
                                                      .agriItems.length <
                                                  5) {
                                                serviceController.agriItems.add(
                                                    serviceController
                                                        .servicesData
                                                        .value
                                                        .result![index]
                                                        .id);
                                              } else {}
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    color: AppColor.DARK_GREEN),
                                                gradient: isSelected
                                                    ? AppColor.PRIMARY_GRADIENT
                                                    : AppColor.WHITE_GRADIENT),
                                            child: Text(
                                              serviceController.servicesData
                                                  .value.result![index].name
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                color: AppColor.DARK_GREEN,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ));
                                    },
                                  ),
                                );
                              } else if (serviceController
                                      .rxRequestStatus.value ==
                                  Status.ERROR) {
                                return Text("Fetching Data");
                              } else {
                                return Container();
                              }
                            }),
                            Obx(() {
                              if (serviceController.agriItems.isEmpty ||
                                  controller.locationController.value.text ==
                                      "") {
                                return InkWell(
                                  onTap: () {
                                    print(
                                        "LL${controller.locationController.value.text}");
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 40),
                                    height: AppDimension.h * 0.07,
                                    width: AppDimension.w * 0.85,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0x19044D3A),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Proceed",
                                        style: GoogleFonts.poppins(
                                          color: Color(0xFFA0A6A3),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return InkWell(
                                  onTap: () async {
                                    await controller.agriProvider();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColor.DARK_GREEN,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Proceed",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Crop Expertise ',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF272727),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '*',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFFEB5757),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ',
                                    style: TextStyle(
                                      color: Color(0xFF272727),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.7,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 15),
                                                  margin: EdgeInsets.only(
                                                      bottom: 0),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColor.DARK_GREEN,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(12),
                                                        topRight:
                                                            Radius.circular(12),
                                                      )),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Select Crops",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: Icon(
                                                            Icons.close,
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                            size: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15.0,
                                                      vertical: 10),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Select up to 8 crops you are interested in",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColor
                                                              .BROWN_TEXT,
                                                        ),
                                                      ),
                                                      Obx(
                                                        () => Text(
                                                          "${cropcontroller.selectedCropsId.length}/8",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColor
                                                                .GREEN_SUBTEXT,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Obx(
                                                    () =>
                                                        cropcontroller
                                                                .selectedCropsId
                                                                .isEmpty
                                                            ? Container()
                                                            : Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 5,
                                                                        bottom:
                                                                            20,
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.12,
                                                                width: double
                                                                    .infinity,
                                                                child: ListView
                                                                    .builder(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount: cropcontroller
                                                                          .selectedCropsId
                                                                          .length ??
                                                                      0,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Stack(
                                                                            children: [
                                                                              Positioned(
                                                                                right: 0,
                                                                                top: 0,
                                                                                child: CircleAvatar(
                                                                                  radius: 10,
                                                                                  backgroundColor: Color(0xFFFF3B30),
                                                                                  child: Icon(
                                                                                    Icons.close,
                                                                                    color: Colors.white,
                                                                                    size: 18,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  print("ON TAP");
                                                                                  cropcontroller.removeCrop(cropcontroller.selectedCropsName[index], cropcontroller.selectedCropsId[index], cropcontroller.selectedCropsImages[index]);
                                                                                },
                                                                                child: DottedBorder(
                                                                                  borderType: BorderType.RRect,
                                                                                  color: Color(0xFFD6D6D6),
                                                                                  dashPattern: [
                                                                                    2,
                                                                                    2
                                                                                  ],
                                                                                  radius: Radius.circular(12),
                                                                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                                                                  child: Container(
                                                                                    height: MediaQuery.of(context).size.height * 0.06,
                                                                                    width: MediaQuery.of(context).size.height * 0.06,
                                                                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                                                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                                                                    decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(cropcontroller.selectedCropsImages[index] ?? ""))),
                                                                                    child: Center(
                                                                                      child: Row(
                                                                                        children: [],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 5.0),
                                                                            child:
                                                                                Text(
                                                                              cropcontroller.selectedCropsName[index].toString() ?? "",
                                                                              style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 10, color: AppColor.BROWN_TEXT),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              )),
                                                Obx(() => Expanded(
                                                      child: GridView.builder(
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          crossAxisSpacing: 8.0,
                                                          mainAxisSpacing: 8.0,
                                                          childAspectRatio: 1.1,
                                                        ),
                                                        itemCount: cropcontroller
                                                                .farmerCropData
                                                                .value
                                                                .result
                                                                ?.where((crop) =>
                                                                    !cropcontroller
                                                                        .selectedCropsId
                                                                        .contains(
                                                                            crop.id))
                                                                .length ??
                                                            0,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final crop = cropcontroller
                                                              .farmerCropData
                                                              .value
                                                              .result
                                                              ?.where((crop) =>
                                                                  !cropcontroller
                                                                      .selectedCropsId
                                                                      .contains(
                                                                          crop.id))
                                                              .toList()[index];

                                                          if (crop == null)
                                                            return SizedBox
                                                                .shrink();

                                                          return Column(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            10),
                                                                child: Column(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        cropcontroller
                                                                            .selectCrop(
                                                                          crop.name ??
                                                                              "",
                                                                          crop.id!
                                                                              .toInt(),
                                                                          crop.image ??
                                                                              "",
                                                                        );
                                                                      },
                                                                      child:
                                                                          DottedBorder(
                                                                        borderType:
                                                                            BorderType.RRect,
                                                                        color: Color(
                                                                            0xFFD6D6D6),
                                                                        dashPattern: [
                                                                          2,
                                                                          2
                                                                        ],
                                                                        radius:
                                                                            Radius.circular(12),
                                                                        padding: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                8,
                                                                            horizontal:
                                                                                10),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.075,
                                                                          width:
                                                                              MediaQuery.of(context).size.height * 0.075,
                                                                          margin:
                                                                              EdgeInsets.symmetric(horizontal: 5),
                                                                          padding: EdgeInsets.symmetric(
                                                                              vertical: 10,
                                                                              horizontal: 5),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            image:
                                                                                DecorationImage(
                                                                              image: NetworkImage(crop.image ?? ""),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              5.0),
                                                                      child:
                                                                          Text(
                                                                        crop.name ??
                                                                            "",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              AppColor.BROWN_TEXT,
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
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          color: AppColor.DARK_GREEN,
                                          dashPattern: [2, 2],
                                          radius: Radius.circular(12),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 12),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Center(
                                              child: Icon(
                                                CupertinoIcons.add,
                                                color: AppColor.DARK_GREEN,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Add Crops",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColor.DARK_GREEN),
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(() => cropcontroller.selectedCropsId.isEmpty
                                    ? Container()
                                    : Container(
                                        margin: EdgeInsets.only(
                                            top: 5,
                                            bottom: 20,
                                            left: 10,
                                            right: 10),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.48,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: cropcontroller
                                                  .selectedCropsId.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Positioned(
                                                        right: 0,
                                                        top: 0,
                                                        child: CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:
                                                              Color(0xFFFF3B30),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Colors.white,
                                                            size: 18,
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          print("ON TAP");
                                                          cropcontroller.removeCrop(
                                                              cropcontroller
                                                                      .selectedCropsName[
                                                                  index],
                                                              cropcontroller
                                                                      .selectedCropsId[
                                                                  index],
                                                              cropcontroller
                                                                      .selectedCropsImages[
                                                                  index]);
                                                        },
                                                        child: DottedBorder(
                                                          borderType:
                                                              BorderType.RRect,
                                                          color:
                                                              Color(0xFFD6D6D6),
                                                          dashPattern: [2, 2],
                                                          radius:
                                                              Radius.circular(
                                                                  12),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      10),
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.06,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.06,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        5),
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        cropcontroller.selectedCropsImages[index] ??
                                                                            ""))),
                                                            child: Center(
                                                              child: Row(
                                                                children: [],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5.0),
                                                    child: Text(
                                                      cropcontroller
                                                              .selectedCropsName[
                                                                  index]
                                                              .toString() ??
                                                          "",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 10,
                                                              color: AppColor
                                                                  .BROWN_TEXT),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )),
                              ],
                            ),
                            Obx(() {
                              if (cropcontroller.selectedCropsId.isEmpty ||
                                  controller.locationController.value.text ==
                                      "") {
                                return InkWell(
                                  onTap: () {
                                    print(
                                        "LOCATION${controller.locationController.value.text} LOCr");
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 40),
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0x19044D3A),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Proceed",
                                        style: GoogleFonts.poppins(
                                          color: Color(0xFFA0A6A3),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return InkWell(
                                  onTap: () async {
                                    controller.farmer();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColor.DARK_GREEN,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Proceed",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }),
                          ],
                        );
                      }
                    }),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
