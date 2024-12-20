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

import '../../LandDetails/View/land_details.dart';

class KindOfCrop extends StatefulWidget {
  KindOfCrop({
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
  State<KindOfCrop> createState() => _KindOfCropState();
}

class _KindOfCropState extends State<KindOfCrop> {
  final controller = Get.put(EditLandController());
  final _formKey = GlobalKey<FormState>();
  final _landSize = GlobalKey<FormState>();
  final _landlease = GlobalKey<FormState>();
  final _landTitle = GlobalKey<FormState>();
  final chatgptCropController = Get.put(ChatGPTCropSuggestionController());
  final otherCropController = Get.put(ListOthersCropController());
  final landTypeController = Get.put(ListLandTypeController());
  final updateLand = Get.put(UpdateLandDetailsController());
  // final waterController = Get.put(WaterResourceController());
  // final cropSugestionController = Get.find<CropSuggestionController>();

  final _accomodationKey = GlobalKey<FormState>();
  final _equipmentKey = GlobalKey<FormState>();
  final imageController = Get.put(ImageController());
  // final getLandData = Get.find<LandInfoController>();
  @override
  void initState() {
    super.initState();
    setState(() {
      controller.landTitleController.value.text = widget.nickName;
      controller.landTitle.value = widget.nickName;
      // controller.selectedPurposeName.value = widget.purposeName;
      controller.selectedPurposeid.value = widget.purposeId;
      controller.landlease.value.text = widget.leaseDuration;
      controller.selectedleaseUinit.value = widget.leaseDurationType;
      controller.lease_type.value = widget.leaseType;

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
      updateLand.isAccomodationAvailable.value =
          widget.isAccommodationAvailable;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return controller.iscropAdded.value
                        ? controller.isCropValue.value == false
                            ? Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        controller.isCropValue.value = false;
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
                                ),
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.9,
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
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
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 500),
                                                      () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              LandDetails(
                                                            id: widget.landId,
                                                          ),
                                                        ));
                                                  });
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
                                    onPressed: () {
                                      controller.cropAdd;
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LandDetails(
                                                id: widget.landId,
                                              ),
                                            ));
                                      });
                                    },
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
                ],
              ),
            ),
          ),
        ));
  }
}
