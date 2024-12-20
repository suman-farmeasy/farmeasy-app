import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/Screens/LandSection/EditLand/Controller/edit_land_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Controller/crop_suggestion_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Controller/listother_crop.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/crop_suggestion_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/image_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/list_landType_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/update_landDetails_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/waterrespource_controller.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditLand extends StatefulWidget {
  EditLand({
    super.key,
    required this.landId,
    required this.nickName,
    required this.landSizeData,
    required this.landSizeDataType,
    required this.purposeId,
    required this.purposeName,
    required this.leaseDuration,
    required this.leaseDurationType,
    required this.leaseType,
    required this.leaseAmount,
    required this.leaseAmountValue,
    required this.cropToGrow,
    required this.landType,
    required this.isWaterAvailable,
    required this.waterValue,
    required this.isAccommodationAvailable,
    required this.accommodation,
    required this.isEquipmentAvailable,
    required this.equipment,
    required this.isRoadAccess,
    required this.isFarmedBefore,
    required this.cropGrew,
    required this.landImages,
    required this.certificate,
    required this.isLandCertified,
  });
  int landId = 0;
  String nickName = "";
  String landSizeData = "";
  String landSizeDataType = "";
  int purposeId = 0;
  String purposeName = "";
  String leaseDuration = "";
  String leaseDurationType = "";
  String leaseType = "";
  String leaseAmount = "";
  String leaseAmountValue = "";
  List cropToGrow = [];
  int landType = 0;
  bool isWaterAvailable = true;
  int waterValue = 0;
  bool isAccommodationAvailable = true;
  String accommodation = "";
  bool isEquipmentAvailable = true;
  String equipment = "";
  bool isRoadAccess = true;
  bool isFarmedBefore = true;
  List cropGrew = [];
  List landImages = [];
  bool isLandCertified = true;
  String certificate = "";
  @override
  State<EditLand> createState() => _EditLandState();
}

class _EditLandState extends State<EditLand> {
  final controller = Get.put(EditLandController());
  final _formKey = GlobalKey<FormState>();
  final _landSize = GlobalKey<FormState>();
  final _landlease = GlobalKey<FormState>();
  final _landTitle = GlobalKey<FormState>();
  final chatgptCropController = Get.put(ChatGPTCropSuggestionController());
  final otherCropController = Get.put(ListOthersCropController());
  final landTypeController = Get.find<ListLandTypeController>();
  final updateLand = Get.put(UpdateLandDetailsController());
  final waterController = Get.find<WaterResourceController>();
  final cropSugestionController = Get.find<CropSuggestionController>();

  final _accomodationKey = GlobalKey<FormState>();
  final _equipmentKey = GlobalKey<FormState>();
  final imageController = Get.put(ImageController());
  final getLandData = Get.find<LandInfoController>();
  @override
  void initState() {
    super.initState();
    controller.landTitleController.value.text = widget.nickName;
    controller.landTitle.value = widget.nickName;
    controller.selectedPurposeName.value = widget.purposeName;
    controller.selectedPurposeid.value = widget.purposeId;
    controller.landlease.value.text = widget.leaseDuration;
    controller.selectedleaseUinit.value = widget.leaseDurationType;
    controller.lease_type.value = widget.leaseType;
    setState(() {
      controller.landArea.value =
          "${widget.landSizeData}  ${widget.landSizeDataType}";
    });
    controller.leaseDUration.value =
        "${widget.leaseDuration}  ${widget.leaseDurationType}";
    controller.landSize.value.text = widget.landSizeData;
    controller.selectedUnit.value = widget.landSizeDataType;
    if (widget.leaseType == "Rent") {
      controller.isleaseAvailable.value = true;
      String correctedString = utf8.decode(widget.leaseAmountValue.codeUnits);
      controller.amount.value = correctedString;
      controller.isleaseAmount.value.text = widget.leaseAmount;
    } else if (widget.leaseType == "Share Profit") {
      controller.isleaseAvailable.value = false;
    }

    controller.purposeFunc();
    ever(controller.rxPurposeRequestStatus, (status) {
      if (status == Status.SUCCESS) {
        final purposeIndex = controller.purposeData.value.result!
            .indexWhere((element) => element.id == widget.purposeId);
        if (purposeIndex != -1) {
          controller.current.value = purposeIndex;
        } else {
          print("Purpose ID not found in the list.");
        }
      } else if (status == Status.LOADING) {
        print("Purpose data is still loading...");
      } else {
        print("Failed to load purpose data.");
      }
    });
    controller.cropData(widget.landId);
    for (var crop in widget.cropToGrow) {
      controller.cropAdded.add(crop.id);
      controller.cropAddedName.add(crop.name);
    }
    landTypeController.selectedId.value = widget.landType;
    updateLand.isWaterAvailable.value = widget.isWaterAvailable;
    updateLand.waterId.value = widget.waterValue;
    updateLand.isAccomodationAvailable.value = widget.isAccommodationAvailable;
    updateLand.accomodationController.value.text = widget.accommodation;
    updateLand.isEquipmentAvailable.value = widget.isEquipmentAvailable;
    updateLand.equipmentController.value.text = widget.equipment;
    updateLand.isLandFarm.value = widget.isFarmedBefore;
    for (var crop in widget.cropGrew) {
      updateLand.crops.add(crop.id);
    }
    for (var images in widget.landImages) {
      imageController.uploadedIds.add(images.id);
      imageController.photos.add(images.image);
    }
    updateLand.isCertified.value = widget.isLandCertified;
    updateLand.initializeCertificate(widget.certificate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: AppColor.BACKGROUND,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      getLandData.getLandDetails(widget.landId);
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColor.BROWN_TEXT,
                    )),
                Text(
                  'Edit Land',
                  style: GoogleFonts.poppins(
                    color: AppColor.BROWN_TEXT,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                Text(
                  '      ',
                  style: GoogleFonts.poppins(
                    color: AppColor.BROWN_TEXT,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: AppColor.PRIMARY_GRADIENT,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        ImageConstants.ARROW,
                        width: 20,
                      ),
                      Text(
                        '    Land information',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF483C32),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 0.17,
                        ),
                      )
                    ],
                  ),
                  Obx(() {
                    return controller.landtitleValue.value
                        ? controller.isTitleAdded.value
                            ? InkWell(
                                onTap: () {
                                  controller.isTitleAdded.value = false;
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColor.GREY_BORDER),
                                    boxShadow: [AppColor.BOX_SHADOW],
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Land Nickname',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF919191),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Color(0xFFEB5757),
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.5,
                                            child: Text(
                                              controller.landTitle.value,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF272727),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                height: 1.2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller.isTitleAdded.value =
                                                  false;
                                            },
                                            child: Text(
                                              'Added',
                                              style: GoogleFonts.poppins(
                                                color: AppColor.LIGHT_GREEN,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.task_alt_rounded,
                                            color: AppColor.LIGHT_GREEN,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: AppColor.GREY_BORDER),
                                  boxShadow: [AppColor.BOX_SHADOW],
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Land Nickname',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF272727),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Color(0xFFEB5757),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.075,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColor.GREY_BORDER),
                                        boxShadow: [AppColor.BOX_SHADOW],
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        children: [
                                          Form(
                                            key: _landTitle,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              width: Get.width * 0.75,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: controller
                                                    .landTitleController.value,
                                                decoration: InputDecoration(
                                                  hintText: 'Land Nickname',
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                    color:
                                                        const Color(0x994F4F4F),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 0.10,
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'enter land nickname';
                                                  }
                                                  {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 120),
                                      child: InkWell(
                                        onTap: () {
                                          if (_landTitle.currentState!
                                              .validate()) {
                                            controller.addTitle();
                                            updateLand.updateLandNickname(
                                                controller.landTitleController
                                                    .value.text);
                                            print("VALUE");
                                          }
                                          {
                                            print("VALUE");
                                            return;
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          decoration: ShapeDecoration(
                                            color: AppColor.DARK_GREEN,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: TextButton(
                                                onPressed: () {
                                                  if (_landTitle.currentState!
                                                      .validate()) {
                                                    controller.addTitle();
                                                    updateLand.updateLandNickname(
                                                        controller
                                                            .landTitleController
                                                            .value
                                                            .text);
                                                  }
                                                  {
                                                    return;
                                                  }
                                                },
                                                child: Text(
                                                  'Add ',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                        : InkWell(
                            onTap: controller.landTitleValue,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: 10, top: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.GREY_BORDER),
                                boxShadow: [AppColor.BOX_SHADOW],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Land Nickname',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF919191),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            color: Color(0xFFEB5757),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: controller.landTitleValue,
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF272727),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  }),
                  Obx(() {
                    return controller.landSizeValue.value
                        ? controller.isLandAdded.value
                            ? InkWell(
                                onTap: () {
                                  controller.isLandAdded.value = false;
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColor.GREY_BORDER),
                                    boxShadow: [AppColor.BOX_SHADOW],
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Land Size(Area)',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF919191),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Color(0xFFEB5757),
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.5,
                                            child: Text(
                                              controller.landArea.value,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF272727),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                height: 1.2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller.isLandAdded.value =
                                                  false;
                                            },
                                            child: Text(
                                              'Added',
                                              style: GoogleFonts.poppins(
                                                color: AppColor.LIGHT_GREEN,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.task_alt_rounded,
                                            color: AppColor.LIGHT_GREEN,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: AppColor.GREY_BORDER),
                                  boxShadow: [AppColor.BOX_SHADOW],
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Land Size(Area)',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF272727),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Color(0xFFEB5757),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.075,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColor.GREY_BORDER),
                                        boxShadow: [AppColor.BOX_SHADOW],
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        children: [
                                          Form(
                                            key: _landSize,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              width: Get.width * 0.33,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    controller.landSize.value,
                                                decoration: InputDecoration(
                                                  hintText: 'Land Size',
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                    color:
                                                        const Color(0x994F4F4F),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 0.10,
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'enter the land size';
                                                  }
                                                  {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 1,
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Obx(
                                              () => DropdownButton(
                                                underline: Container(),
                                                value: controller
                                                        .selectedUnit.value ??
                                                    "Square Meters",
                                                items: controller.units
                                                    .map((unit) {
                                                  return DropdownMenuItem(
                                                    value: unit,
                                                    child: Text(
                                                      unit,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF4F4F4F),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0.10,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (selectedUnit) {
                                                  controller.updateSelectedUnit(
                                                      selectedUnit.toString());
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 120),
                                      child: InkWell(
                                        onTap: () {
                                          if (_landSize.currentState!
                                              .validate()) {
                                            controller.addLand();
                                            updateLand.updateLandSize(
                                                controller.landArea.value);
                                          }
                                          {
                                            return;
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          decoration: ShapeDecoration(
                                            color: AppColor.DARK_GREEN,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: TextButton(
                                                onPressed: () {
                                                  if (_landSize.currentState!
                                                      .validate()) {
                                                    controller.addLand();
                                                    updateLand.updateLandSize(
                                                        controller
                                                            .landArea.value);
                                                  }
                                                  {
                                                    return;
                                                  }
                                                },
                                                child: Text(
                                                  'Add ',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                        : InkWell(
                            onTap: controller.landValue,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: 10, top: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.GREY_BORDER),
                                boxShadow: [AppColor.BOX_SHADOW],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Land Size (Area) ',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF919191),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            color: Color(0xFFEB5757),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: controller.landValue,
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF272727),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  }),
                  Obx(() {
                    return controller.addPurpose.value
                        ? controller.isPurposeAdded.value
                            ? InkWell(
                                onTap: () =>
                                    controller.isPurposeAdded.value = false,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColor.GREY_BORDER),
                                    boxShadow: [AppColor.BOX_SHADOW],
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Purpose',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF919191),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Color(0xFFEB5757),
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              controller
                                                  .selectedPurposeName.value,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF272727),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                height: 1.2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller.isPurposeAdded.value =
                                                  false;
                                            },
                                            child: Text(
                                              'Added',
                                              style: GoogleFonts.poppins(
                                                color: AppColor.LIGHT_GREEN,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.task_alt_rounded,
                                            color: AppColor.LIGHT_GREEN,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: AppColor.GREY_BORDER),
                                  boxShadow: [AppColor.BOX_SHADOW],
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Purpose',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF272727),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Color(0xFFEB5757),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Obx(() {
                                      if (controller.rxPurposeRequestStatus ==
                                          Status.LOADING) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColor.DARK_GREEN,
                                            ),
                                          ),
                                        );
                                      } else if (controller
                                              .rxPurposeRequestStatus ==
                                          Status.SUCCESS) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Wrap(
                                            spacing: 10,
                                            children: List.generate(
                                              controller.purposeData.value
                                                  .result!.length,
                                              (index) => InkWell(
                                                onTap: () {
                                                  controller.current.value =
                                                      index;
                                                  controller.selectedPurposeid
                                                          .value =
                                                      controller
                                                          .purposeData
                                                          .value
                                                          .result![index]
                                                          .id!;
                                                  controller.selectedPurposeName
                                                          .value =
                                                      controller
                                                          .purposeData
                                                          .value
                                                          .result![index]
                                                          .name!;
                                                },
                                                child: AnimatedContainer(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    border: controller.current
                                                                .value ==
                                                            index
                                                        ? Border.all(
                                                            color: AppColor
                                                                .DARK_GREEN)
                                                        : Border.all(
                                                            color: AppColor
                                                                .GREY_BORDER),
                                                    gradient: controller.current
                                                                .value ==
                                                            index
                                                        ? AppColor
                                                            .PRIMARY_GRADIENT
                                                        : AppColor
                                                            .WHITE_GRADIENT,
                                                  ),
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  child: Text(
                                                    controller.purposeData.value
                                                        .result![index].name!,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 120),
                                      child: InkWell(
                                        onTap: () {
                                          controller.purposeAdded();
                                          updateLand.updateLandPurpose(
                                              controller
                                                  .selectedPurposeid.value);
                                          print(
                                              "============================================================${controller.selectedPurposeName.value}");
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          decoration: ShapeDecoration(
                                            color: AppColor.DARK_GREEN,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: TextButton(
                                                onPressed: () {
                                                  controller.purposeAdded();
                                                  updateLand.updateLandPurpose(
                                                      controller
                                                          .selectedPurposeid
                                                          .value);

                                                  print(
                                                      "============================================================${controller.selectedPurposeName.value}");
                                                },
                                                child: Text(
                                                  'Add ',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                        : InkWell(
                            onTap: controller.addPurposeValue,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: 20, top: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.GREY_BORDER),
                                boxShadow: [AppColor.BOX_SHADOW],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Purpose',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF919191),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            color: Color(0xFFEB5757),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: controller.addPurposeValue,
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF272727),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  }),
                  Obx(() {
                    return controller.selectedPurposeName.value ==
                            "Give on lease for farming"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                return controller.landleaseValue.value
                                    ? controller.isLandleaseAdded.value
                                        ? InkWell(
                                            onTap: () {
                                              controller.isLandleaseAdded
                                                  .value = false;
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 10),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        AppColor.GREY_BORDER),
                                                boxShadow: [
                                                  AppColor.BOX_SHADOW
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10),
                                                        child: Text.rich(
                                                          TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    'Lease duration',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: const Color(
                                                                      0xFF919191),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 0,
                                                                ),
                                                              ),
                                                              const TextSpan(
                                                                text: '*',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFFEB5757),
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.5,
                                                        child: Text(
                                                          controller
                                                              .leaseDUration
                                                              .value,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: const Color(
                                                                0xFF272727),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 1.2,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          controller
                                                              .isLandleaseAdded
                                                              .value = false;
                                                        },
                                                        child: Text(
                                                          'Added',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: AppColor
                                                                .LIGHT_GREEN,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.task_alt_rounded,
                                                        color: AppColor
                                                            .LIGHT_GREEN,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 15),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: AppColor.GREY_BORDER),
                                              boxShadow: [AppColor.BOX_SHADOW],
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Lease duration',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: const Color(
                                                              0xFF272727),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0,
                                                        ),
                                                      ),
                                                      const TextSpan(
                                                        text: '*',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFEB5757),
                                                          fontSize: 14,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 15),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.075,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: AppColor
                                                            .GREY_BORDER),
                                                    boxShadow: [
                                                      AppColor.BOX_SHADOW
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Form(
                                                        key: _landlease,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          width:
                                                              Get.width * 0.33,
                                                          child: TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                controller
                                                                    .landlease
                                                                    .value,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'duration',
                                                              hintStyle:
                                                                  GoogleFonts
                                                                      .poppins(
                                                                color: const Color(
                                                                    0x994F4F4F),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 0.10,
                                                              ),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'enter the duration';
                                                              }
                                                              {
                                                                return null;
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 15),
                                                        child: Obx(
                                                          () {
                                                            // Ensure the selected value is in the list of items
                                                            final selectedValue = controller
                                                                    .leaseunits
                                                                    .contains(controller
                                                                        .selectedleaseUinit
                                                                        .value)
                                                                ? controller
                                                                    .selectedleaseUinit
                                                                    .value
                                                                : null;

                                                            return DropdownButton(
                                                              underline:
                                                                  Container(),
                                                              value:
                                                                  selectedValue,
                                                              hint: const Text(
                                                                  "Select a unit"),
                                                              items: controller
                                                                  .leaseunits
                                                                  .map((unit) {
                                                                return DropdownMenuItem(
                                                                  value: unit,
                                                                  child: Text(
                                                                    unit,
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: const Color(
                                                                          0xFF4F4F4F),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      height:
                                                                          0.10,
                                                                    ),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                              onChanged:
                                                                  (selectedUnit) {
                                                                controller.updateSelectedleaseUnit(
                                                                    selectedUnit
                                                                        .toString());
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 120),
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (_landlease
                                                          .currentState!
                                                          .validate()) {
                                                        controller.addLease();
                                                        updateLand
                                                            .updateLandLeaseDuration(
                                                                controller
                                                                    .leaseDUration
                                                                    .value);
                                                      }
                                                      {
                                                        return;
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 3,
                                                      ),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 10,
                                                      ),
                                                      decoration:
                                                          ShapeDecoration(
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: TextButton(
                                                            onPressed: () {
                                                              if (_landlease
                                                                  .currentState!
                                                                  .validate()) {
                                                                controller
                                                                    .addLease();
                                                                updateLand.updateLandLeaseDuration(
                                                                    controller
                                                                        .leaseDUration
                                                                        .value);
                                                              }
                                                              {
                                                                return;
                                                              }
                                                            },
                                                            child: Text(
                                                              'Add ',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height: 0,
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                    : InkWell(
                                        onTap: controller.leaseValue,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: AppColor.GREY_BORDER),
                                            boxShadow: [AppColor.BOX_SHADOW],
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Lease duration',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF919191),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: '*',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFEB5757),
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: controller.landValue,
                                                child: Text(
                                                  'Add',
                                                  style: GoogleFonts.poppins(
                                                    color:
                                                        const Color(0xFF272727),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              }),
                              const SizedBox(
                                height: 10,
                              ),
                              Obx(() {
                                return controller.landleaseAmountvalue.value
                                    ? controller.islandleaseAmountvalue.value
                                        ? InkWell(
                                            onTap: () => controller
                                                .islandleaseAmountvalue
                                                .value = false,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        AppColor.GREY_BORDER),
                                                boxShadow: [
                                                  AppColor.BOX_SHADOW
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10),
                                                        child: Text.rich(
                                                          TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    'Leasing type',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: const Color(
                                                                      0xFF919191),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 0,
                                                                ),
                                                              ),
                                                              const TextSpan(
                                                                text: '*',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFFEB5757),
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.5,
                                                        child: Text(
                                                          controller
                                                              .lease_type.value,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: const Color(
                                                                0xFF272727),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 1.2,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          controller
                                                              .islandleaseAmountvalue
                                                              .value = false;
                                                        },
                                                        child: Text(
                                                          'Added',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: AppColor
                                                                .LIGHT_GREEN,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.task_alt_rounded,
                                                        color: AppColor
                                                            .LIGHT_GREEN,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 15),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: AppColor.GREY_BORDER),
                                              boxShadow: [AppColor.BOX_SHADOW],
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Lease type',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: const Color(
                                                              0xFF272727),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0,
                                                        ),
                                                      ),
                                                      const TextSpan(
                                                        text: '*',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFEB5757),
                                                          fontSize: 14,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Obx(() {
                                                  return Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Obx(
                                                                () =>
                                                                    RadioListTile<
                                                                        bool>(
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  activeColor:
                                                                      AppColor
                                                                          .DARK_GREEN,
                                                                  title: Text(
                                                                    'Rent/month',
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: const Color(
                                                                          0xFF333333),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                  value: true,
                                                                  groupValue:
                                                                      controller
                                                                          .isleaseAvailable
                                                                          .value,
                                                                  onChanged:
                                                                      (value) {
                                                                    controller
                                                                        .isleaseAvailable
                                                                        .value = value!;
                                                                    controller
                                                                        .lease_type
                                                                        .value = "Rent";
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Obx(
                                                                () =>
                                                                    RadioListTile<
                                                                        bool>(
                                                                  contentPadding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          0),
                                                                  title: Text(
                                                                    'Share profit',
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: const Color(
                                                                          0xFF333333),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                  value: false,
                                                                  activeColor:
                                                                      AppColor
                                                                          .DARK_GREEN,
                                                                  groupValue:
                                                                      controller
                                                                          .isleaseAvailable
                                                                          .value,
                                                                  onChanged:
                                                                      (value) {
                                                                    controller
                                                                        .isleaseAvailable
                                                                        .value = value!;
                                                                    controller
                                                                            .lease_type
                                                                            .value =
                                                                        "Share Profit";
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Visibility(
                                                          visible: controller
                                                              .isleaseAvailable
                                                              .value,
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        15),
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.075,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: AppColor
                                                                      .GREY_BORDER),
                                                              boxShadow: [
                                                                AppColor
                                                                    .BOX_SHADOW
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                                  child: Obx(
                                                                    () =>
                                                                        DropdownButton(
                                                                      icon:
                                                                          null,
                                                                      underline:
                                                                          Container(),
                                                                      value: controller
                                                                              .amount
                                                                              .value ??
                                                                          "Months",
                                                                      items: controller
                                                                          .amountType
                                                                          .map(
                                                                              (unit) {
                                                                        return DropdownMenuItem(
                                                                          value:
                                                                              unit,
                                                                          child:
                                                                              Text(
                                                                            unit,
                                                                            style:
                                                                                GoogleFonts.poppins(
                                                                              color: const Color(0xFF4F4F4F),
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w500,
                                                                              height: 0.10,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                      onChanged:
                                                                          (selectedUnit) {
                                                                        controller
                                                                            .updateSelectedamount(selectedUnit.toString());
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                                  width:
                                                                      Get.width *
                                                                          0.33,
                                                                  child:
                                                                      TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    controller:
                                                                        controller
                                                                            .isleaseAmount
                                                                            .value,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          'amount',
                                                                      hintStyle:
                                                                          GoogleFonts
                                                                              .poppins(
                                                                        color: const Color(
                                                                            0x994F4F4F),
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0.10,
                                                                      ),
                                                                      border: InputBorder
                                                                          .none,
                                                                    ),
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return 'enter the amount';
                                                                      }
                                                                      {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 120),
                                                  child: InkWell(
                                                    onTap: () {
                                                      print(
                                                          "LEASE TYPE:::${controller.lease_type.value}");
                                                      controller.addAmount();
                                                      updateLand
                                                          .updateLandLeaseType(
                                                              controller
                                                                  .lease_type
                                                                  .value,
                                                              controller
                                                                  .leaseAmount
                                                                  .value);
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 3,
                                                      ),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 10,
                                                      ),
                                                      decoration:
                                                          ShapeDecoration(
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: TextButton(
                                                            onPressed: () {
                                                              print(
                                                                  "LEASE TYPE:::${controller.lease_type.value}");
                                                              controller
                                                                  .addAmount();
                                                              updateLand.updateLandLeaseType(
                                                                  controller
                                                                      .lease_type
                                                                      .value,
                                                                  controller
                                                                      .leaseAmount
                                                                      .value);
                                                            },
                                                            child: Text(
                                                              'Add ',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height: 0,
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                    : InkWell(
                                        onTap: controller.leaseAmountValue,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 10, top: 10),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: AppColor.GREY_BORDER),
                                            boxShadow: [AppColor.BOX_SHADOW],
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Lease type',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF919191),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: '*',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFEB5757),
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: controller.landValue,
                                                child: Text(
                                                  'Add',
                                                  style: GoogleFonts.poppins(
                                                    color:
                                                        const Color(0xFF272727),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              }),
                            ],
                          )
                        : Container();
                  }),
                  Obx(() {
                    return controller.iscropAdded.value
                        ? controller.isCropValue.value
                            ? InkWell(
                                onTap: () {
                                  controller.isCropValue.value = false;
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColor.GREY_BORDER),
                                    boxShadow: [AppColor.BOX_SHADOW],
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Crops',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF919191),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Color(0xFFEB5757),
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.53,
                                            child: Wrap(
                                              children: List.generate(
                                                controller
                                                        .cropAddedName.length +
                                                    controller
                                                        .otherCropAddedName
                                                        .length,
                                                (index) {
                                                  final isCropAddedName =
                                                      index <
                                                          controller
                                                              .cropAddedName
                                                              .length;
                                                  final cropName = isCropAddedName
                                                      ? controller
                                                          .cropAddedName[index]
                                                      : controller
                                                              .otherCropAddedName[
                                                          index -
                                                              controller
                                                                  .cropAddedName
                                                                  .length];

                                                  return Container(
                                                    child: Text(
                                                      "$cropName, ",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF272727),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller.isCropValue.value =
                                                  false;
                                            },
                                            child: Text(
                                              'Added',
                                              style: GoogleFonts.poppins(
                                                color: AppColor.LIGHT_GREEN,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.task_alt_rounded,
                                            color: AppColor.LIGHT_GREEN,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: AppColor.GREY_BORDER),
                                  boxShadow: [AppColor.BOX_SHADOW],
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: controller.selectedPurposeName
                                                        .value ==
                                                    "Give on lease for farming"
                                                ? 'What crop can be grown?'
                                                : 'What kind of crop do you want to grow?',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF272727),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Color(0xFFEB5757),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        'You can select multiple options',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF757575),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          height: 0.16,
                                        ),
                                      ),
                                    ),
                                    Obx(() {
                                      if (controller.rxCroprequestStatus ==
                                          Status.LOADING) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColor.DARK_GREEN,
                                            ),
                                          ),
                                        );
                                      } else if (controller
                                              .rxCroprequestStatus ==
                                          Status.SUCCESS) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Wrap(
                                            spacing: 10,
                                            children: List.generate(
                                                controller.cropResponseData
                                                        .value.result!.length +
                                                    1, (index) {
                                              if (index ==
                                                  controller.cropResponseData
                                                      .value.result!.length) {
                                                bool isSelected = controller
                                                    .cropAdded
                                                    .contains(-1);
                                                return InkWell(
                                                  onTap: () {
                                                    otherCropController
                                                        .listOtherCrop("");
                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.white,
                                                      builder: (context) {
                                                        return Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.7,
                                                          color: Colors.white,
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              AppColor.GREY_BORDER),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.72,
                                                                    child:
                                                                        TextFormField(
                                                                      controller: otherCropController
                                                                          .cropController
                                                                          .value,
                                                                      onChanged:
                                                                          (value) {
                                                                        otherCropController
                                                                            .listOtherCrop(value); // Call API on every change
                                                                      },
                                                                      decoration:
                                                                          const InputDecoration(
                                                                        hintText:
                                                                            "Enter Crop",
                                                                        contentPadding:
                                                                            EdgeInsets.symmetric(horizontal: 15),
                                                                        border:
                                                                            InputBorder.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: AppColor
                                                                          .DARK_GREEN,
                                                                      size: 20,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.5,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            10),
                                                                child: Obx(() {
                                                                  if (otherCropController
                                                                          .rxRequestStatus ==
                                                                      Status
                                                                          .LOADING) {
                                                                    return const Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        color: AppColor
                                                                            .DARK_GREEN,
                                                                      ),
                                                                    );
                                                                  } else if (otherCropController
                                                                          .rxRequestStatus ==
                                                                      Status
                                                                          .SUCCESS) {
                                                                    return SingleChildScrollView(
                                                                      child:
                                                                          Wrap(
                                                                        spacing:
                                                                            10,
                                                                        children:
                                                                            List.generate(
                                                                          otherCropController
                                                                              .cropData
                                                                              .value
                                                                              .result!
                                                                              .length,
                                                                          (index) {
                                                                            final cropId =
                                                                                otherCropController.cropData.value.result![index].id;
                                                                            final cropName =
                                                                                otherCropController.cropData.value.result![index].name.toString();
                                                                            bool
                                                                                isSelected =
                                                                                cropId != null && controller.otherCropAdded.contains(cropId.toInt());
                                                                            bool
                                                                                isSelectedName =
                                                                                controller.otherCropAddedName.contains(cropName.toString());

                                                                            return InkWell(
                                                                              onTap: () {
                                                                                if (cropId != null) {
                                                                                  if (isSelected) {
                                                                                    controller.otherCropAdded.remove(cropId);
                                                                                  } else {
                                                                                    controller.otherCropAdded.add(cropId);
                                                                                  }
                                                                                }
                                                                                if (isSelectedName) {
                                                                                  controller.otherCropAddedName.remove(cropName);
                                                                                } else {
                                                                                  controller.otherCropAddedName.add(cropName);
                                                                                }
                                                                              },
                                                                              child: AnimatedContainer(
                                                                                margin: const EdgeInsets.symmetric(vertical: 5),
                                                                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(40),
                                                                                  border: isSelected ? Border.all(color: AppColor.DARK_GREEN) : Border.all(color: AppColor.GREY_BORDER),
                                                                                  gradient: isSelected ? AppColor.PRIMARY_GRADIENT : AppColor.WHITE_GRADIENT,
                                                                                ),
                                                                                duration: const Duration(milliseconds: 200),
                                                                                child: Text(cropName),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    return Container();
                                                                  }
                                                                }),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  controller
                                                                      .addselectCrop();
                                                                  updateLand.updateLandsCrop(
                                                                      controller
                                                                          .cropAdded
                                                                          .toList(),
                                                                      controller
                                                                          .otherCropAddedName
                                                                          .toList());
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    vertical: 3,
                                                                  ),
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                  ),
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    color: AppColor
                                                                        .DARK_GREEN,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    child: TextButton(
                                                                        onPressed: () {
                                                                          controller
                                                                              .addselectCrop();
                                                                          updateLand.updateLandsCrop(
                                                                              controller.cropAdded.toList(),
                                                                              controller.otherCropAddedName.toList());
                                                                        },
                                                                        child: Text(
                                                                          'Add ',
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );

//                                                     if (isSelected) {
//                                                       controller.cropAdded
//                                                           .remove(-1);
// //                                                   controller.cropAddedName.remove("Others");
//                                                     } else {
//                                                       controller.cropAdded
//                                                           .add(-1);
//                                                       //  controller.cropAddedName.add("Others");
//                                                     }
                                                  },
                                                  child: AnimatedContainer(
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      border: isSelected
                                                          ? Border.all(
                                                              color: AppColor
                                                                  .DARK_GREEN)
                                                          : Border.all(
                                                              color: AppColor
                                                                  .GREY_BORDER),
                                                      gradient: isSelected
                                                          ? AppColor
                                                              .PRIMARY_GRADIENT
                                                          : AppColor
                                                              .WHITE_GRADIENT,
                                                    ),
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    child: const Text("Others"),
                                                  ),
                                                );
                                              } else {
                                                final cropId = controller
                                                    .cropResponseData
                                                    .value
                                                    .result![index]
                                                    .id;
                                                final cropName = controller
                                                    .cropResponseData
                                                    .value
                                                    .result![index]
                                                    .name
                                                    .toString();
                                                bool isSelected =
                                                    cropId != null &&
                                                        controller.cropAdded
                                                            .contains(
                                                                cropId.toInt());
                                                bool isSelectedName = controller
                                                    .cropAddedName
                                                    .contains(
                                                        cropName.toString());

                                                return InkWell(
                                                  onTap: () {
                                                    if (cropId != null) {
                                                      if (isSelected) {
                                                        controller.cropAdded
                                                            .remove(cropId);
                                                      } else {
                                                        controller.cropAdded
                                                            .add(
                                                                cropId.toInt());
                                                      }
                                                    }
                                                    if (isSelectedName) {
                                                      controller.cropAddedName
                                                          .remove(cropName);
                                                    } else {
                                                      controller.cropAddedName
                                                          .add(cropName);
                                                    }
                                                  },
                                                  child: AnimatedContainer(
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      border: isSelected
                                                          ? Border.all(
                                                              color: AppColor
                                                                  .DARK_GREEN)
                                                          : Border.all(
                                                              color: AppColor
                                                                  .GREY_BORDER),
                                                      gradient: isSelected
                                                          ? AppColor
                                                              .PRIMARY_GRADIENT
                                                          : AppColor
                                                              .WHITE_GRADIENT,
                                                    ),
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    child: Text(cropName),
                                                  ),
                                                );
                                              }
                                            }),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 120),
                                      child: InkWell(
                                        onTap: () {
                                          controller
                                              .addselectCropfromContainer();
                                          updateLand.updateLandsCrop(
                                              controller.cropAdded.toList(),
                                              controller.otherCropAddedName
                                                  .toList());
                                          print("DATA");
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          decoration: ShapeDecoration(
                                            color: AppColor.DARK_GREEN,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: TextButton(
                                                onPressed: () {
                                                  controller
                                                      .addselectCropfromContainer();
                                                  updateLand.updateLandsCrop(
                                                      controller.cropAdded
                                                          .toList(),
                                                      controller
                                                          .otherCropAddedName
                                                          .toList());
                                                  print("DATA");
                                                },
                                                child: Text(
                                                  'Add ',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                        : InkWell(
                            onTap: controller.cropAdd,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.GREY_BORDER),
                                boxShadow: [AppColor.BOX_SHADOW],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() {
                                    if (controller.lease_type.value == "") {
                                      return SizedBox(
                                        width: Get.width * 0.5,
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    'What kind of crop do you want to grow?',
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF919191),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: '*',
                                                style: TextStyle(
                                                  color: Color(0xFFEB5757),
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else if (controller.lease_type.value ==
                                        "Share Profit") {
                                      return SizedBox(
                                        width: Get.width * 0.5,
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    'What kind of crop do you want to grow?',
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF919191),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: '*',
                                                style: TextStyle(
                                                  color: Color(0xFFEB5757),
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else if (controller.lease_type.value ==
                                        "Rent") {
                                      return SizedBox(
                                        width: Get.width * 0.5,
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    'Types of crop you can grow?',
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF919191),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: '*',
                                                style: TextStyle(
                                                  color: Color(0xFFEB5757),
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                                  TextButton(
                                    onPressed: controller.cropAdd,
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF272727),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  }),
                  Obx(() {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColor.GREY_BORDER),
                        boxShadow: [AppColor.BOX_SHADOW],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Type of Land',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF272727),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                                450 ~/ 4,
                                (index) => Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : AppColor.GREY_BORDER,
                                        height: 1,
                                      ),
                                    )),
                          ),
                          landTypeController.loading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: AppColor.DARK_GREEN,
                                ))
                              : Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: List.generate(
                                    landTypeController
                                            .landData.value.result?.length ??
                                        0,
                                    (index) {
                                      final landType = landTypeController
                                          .landData.value.result![index];
                                      return InkWell(
                                        onTap: () {
                                          landTypeController.selectedId.value =
                                              landType.id!
                                                  .toInt(); // Assign actual id
                                          updateLand.landType.value =
                                              landType.id.toString();
                                          print(
                                              "======================================================================${updateLand.landType.value}");
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          decoration: BoxDecoration(
                                            gradient: landTypeController
                                                        .selectedId.value ==
                                                    landType.id
                                                ? AppColor.PRIMARY_GRADIENT
                                                : AppColor.WHITE_GRADIENT,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                              color: landTypeController
                                                          .selectedId.value ==
                                                      landType.id
                                                  ? AppColor.DARK_GREEN
                                                  : AppColor.GREY_BORDER,
                                            ),
                                          ),
                                          child: Text(
                                            landType.name ?? "",
                                            style: GoogleFonts.poppins(
                                              color: AppColor.DARK_GREEN,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          InkWell(
                            onTap: () {
                              updateLand.updateLandType();
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: Get.width * 0.5),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                  horizontal: 40,
                                ),
                                decoration: ShapeDecoration(
                                  color: AppColor.DARK_GREEN,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Color(0xFFFBFBFB),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                )),
                          )
                        ],
                      ),
                    );
                  }),
                  Obx(() {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColor.GREY_BORDER),
                        boxShadow: [AppColor.BOX_SHADOW],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Are there water sources available?',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF272727),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                                450 ~/ 4,
                                (index) => Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : AppColor.GREY_BORDER,
                                        height: 1,
                                      ),
                                    )),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => RadioListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    activeColor: AppColor.DARK_GREEN,
                                    title: Text(
                                      'Available',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: true,
                                    groupValue:
                                        updateLand.isWaterAvailable.value,
                                    onChanged: (value) {
                                      updateLand.isWaterAvailable.value =
                                          value!;
                                      print(updateLand.isWaterAvailable.value);
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Obx(
                                  () => RadioListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Text(
                                      'Unavailable',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: false,
                                    activeColor: AppColor.DARK_GREEN,
                                    groupValue:
                                        updateLand.isWaterAvailable.value,
                                    onChanged: (value) {
                                      updateLand.isWaterAvailable.value =
                                          value!;
                                      print(updateLand.isWaterAvailable.value);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(() => Visibility(
                                visible: updateLand.isWaterAvailable.value,
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: List.generate(
                                    waterController.waterResource.value.result
                                            ?.length ??
                                        0,
                                    (index) {
                                      final waterResource = waterController
                                          .waterResource.value.result![index];
                                      return InkWell(
                                        onTap: () {
                                          updateLand.waterId.value =
                                              waterResource.id!
                                                  .toInt(); // Assign actual id
                                          updateLand.waterResource.value =
                                              waterResource.id.toString();
                                          print(
                                              "======================================================================${updateLand.waterResource.value}");
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          decoration: BoxDecoration(
                                            gradient:
                                                updateLand.waterId.value ==
                                                        waterResource.id
                                                    ? AppColor.PRIMARY_GRADIENT
                                                    : AppColor.WHITE_GRADIENT,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                              color: updateLand.waterId.value ==
                                                      waterResource.id
                                                  ? AppColor.DARK_GREEN
                                                  : AppColor.GREY_BORDER,
                                            ),
                                          ),
                                          child: Text(
                                            waterResource.name ?? "",
                                            style: GoogleFonts.poppins(
                                              color: AppColor.DARK_GREEN,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )),
                          InkWell(
                            onTap: () async {
                              updateLand.isWaterAvailable.value
                                  ? await updateLand.updateWaterResource()
                                  : await updateLand.updateWaterisAvailable();
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: Get.width * 0.5, top: 10),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                  horizontal: 40,
                                ),
                                decoration: ShapeDecoration(
                                  color: AppColor.DARK_GREEN,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: updateLand.waterloading.value
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        height: 15,
                                        width: 15,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : const Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Color(0xFFFBFBFB),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      )),
                          )
                        ],
                      ),
                    );
                  }),
                  Obx(() {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColor.GREY_BORDER),
                        boxShadow: [AppColor.BOX_SHADOW],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Is there space available for farmer accommodation?',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF272727),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                                450 ~/ 4,
                                (index) => Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : AppColor.GREY_BORDER,
                                        height: 1,
                                      ),
                                    )),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => RadioListTile<bool>(
                                    contentPadding: const EdgeInsets.all(0),
                                    activeColor: AppColor.DARK_GREEN,
                                    title: Text(
                                      'Available',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: true,
                                    groupValue: updateLand
                                        .isAccomodationAvailable.value,
                                    onChanged: (value) {
                                      updateLand.isAccomodationAvailable.value =
                                          value!;
                                      print(updateLand
                                          .isAccomodationAvailable.value);
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Obx(
                                  () => RadioListTile<bool>(
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Text(
                                      'Unavailable',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: false,
                                    activeColor: AppColor.DARK_GREEN,
                                    groupValue: updateLand
                                        .isAccomodationAvailable.value,
                                    onChanged: (value) {
                                      updateLand.isAccomodationAvailable.value =
                                          value!;
                                      print(updateLand
                                          .isAccomodationAvailable.value);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: updateLand.isAccomodationAvailable.value,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.GREY_BORDER),
                                boxShadow: [AppColor.BOX_SHADOW],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Form(
                                key: _accomodationKey,
                                child: TextFormField(
                                  controller:
                                      updateLand.accomodationController.value,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the value';
                                    }
                                    return "";
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 20),
                                      hintText: "What’s available?",
                                      hintStyle: GoogleFonts.poppins(
                                        color: const Color(0x994F4F4F),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 0.10,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              updateLand.isAccomodationAvailable.value
                                  ? _accomodationKey.currentState!.validate()
                                  : "";
                              updateLand.isAccomodationAvailable.value
                                  ? await updateLand
                                      .updateAccomodationAvailable()
                                  : await updateLand.isaccomodationAvailable();
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: Get.width * 0.5),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                  horizontal: 40,
                                ),
                                decoration: ShapeDecoration(
                                  color: AppColor.DARK_GREEN,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: updateLand.accomodationloading.value
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        height: 15,
                                        width: 15,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : const Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Color(0xFFFBFBFB),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      )),
                          )
                        ],
                      ),
                    );
                  }),
                  Obx(() {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColor.GREY_BORDER),
                        boxShadow: [AppColor.BOX_SHADOW],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Do you have any equipment/machines available at your land for farming?',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF272727),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                                450 ~/ 4,
                                (index) => Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : AppColor.GREY_BORDER,
                                        height: 1,
                                      ),
                                    )),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => RadioListTile<bool>(
                                    contentPadding: const EdgeInsets.all(0),
                                    activeColor: AppColor.DARK_GREEN,
                                    title: Text(
                                      'Available',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: true,
                                    groupValue:
                                        updateLand.isEquipmentAvailable.value,
                                    onChanged: (value) {
                                      updateLand.isEquipmentAvailable.value =
                                          value!;
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Obx(
                                  () => RadioListTile<bool>(
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Text(
                                      'Unavailable',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: false,
                                    activeColor: AppColor.DARK_GREEN,
                                    groupValue:
                                        updateLand.isEquipmentAvailable.value,
                                    onChanged: (value) {
                                      updateLand.isEquipmentAvailable.value =
                                          value!;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: updateLand.isEquipmentAvailable.value,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.GREY_BORDER),
                                boxShadow: [AppColor.BOX_SHADOW],
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Form(
                                key: _equipmentKey,
                                child: TextFormField(
                                  controller:
                                      updateLand.equipmentController.value,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the value';
                                    }
                                    return "";
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 20),
                                      hintText: "What’s available?",
                                      hintStyle: GoogleFonts.poppins(
                                        color: const Color(0x994F4F4F),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 0.10,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              updateLand.isEquipmentAvailable.value
                                  ? _equipmentKey.currentState!.validate()
                                  : "";
                              updateLand.isEquipmentAvailable.value
                                  ? await updateLand.updateEquipmentAvailable()
                                  : await updateLand.isequipmentAvailable();
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: Get.width * 0.5),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                  horizontal: 40,
                                ),
                                decoration: ShapeDecoration(
                                  color: AppColor.DARK_GREEN,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: updateLand.equipmentloading.value
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        height: 15,
                                        width: 15,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : const Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Color(0xFFFBFBFB),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      )),
                          )
                        ],
                      ),
                    );
                  }),
                  Obx(() {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColor.GREY_BORDER),
                        boxShadow: [AppColor.BOX_SHADOW],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Did you farm on this land in the past?',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF272727),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                                450 ~/ 4,
                                (index) => Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : AppColor.GREY_BORDER,
                                        height: 1,
                                      ),
                                    )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => SizedBox(
                                  width: AppDimension.w * 0.4,
                                  child: RadioListTile<bool>(
                                    activeColor: AppColor.DARK_GREEN,
                                    title: Text(
                                      'Yes',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: true,
                                    groupValue: updateLand.isLandFarm.value,
                                    onChanged: (value) {
                                      updateLand.isLandFarm.value = value!;
                                    },
                                  ),
                                ),
                              ),
                              Obx(
                                () => Expanded(
                                  child: RadioListTile<bool>(
                                    title: Text(
                                      'No',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: false,
                                    activeColor: AppColor.DARK_GREEN,
                                    groupValue: updateLand.isLandFarm.value,
                                    onChanged: (value) {
                                      updateLand.isLandFarm.value = value!;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          updateLand.isLandFarm.value
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'What type of crops did you grew?',
                                      style: TextStyle(
                                        color: Color(0xFF272727),
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                    Obx(() {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: Wrap(
                                          spacing: 10,
                                          children: List.generate(
                                              cropSugestionController
                                                  .cropData
                                                  .value
                                                  .result!
                                                  .length, (index) {
                                            final cropId =
                                                cropSugestionController.cropData
                                                    .value.result![index].id;
                                            bool isSelected = cropId != null &&
                                                updateLand.crops
                                                    .contains(cropId.toInt());

                                            return InkWell(
                                              onTap: () {
                                                if (cropId != null) {
                                                  if (isSelected) {
                                                    updateLand.crops
                                                        .remove(cropId);
                                                  } else {
                                                    updateLand.crops
                                                        .add(cropId);
                                                  }
                                                }
                                              },
                                              child: AnimatedContainer(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    border: isSelected
                                                        ? Border.all(
                                                            color: AppColor
                                                                .DARK_GREEN)
                                                        : Border.all(
                                                            color: AppColor
                                                                .GREY_BORDER),
                                                    gradient: isSelected
                                                        ? AppColor
                                                            .PRIMARY_GRADIENT
                                                        : AppColor
                                                            .WHITE_GRADIENT),
                                                duration: const Duration(
                                                    milliseconds: 10),
                                                child: Text(
                                                    cropSugestionController
                                                        .cropData
                                                        .value
                                                        .result![index]
                                                        .name
                                                        .toString()),
                                              ),
                                            );
                                          }),
                                        ),
                                      );
                                    }),
                                  ],
                                )
                              : Container(),
                          InkWell(
                            onTap: () async {
                              updateLand.isLandFarm.value
                                  ? await updateLand.updateCropData()
                                  : await updateLand.updateCrop();
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: Get.width * 0.5),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                  horizontal: 40,
                                ),
                                decoration: ShapeDecoration(
                                  color: AppColor.DARK_GREEN,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: updateLand.croploading.value
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        height: 15,
                                        width: 15,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : const Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Color(0xFFFBFBFB),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      )),
                          )
                        ],
                      ),
                    );
                  }),
                  Obx(() {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColor.GREY_BORDER),
                        boxShadow: [AppColor.BOX_SHADOW],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Is there road access to the land?',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF272727),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                                450 ~/ 4,
                                (index) => Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : AppColor.GREY_BORDER,
                                        height: 1,
                                      ),
                                    )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => SizedBox(
                                  width: AppDimension.w * 0.4,
                                  child: RadioListTile<bool>(
                                    activeColor: AppColor.DARK_GREEN,
                                    title: Text(
                                      'Yes',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: true,
                                    groupValue:
                                        updateLand.isRoadAvailable.value,
                                    onChanged: (value) {
                                      updateLand.isRoadAvailable.value = value!;
                                    },
                                  ),
                                ),
                              ),
                              Obx(
                                () => Expanded(
                                  child: RadioListTile<bool>(
                                    title: Text(
                                      'No',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: false,
                                    activeColor: AppColor.DARK_GREEN,
                                    groupValue:
                                        updateLand.isRoadAvailable.value,
                                    onChanged: (value) {
                                      updateLand.isRoadAvailable.value = value!;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              await updateLand.roadAvailable();
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: Get.width * 0.5),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                  horizontal: 40,
                                ),
                                decoration: ShapeDecoration(
                                  color: AppColor.DARK_GREEN,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: updateLand.roadloading.value
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        height: 15,
                                        width: 15,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : const Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Color(0xFFFBFBFB),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      )),
                          )
                        ],
                      ),
                    );
                  }),
                  Obx(() {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColor.GREY_BORDER),
                        boxShadow: [AppColor.BOX_SHADOW],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Is this property certified organic, or does it qualify for organic certification under federal organic regulations?',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF272727),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                                450 ~/ 4,
                                (index) => Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : AppColor.GREY_BORDER,
                                        height: 1,
                                      ),
                                    )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => SizedBox(
                                  width: AppDimension.w * 0.4,
                                  child: RadioListTile<bool>(
                                    activeColor: AppColor.DARK_GREEN,
                                    title: Text(
                                      'Yes',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: true,
                                    groupValue: updateLand.isCertified.value,
                                    onChanged: (value) {
                                      updateLand.isCertified.value = value!;
                                    },
                                  ),
                                ),
                              ),
                              Obx(
                                () => Expanded(
                                  child: RadioListTile<bool>(
                                    title: Text(
                                      'No',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF333333),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: false,
                                    activeColor: AppColor.DARK_GREEN,
                                    groupValue: updateLand.isCertified.value,
                                    onChanged: (value) {
                                      updateLand.isCertified.value = value!;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          updateLand.isCertified.value
                              ? updateLand.selectedPdf.value != null
                                  ? Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            updateLand.pickPdf();
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              border: Border.all(
                                                  color: AppColor.GREY_BORDER),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: SvgPicture.asset(
                                                      "assets/logos/doc.svg",
                                                      width: 30,
                                                    )),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 20,
                                                      horizontal: 20),
                                                  child: Text(
                                                    updateLand.selectedPdf.value
                                                                ?.path !=
                                                            null
                                                        ? updateLand.selectedPdf
                                                            .value!.path
                                                            .split('/')
                                                            .last
                                                        : '',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF283037),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: InkWell(
                                            onTap: () {
                                              updateLand.removeCertificate();
                                            },
                                            child: Container(
                                              height: 28,
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromARGB(
                                                    255, 244, 67, 54),
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : InkWell(
                                      onTap: () {
                                        updateLand.pickPdf();
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          border: Border.all(
                                              color: AppColor.GREY_BORDER),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: SvgPicture.asset(
                                                  "assets/logos/doc.svg",
                                                  width: 30,
                                                )),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 10),
                                              child: Text(
                                                "Browse document\n",
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF283037),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 15),
                                              child: Text(
                                                "to Upload",
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF6E7B89),
                                                  fontSize: 10,
                                                  height: -0.07,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                              : Container(),
                          InkWell(
                            onTap: () async {
                              updateLand.isCertified.value
                                  ? await updateLand.selectedPDF()
                                  : await updateLand.certificationValue();
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: Get.width * 0.5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 40),
                              decoration: ShapeDecoration(
                                color: AppColor.DARK_GREEN,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: updateLand.pdfloading.value
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      height: 15,
                                      width: 15,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text(
                                      'Save',
                                      style: TextStyle(
                                        color: Color(0xFFFBFBFB),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  Obx(() {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColor.GREY_BORDER),
                        boxShadow: [AppColor.BOX_SHADOW],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Add up to 6 photos of your land.',
                            style: TextStyle(
                              color: Color(0xFF272727),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Added ${imageController.photos.length}/6',
                              style: const TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: imageController.photos.length < 6
                                ? imageController.photos.length + 1
                                : 6,
                            itemBuilder: (context, index) {
                              if (index < imageController.photos.length) {
                                return Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageController.photos[index]
                                                      .startsWith('http') ||
                                                  imageController.photos[index]
                                                      .startsWith('https')
                                              ? NetworkImage(
                                                  imageController.photos[index])
                                              : FileImage(File(imageController
                                                      .photos[index]))
                                                  as ImageProvider,
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
                                          imageController
                                              .deleteImageLocal(index);
                                        },
                                        child: Container(
                                          height: 28,
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(
                                                255, 244, 67, 54),
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (index ==
                                      imageController.photos.length &&
                                  index < 6) {
                                return Visibility(
                                  visible: imageController.photos.length < 6,
                                  child: InkWell(
                                    onTap: () {
                                      imageController.getImages();
                                    },
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      color: AppColor.DARK_GREEN,
                                      dashPattern: const [9, 4],
                                      radius: const Radius.circular(12),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Container(
                                          color: const Color(0x1E044D3A),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/logos/gallery.svg',
                                                  height: 24,
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  "Browse",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor.DARK_GREEN,
                                                  ),
                                                ),
                                                Text(
                                                  "Photos",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xFF73817B),
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
                          ),
                          InkWell(
                            onTap: () {
                              imageController.updateImg();

                              print(
                                  "Uploaded IDs: ${imageController.uploadedIds.value}");
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: Get.width * 0.5, top: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 40),
                              decoration: ShapeDecoration(
                                color: AppColor.DARK_GREEN,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: imageController.loading.value
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      height: 15,
                                      width: 15,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text(
                                      'Save',
                                      style: TextStyle(
                                        color: Color(0xFFFBFBFB),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ));
  }
}
