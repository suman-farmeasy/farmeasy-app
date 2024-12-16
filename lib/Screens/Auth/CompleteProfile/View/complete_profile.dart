import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/utils/Constants/string_constant.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/education_list_controller.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/land_owner_controller.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/profile_controller.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/update_profile_controller.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/View/education_list.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Controller/user_controller.dart';
import 'package:farm_easy/Screens/Partners/Controller/partner_services_controller.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final controller = Get.put(ProfileController());
  final landOwner = Get.put(LandOwnerController());
  final getProfileController = Get.put(GetProfileController());
  final agriController = Get.put(UserController());
  final farmerController = Get.put(UserController());
  final updateController = Get.put(UpdateProfileController());
  final educationController = Get.put(EducationListController());
  final serviceController = Get.put(PartnerServicesController());
  late TextEditingController _experienceController;
  // late TextEditingController _phoneController;
  String userRole = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData();
    getProfileController.getProfile();
    _experienceController = TextEditingController(
      text: getProfileController.getProfileData.value.result?.experience
              ?.toInt()
              .toString() ??
          "",
    );
    // _phoneController = TextEditingController(
    //   text: getProfileController.getProfileData.value.result?.mobile ?? "",
    // );

    ever(getProfileController.getProfileData, (_) {
      final profile = getProfileController.getProfileData.value.result;
      if (profile != null) {
        _experienceController.text =
            profile.experience?.toInt().toString() ?? "";
        //  _phoneController.text = profile.mobile ?? "";
        landOwner.select!.value =
            getProfileController.profileType.value == "Land Owner" ? 0 : 1;
      }
    });
    landOwner.select!.value =
        getProfileController.profileType.value == "Land Owner" ? 0 : 1;
    print(
        "==================================profile   ${getProfileController.profileType.value}");
  }

  void userData() async {
    userRole = await controller.prefs.getUserRole();
  }
  //
  // String getFlagEmoji(String countryCode) {
  //   if (countryCode.isEmpty) return '';
  //
  //   final int flagOffset = 0x1F1E6;
  //   final int asciiOffset = 0x41;
  //
  //   final int firstChar = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
  //   final int secondChar = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;
  //
  //   return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  // }

  @override
  void dispose() {
    _experienceController.dispose();
    // _phoneController.dispose();
    super.dispose();
  }

  var isCountrySelected = false.obs;

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColor.BACKGROUND,
        appBar: PreferredSize(
          preferredSize: isIOS
              ? Size.fromHeight(AppDimension.h * 0.095)
              : Size.fromHeight(AppDimension.h * 0.125),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  CupertinoIcons.back,
                  color: AppColor.BROWN_TEXT,
                  size: 25,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: AppDimension.h * 0.06,
                  ),
                  SvgPicture.asset(
                    ImageConstants.IMG_TEXT,
                    width: Get.width * 0.4,
                  ),
                  InkWell(
                    onTap: () {
                      print(
                          "=====================================${educationController.education.value}===========================");
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Please complete profile ",
                        style: GoogleFonts.poppins(
                          color: AppColor.BROWN_TEXT,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 40,
              )
            ],
          ),
        ),
        body: SingleChildScrollView(child: Obx(() {
          return getProfileController.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [AppColor.BOX_SHADOW]),
                          child: Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(() {
                                  // Check if the profile image is either null or an empty string, and no image file is selected
                                  bool noImageAvailable = (getProfileController
                                                  .getProfileData
                                                  .value
                                                  .result
                                                  ?.image ==
                                              null ||
                                          getProfileController.getProfileData
                                                  .value.result?.image ==
                                              "") &&
                                      controller.imageFile.value == null;

                                  if (noImageAvailable) {
                                    return InkWell(
                                      onTap: () {
                                        controller.openBottomSheet(context);
                                      },
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        color: Color(0xFF727272),
                                        dashPattern: [2, 4],
                                        radius: Radius.circular(12),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.14,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.14,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    CupertinoIcons
                                                        .profile_circled,
                                                    color: Colors.grey,
                                                    size: 35,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Capture or browse",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF73817B),
                                                    ),
                                                  ),
                                                  Text(
                                                    "to upload Image",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF73817B),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return controller.imageFile.value == null
                                        ? Stack(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  controller
                                                      .openBottomSheet(context);
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                        width: 2),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        getProfileController
                                                                .getProfileData
                                                                .value
                                                                .result
                                                                ?.image ??
                                                            "",
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: InkWell(
                                                  onTap: () {
                                                    controller
                                                        .deleteProfilePic();
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
                                                      color: Color.fromARGB(
                                                          255, 244, 67, 54),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Center(
                                            child: InkWell(
                                              onTap: () {
                                                controller
                                                    .openBottomSheet(context);
                                              },
                                              child: Container(
                                                height: Get.height * 0.15,
                                                width: Get.width * 0.32,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                    image: FileImage(controller
                                                        .imageFile.value!),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                  }
                                }),

                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 3),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColor.GREY_BORDER,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: TextFormField(
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.BROWN_TEXT),
                                            keyboardType: TextInputType.text,
                                            controller: TextEditingController(
                                              text: getProfileController
                                                      .getProfileData
                                                      .value
                                                      .result
                                                      ?.fullName ??
                                                  "",
                                            ),
                                            onChanged: (value) {
                                              getProfileController
                                                  .getProfileData
                                                  .value
                                                  .result
                                                  ?.fullName = value;
                                              updateController.newName.value =
                                                  value;
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Enter Full Name ",
                                              hintStyle: GoogleFonts.poppins(
                                                color: Color(0xFF757575),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
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
                                            'Please make sure it matches the name on your Govt. ID',
                                            style: GoogleFonts.poppins(
                                              color: AppColor.BROWN_SUBTEXT,
                                              fontSize: 8,
                                              fontStyle: FontStyle.italic,
                                              height: 2,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),

                                // Container(
                                //   margin: EdgeInsets.only(bottom: 10),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(5),
                                //     border: Border.all(
                                //       color: AppColor.GREY_BORDER,
                                //       width: 1,
                                //     ),
                                //   ),
                                //   child: Obx(() {
                                //     return InkWell(
                                //       onTap: () {
                                //         getProfileController.selectCountry();
                                //       },
                                //       child: Row(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.center,
                                //         children: [
                                //           Obx(() {
                                //             return Center(
                                //               child: Container(
                                //                 margin: EdgeInsets.symmetric(
                                //                     horizontal: 5),
                                //                 height: 30,
                                //                 child: Center(
                                //                   child: Text(
                                //                     getProfileController
                                //                                     .getProfileData
                                //                                     .value
                                //                                     .result
                                //                                     ?.countryCode ==
                                //                                 "" ||
                                //                             getProfileController
                                //                                     .countryCode
                                //                                     .value ==
                                //                                 ""
                                //                         ? " + ${getProfileController.countryCode.value} ${getProfileController.getProfileData.value.result?.countryCode ?? ""}"
                                //                         : " + ${getProfileController.countryCode.value}",
                                //                     style: TextStyle(
                                //                       color: Color(0xFF4F4F4F),
                                //                       fontSize: 14,
                                //                       fontFamily: 'Poppins',
                                //                       fontWeight:
                                //                           FontWeight.w500,
                                //                       height: 0.09,
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //             );
                                //           }),
                                //           getProfileController
                                //                           .getProfileData
                                //                           .value
                                //                           .result
                                //                           ?.mobile ==
                                //                       "" &&
                                //                   getProfileController
                                //                           .countryCode.value ==
                                //                       ""
                                //               ? Container(
                                //                   margin: EdgeInsets.symmetric(
                                //                       vertical: 15),
                                //                   width: Get.width * 0.68,
                                //                   child: Row(
                                //                     children: [
                                //                       Container(
                                //                         margin: EdgeInsets.only(
                                //                             left: 10,
                                //                             right: 50),
                                //                         height: 30,
                                //                         width: 1.4,
                                //                         color: Colors.grey,
                                //                       ),
                                //                       Center(
                                //                           child: Text(
                                //                               "Phone Number")),
                                //                     ],
                                //                   ),
                                //                 )
                                //               : Container(
                                //                   width: Get.width * 0.68,
                                //                   child: Row(
                                //                     crossAxisAlignment:
                                //                         CrossAxisAlignment
                                //                             .center,
                                //                     children: [
                                //                       Container(
                                //                         height: 30,
                                //                         width: 2,
                                //                         color: Colors.grey,
                                //                       ),
                                //                       Center(
                                //                         child: Container(
                                //                           width:
                                //                               Get.width * 0.64,
                                //                           child: TextFormField(
                                //                             controller:
                                //                                 _phoneController,
                                //                             keyboardType:
                                //                                 TextInputType
                                //                                     .number,
                                //                             onChanged: (value) {
                                //                               getProfileController
                                //                                   .getProfileData
                                //                                   .value
                                //                                   .result
                                //                                   ?.mobile = value;
                                //                             },
                                //                             decoration:
                                //                                 InputDecoration(
                                //                               border:
                                //                                   InputBorder
                                //                                       .none,
                                //                               hintText:
                                //                                   "Phone number",
                                //                               hintStyle:
                                //                                   GoogleFonts
                                //                                       .poppins(
                                //                                 color: Color(
                                //                                     0xFF757575),
                                //                                 fontSize: 14,
                                //                                 fontWeight:
                                //                                     FontWeight
                                //                                         .w500,
                                //                                 height: 0.10,
                                //                               ),
                                //                               contentPadding:
                                //                                   EdgeInsets
                                //                                       .symmetric(
                                //                                 horizontal: 10,
                                //                                 vertical: 15,
                                //                               ),
                                //                             ),
                                //                           ),
                                //                         ),
                                //                       ),
                                //                     ],
                                //                   ),
                                //                 )
                                //         ],
                                //       ),
                                //     );
                                //   }),
                                // ),
                                Obx(() {
                                  return getProfileController.getProfileData
                                              .value.result?.mobile ==
                                          ""
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            print(
                                                "NUMBER ${getProfileController.getProfileData.value.result?.countryCode}");
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 14, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: AppColor.GREY_BORDER,
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  " + ${getProfileController.getProfileData.value.result?.countryCode}  ",
                                                  style: TextStyle(
                                                    color: Color(0xFF4F4F4F),
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  getProfileController
                                                          .getProfileData
                                                          .value
                                                          .result
                                                          ?.mobile ??
                                                      "",
                                                  style: TextStyle(
                                                    color: Color(0xFF4F4F4F),
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0.09,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                }),

                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.GREY_BORDER),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Obx(() {
                                    return Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: SvgPicture.asset(
                                          "assets/logos/house.svg",
                                          width: 30,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${getProfileController.getProfileData.value.result?.livesIn ?? ""}",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF757575),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ]);
                                  }),
                                ),

                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 3),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.GREY_BORDER,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: TextEditingController(
                                          text: getProfileController
                                                  .getProfileData
                                                  .value
                                                  .result
                                                  ?.bio ??
                                              "",
                                        ),
                                        onChanged: (value) {
                                          getProfileController.getProfileData
                                              .value.result?.bio = value;
                                          updateController.bio.value = value;
                                        },
                                        maxLines: 4,
                                        decoration: InputDecoration(
                                          hintText:
                                              "Tell us a bit about yourself...",
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          hintStyle: GoogleFonts.poppins(
                                            color: Color(0xFF757575),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        // },
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 3),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.GREY_BORDER,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,

                                        controller: TextEditingController(
                                          text: getProfileController
                                                  .getProfileData
                                                  .value
                                                  .result
                                                  ?.instagramUrl ??
                                              "",
                                        ),
                                        onChanged: (value) {
                                          getProfileController
                                              .getProfileData
                                              .value
                                              .result
                                              ?.instagramUrl = value;
                                          updateController.insta.value = value;
                                        },

                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(top: 10),
                                          prefixIcon: Container(
                                            width: 20,
                                            height: 20,
                                            padding: EdgeInsets.all(5),
                                            child: SvgPicture.asset(
                                              "assets/logos/insta.svg",
                                            ),
                                          ),
                                          hintText: "Link your Instagram",
                                          hintStyle: GoogleFonts.poppins(
                                            color: Color(0xFF757575),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        // },
                                      )),
                                ),

                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 3),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.GREY_BORDER,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,

                                        controller: TextEditingController(
                                          text: getProfileController
                                                  .getProfileData
                                                  .value
                                                  .result
                                                  ?.linkdinUrl ??
                                              "",
                                        ),
                                        onChanged: (value) {
                                          getProfileController.getProfileData
                                              .value.result?.linkdinUrl = value;
                                          updateController.linkdin.value =
                                              value;
                                        },

                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(top: 10),
                                          prefixIcon: Container(
                                            width: 20,
                                            height: 20,
                                            padding: EdgeInsets.all(5),
                                            child: SvgPicture.asset(
                                              "assets/logos/linkdin.svg",
                                            ),
                                          ),
                                          hintText: "Link your Linkedin",
                                          hintStyle: GoogleFonts.poppins(
                                            color: Color(0xFF757575),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        // },
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 3),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.GREY_BORDER,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: TextEditingController(
                                          text: getProfileController
                                                  .getProfileData
                                                  .value
                                                  .result
                                                  ?.facebookUrl ??
                                              "",
                                        ),
                                        onChanged: (value) {
                                          getProfileController
                                              .getProfileData
                                              .value
                                              .result
                                              ?.facebookUrl = value;
                                          updateController.fb.value = value;
                                        },

                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(top: 10),
                                          prefixIcon: Container(
                                            width: 20,
                                            height: 20,
                                            padding: EdgeInsets.all(5),
                                            child: SvgPicture.asset(
                                              "assets/logos/fb.svg",
                                            ),
                                          ),
                                          hintText: "Link your Facebook",
                                          hintStyle: GoogleFonts.poppins(
                                            color: Color(0xFF757575),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        // },
                                      )),
                                ),

                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 3),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.GREY_BORDER,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: TextEditingController(
                                          text: getProfileController
                                                  .getProfileData
                                                  .value
                                                  .result
                                                  ?.twitterUrl ??
                                              "",
                                        ),
                                        onChanged: (value) {
                                          getProfileController.getProfileData
                                              .value.result?.twitterUrl = value;
                                          updateController.twitter.value =
                                              value;
                                        },

                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(top: 10),
                                          prefixIcon: Container(
                                            width: 20,
                                            height: 20,
                                            padding: EdgeInsets.all(5),
                                            child: SvgPicture.asset(
                                              "assets/logos/twitter.svg",
                                            ),
                                          ),
                                          hintText: "Link your Twitter",
                                          hintStyle: GoogleFonts.poppins(
                                            color: Color(0xFF757575),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        // },
                                      )),
                                ),

                                ///FOR_LAND_OWNER

                                userRole == StringConstatnt.LANDOWNER
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              getProfileController
                                                  .getProfileData
                                                  .value
                                                  .result
                                                  ?.education = "";
                                              Get.to(() => EducationList());
                                            },
                                            child: Container(
                                              height: Get.height * 0.069,
                                              margin: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          AppColor.GREY_BORDER),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Icon(
                                                    Icons.school_outlined,
                                                    color: Color(0xFF757575),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Obx(() {
                                                    if (getProfileController
                                                            .getProfileData
                                                            .value
                                                            .result
                                                            ?.education ==
                                                        "") {
                                                    } else {
                                                      educationController
                                                              .education.value =
                                                          getProfileController
                                                              .getProfileData
                                                              .value
                                                              .result!
                                                              .education!;
                                                    }
                                                    return Text(
                                                      educationController
                                                                  .education
                                                                  .value ==
                                                              ""
                                                          ? "Enter Education"
                                                          : educationController
                                                              .education.value,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            Color(0xFF757575),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ]),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Text(
                                                '   What defines you best?',
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.poppins(
                                                  color: AppColor.BROWN_TEXT,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: -0.14,
                                                )),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5),
                                            height: Get.height * 0.12,
                                            child: ListView.builder(
                                                itemCount:
                                                    landOwner.title.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      if (landOwner
                                                              .select!.value ==
                                                          index) {
                                                        landOwner
                                                            .select!.value = -1;
                                                      } else {
                                                        // getProfileController.getProfileData.value.result?.profileType=="Land Owner"?index=0:index=1 ;
                                                        landOwner.select!
                                                            .value = index;
                                                        landOwner.userProfieType
                                                                .value =
                                                            landOwner
                                                                .title[index];
                                                      }
                                                      setState(() {});
                                                      print(
                                                          "=====================================${landOwner.userProfieType.value}===========================");
                                                    },
                                                    child: Obx(() {
                                                      return Stack(
                                                        children: [
                                                          AnimatedContainer(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            width: Get.width *
                                                                0.37,
                                                            decoration:
                                                                ShapeDecoration(
                                                              gradient: landOwner
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
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                microseconds:
                                                                    2),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  landOwner
                                                                          .title[
                                                                      index],
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: AppColor
                                                                        .DARK_GREEN,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    height: 0,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  landOwner
                                                                          .subtitle[
                                                                      index],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: AppColor
                                                                        .GREEN_SUBTEXT,
                                                                    fontSize: 9,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: 0,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Positioned(
                                                              top: Get.height *
                                                                  0.09,
                                                              left: Get.width *
                                                                  0.34,
                                                              child: Icon(
                                                                Icons
                                                                    .task_alt_outlined,
                                                                size: 18,
                                                                color: landOwner
                                                                            .select ==
                                                                        index
                                                                    ? AppColor
                                                                        .DARK_GREEN
                                                                    : Colors
                                                                        .transparent,
                                                              ))
                                                        ],
                                                      );
                                                    }),
                                                  );
                                                }),
                                          ),
                                          Obx(() {
                                            return landOwner.select!.value == -1
                                                ? Container(
                                                    margin: EdgeInsets.only(
                                                        top: 15),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 16),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color(0x19044D3A),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Proceed",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFFA0A6A3),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : landOwner.userProfieType
                                                            .value ==
                                                        ""
                                                    ? InkWell(
                                                        onTap: () {
                                                          print(
                                                              "EDUCATION ID: ${educationController.educationId.value}");
                                                          updateController
                                                              .updateLandOwnerProfile(
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.fullName ??
                                                                "",
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.bio ??
                                                                "",
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.profileType ??
                                                                "",
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.mobile ??
                                                                "",
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.instagramUrl ??
                                                                "",
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.facebookUrl ??
                                                                "",
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.twitterUrl ??
                                                                "",
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.linkdinUrl ??
                                                                "",
                                                            educationController
                                                                .educationId
                                                                .value,
                                                          );
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 15),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 16),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Proceed",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          updateController.updateLandOwnerProfile(
                                                              getProfileController
                                                                      .getProfileData
                                                                      .value
                                                                      .result
                                                                      ?.fullName ??
                                                                  "",
                                                              getProfileController
                                                                      .getProfileData
                                                                      .value
                                                                      .result
                                                                      ?.bio ??
                                                                  "",
                                                              landOwner
                                                                  .userProfieType
                                                                  .value,
                                                              getProfileController
                                                                      .getProfileData
                                                                      .value
                                                                      .result
                                                                      ?.mobile ??
                                                                  "",
                                                              getProfileController
                                                                      .getProfileData
                                                                      .value
                                                                      .result
                                                                      ?.instagramUrl ??
                                                                  "",
                                                              getProfileController
                                                                      .getProfileData
                                                                      .value
                                                                      .result
                                                                      ?.facebookUrl ??
                                                                  "",
                                                              getProfileController
                                                                      .getProfileData
                                                                      .value
                                                                      .result
                                                                      ?.twitterUrl ??
                                                                  "",
                                                              getProfileController
                                                                      .getProfileData
                                                                      .value
                                                                      .result
                                                                      ?.linkdinUrl ??
                                                                  "",
                                                              educationController
                                                                  .educationId
                                                                  .value);
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 15),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 16),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Proceed",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                          })
                                        ],
                                      )
                                    : userRole == StringConstatnt.AGRI_PROVIDER
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // Container(
                                              //   margin: EdgeInsets.symmetric(
                                              //       vertical: 10),
                                              //   child: Container(
                                              //       padding:
                                              //           EdgeInsets.symmetric(
                                              //               vertical: 3),
                                              //       decoration: BoxDecoration(
                                              //           border: Border.all(
                                              //               color: AppColor
                                              //                   .GREY_BORDER,
                                              //               width: 1),
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(5)),
                                              //       child: TextFormField(
                                              //         keyboardType:
                                              //             TextInputType.number,
                                              //         controller:
                                              //             _experienceController,
                                              //         // TextEditingController(
                                              //         //   text: getProfileController
                                              //         //       .getProfileData
                                              //         //       .value
                                              //         //       .result
                                              //         //       ?.experience
                                              //         //       ?.toInt()
                                              //         //       .toString() ??
                                              //         //       "",
                                              //         // ),
                                              //         onChanged: (value) {
                                              //           int? parsedValue =
                                              //               int.tryParse(
                                              //                   value); // Parse the string to an integer
                                              //           getProfileController
                                              //                   .getProfileData
                                              //                   .value
                                              //                   .result
                                              //                   ?.experience =
                                              //               parsedValue;
                                              //           updateController
                                              //                   .experience
                                              //                   .value =
                                              //               parsedValue!;
                                              //         },
                                              //
                                              //         decoration:
                                              //             InputDecoration(
                                              //           contentPadding:
                                              //               EdgeInsets
                                              //                   .symmetric(
                                              //                       horizontal:
                                              //                           15),
                                              //           hintText: "Experience",
                                              //           hintStyle:
                                              //               GoogleFonts.poppins(
                                              //             color:
                                              //                 Color(0xFF757575),
                                              //             fontSize: 14,
                                              //             fontWeight:
                                              //                 FontWeight.w500,
                                              //           ),
                                              //           border:
                                              //               InputBorder.none,
                                              //         ),
                                              //         // },
                                              //       )),
                                              // ),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'Select Services(s) ',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            Color(0xFF272727),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: '(5 Max)',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            Color(0xFF61646B),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: '*',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            Color(0xFFEB5757),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' ',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF272727),
                                                        fontSize: 14,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Obx(() {
                                                if (serviceController
                                                    .loading.value) {
                                                  return Center(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 180.0),
                                                    child:
                                                        CircularProgressIndicator(
                                                      color:
                                                          AppColor.DARK_GREEN,
                                                    ),
                                                  ));
                                                } else if (serviceController
                                                        .rxRequestStatus
                                                        .value ==
                                                    Status.SUCCESS) {
                                                  return Wrap(
                                                    spacing: 8.0,
                                                    runSpacing: 8.0,
                                                    children: List.generate(
                                                      serviceController
                                                              .servicesData
                                                              .value
                                                              .result
                                                              ?.length ??
                                                          0,
                                                      (index) {
                                                        bool isSelected =
                                                            getProfileController
                                                                .agriRolesList
                                                                .contains(serviceController
                                                                    .servicesData
                                                                    .value
                                                                    .result![
                                                                        index]
                                                                    .id);
                                                        return InkWell(
                                                            onTap: () {
                                                              if (isSelected) {
                                                                getProfileController
                                                                    .agriRolesList
                                                                    .remove(serviceController
                                                                        .servicesData
                                                                        .value
                                                                        .result![
                                                                            index]
                                                                        .id);
                                                              } else {
                                                                if (getProfileController
                                                                        .agriRolesList
                                                                        .length <
                                                                    5) {
                                                                  getProfileController
                                                                      .agriRolesList
                                                                      .add(serviceController
                                                                          .servicesData
                                                                          .value
                                                                          .result![
                                                                              index]
                                                                          .id);
                                                                } else {}
                                                              }
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          15),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                  border: Border.all(
                                                                      color: AppColor
                                                                          .DARK_GREEN),
                                                                  gradient: isSelected
                                                                      ? AppColor
                                                                          .PRIMARY_GRADIENT
                                                                      : AppColor
                                                                          .WHITE_GRADIENT),
                                                              child: Text(
                                                                serviceController
                                                                    .servicesData
                                                                    .value
                                                                    .result![
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: AppColor
                                                                      .DARK_GREEN,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ));
                                                      },
                                                    ),
                                                  );
                                                } else if (serviceController
                                                        .rxRequestStatus
                                                        .value ==
                                                    Status.ERROR) {
                                                  return Text("Fetching Data");
                                                } else {
                                                  return Container();
                                                }
                                              }),
                                              Obx(() {
                                                if (getProfileController
                                                    .agriRolesList.isEmpty) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        top: 40),
                                                    height:
                                                        AppDimension.h * 0.07,
                                                    width:
                                                        AppDimension.w * 0.85,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color(0x19044D3A),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Proceed",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFFA0A6A3),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return InkWell(
                                                    onTap: () async {
                                                      await updateController.updateAgriServiceDetails(
                                                          getProfileController
                                                                  .getProfileData
                                                                  .value
                                                                  .result
                                                                  ?.fullName ??
                                                              "",
                                                          getProfileController
                                                              .agriRolesList,
                                                          getProfileController
                                                                  .getProfileData
                                                                  .value
                                                                  .result
                                                                  ?.bio ??
                                                              "",
                                                          getProfileController
                                                                  .getProfileData
                                                                  .value
                                                                  .result
                                                                  ?.mobile ??
                                                              "",
                                                          getProfileController
                                                                  .getProfileData
                                                                  .value
                                                                  .result
                                                                  ?.instagramUrl ??
                                                              "",
                                                          getProfileController
                                                                  .getProfileData
                                                                  .value
                                                                  .result
                                                                  ?.facebookUrl ??
                                                              "",
                                                          getProfileController
                                                                  .getProfileData
                                                                  .value
                                                                  .result
                                                                  ?.twitterUrl ??
                                                              "",
                                                          getProfileController
                                                                  .getProfileData
                                                                  .value
                                                                  .result
                                                                  ?.linkdinUrl ??
                                                              "",
                                                          updateController
                                                              .experience
                                                              .value);

                                                      // print("========================================${getProfileController.agriRolesList}");
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 20),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 16),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            AppColor.DARK_GREEN,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Proceed",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }),
                                            ],
                                          )
                                        : userRole == StringConstatnt.FARMER
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      getProfileController
                                                          .getProfileData
                                                          .value
                                                          .result
                                                          ?.education = "";
                                                      Get.to(() =>
                                                          EducationList());
                                                    },
                                                    child: Container(
                                                      height:
                                                          Get.height * 0.069,
                                                      margin: EdgeInsets.only(
                                                          top: 10, bottom: 10),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColor
                                                                  .GREY_BORDER),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Row(children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Icon(
                                                            Icons
                                                                .school_outlined,
                                                            color: Color(
                                                                0xFF757575),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Obx(() {
                                                            if (getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.education ==
                                                                "") {
                                                            } else {
                                                              educationController
                                                                      .education
                                                                      .value =
                                                                  getProfileController
                                                                      .getProfileData
                                                                      .value
                                                                      .result!
                                                                      .education!;
                                                            }
                                                            return Text(
                                                              educationController
                                                                          .education
                                                                          .value ==
                                                                      ""
                                                                  ? "Enter Education"
                                                                  : educationController
                                                                      .education
                                                                      .value,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Color(
                                                                    0xFF757575),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  // Container(
                                                  //   margin: EdgeInsets
                                                  //       .symmetric(
                                                  //           vertical: 10),
                                                  //   child: Container(
                                                  //       padding: EdgeInsets
                                                  //           .symmetric(
                                                  //               vertical:
                                                  //                   3),
                                                  //       decoration: BoxDecoration(
                                                  //           border: Border.all(
                                                  //               color: AppColor
                                                  //                   .GREY_BORDER,
                                                  //               width: 1),
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(
                                                  //                       5)),
                                                  //       child:
                                                  //           TextFormField(
                                                  //         keyboardType:
                                                  //             TextInputType
                                                  //                 .number,
                                                  //         controller:
                                                  //             TextEditingController(
                                                  //           text: getProfileController
                                                  //                   .getProfileData
                                                  //                   .value
                                                  //                   .result
                                                  //                   ?.experience
                                                  //                   ?.toInt()
                                                  //                   .toString() ??
                                                  //               "",
                                                  //         ),
                                                  //         onChanged:
                                                  //             (value) {
                                                  //           int?
                                                  //               parsedValue =
                                                  //               int.tryParse(
                                                  //                   value); // Parse the string to an integer
                                                  //           getProfileController
                                                  //                   .getProfileData
                                                  //                   .value
                                                  //                   .result
                                                  //                   ?.experience =
                                                  //               parsedValue;
                                                  //           updateController
                                                  //                   .experience
                                                  //                   .value =
                                                  //               parsedValue!;
                                                  //         },
                                                  //
                                                  //         decoration:
                                                  //             InputDecoration(
                                                  //           contentPadding:
                                                  //               EdgeInsets.symmetric(
                                                  //                   horizontal:
                                                  //                       15),
                                                  //           hintText:
                                                  //               "Experience",
                                                  //           hintStyle:
                                                  //               GoogleFonts
                                                  //                   .poppins(
                                                  //             color: Color(
                                                  //                 0xFF757575),
                                                  //             fontSize: 14,
                                                  //             fontWeight:
                                                  //                 FontWeight
                                                  //                     .w500,
                                                  //           ),
                                                  //           border:
                                                  //               InputBorder
                                                  //                   .none,
                                                  //         ),
                                                  //         // },
                                                  //       )),
                                                  // ),
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              'Select Experties ',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Color(
                                                                0xFF272727),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: '*',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Color(
                                                                0xFFEB5757),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: ' ',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF272727),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Obx(() {
                                                    if (farmerController
                                                        .farmerLoading.value) {
                                                      return CircularProgressIndicator();
                                                    } else if (farmerController
                                                            .rxRequestStatusFarmerExperties
                                                            .value ==
                                                        Status.SUCCESS) {
                                                      return Wrap(
                                                        spacing: 8.0,
                                                        runSpacing: 8.0,
                                                        children: List.generate(
                                                          farmerController
                                                                  .farmerExpertiesData
                                                                  .value
                                                                  .result
                                                                  ?.length ??
                                                              0,
                                                          (index) {
                                                            final id =
                                                                farmerController
                                                                    .farmerExpertiesData
                                                                    .value
                                                                    .result![
                                                                        index]
                                                                    .id;
                                                            bool isSelected = id !=
                                                                    null &&
                                                                getProfileController
                                                                    .farmerExpertiseList
                                                                    .contains(
                                                                        id);
                                                            return InkWell(
                                                              onTap: () {
                                                                if (id !=
                                                                    null) {
                                                                  if (isSelected) {
                                                                    getProfileController
                                                                        .farmerExpertiseList
                                                                        .remove(
                                                                            id);
                                                                  } else {
                                                                    getProfileController
                                                                        .farmerExpertiseList
                                                                        .add(
                                                                            id);
                                                                  }
                                                                }
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            8,
                                                                        horizontal:
                                                                            15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                  border: Border.all(
                                                                      color: AppColor
                                                                          .DARK_GREEN),
                                                                  gradient: isSelected
                                                                      ? AppColor
                                                                          .PRIMARY_GRADIENT
                                                                      : AppColor
                                                                          .WHITE_GRADIENT,
                                                                ),
                                                                child: Text(
                                                                  farmerController
                                                                      .farmerExpertiesData
                                                                      .value
                                                                      .result![
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: AppColor
                                                                        .DARK_GREEN,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    } else if (farmerController
                                                            .rxRequestStatusFarmerExperties
                                                            .value ==
                                                        Status.ERROR) {
                                                      return Text(
                                                          'fetching data');
                                                    } else {
                                                      return Container();
                                                    }
                                                  }),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 18.0,
                                                            bottom: 10),
                                                    child: Text(
                                                      'Experience',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13,
                                                              color: AppColor
                                                                  .BROWN_TEXT),
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Dialog(
                                                              child: Container(
                                                                height: 400,
                                                                child: ListView
                                                                    .builder(
                                                                  itemCount:
                                                                      updateController
                                                                          .years
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return ListTile(
                                                                      title: Text(updateController
                                                                          .years[
                                                                              index]
                                                                          .toString()),
                                                                      onTap:
                                                                          () {
                                                                        updateController
                                                                            .selectedYear
                                                                            .value = updateController
                                                                                .years[
                                                                            index];

                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }, child: Obx(() {
                                                        return Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      30),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFE3E3E3)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Center(
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  updateController
                                                                              .selectedYear
                                                                              .value ==
                                                                          0
                                                                      ? "  Year            "
                                                                      : "  ${updateController.selectedYear.value}  Years ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColor
                                                                          .BROWN_SUBTEXT),
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_outlined,
                                                                  color: AppColor
                                                                      .BROWN_SUBTEXT,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      })),
                                                      GestureDetector(
                                                          onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Dialog(
                                                              child: Container(
                                                                height:
                                                                    400, // Adjust the height as needed

                                                                child: ListView
                                                                    .builder(
                                                                  itemCount:
                                                                      updateController
                                                                          .months
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return ListTile(
                                                                      title: Text(updateController
                                                                          .months[
                                                                              index]
                                                                          .toString()),
                                                                      onTap:
                                                                          () {
                                                                        updateController
                                                                            .selectedMonths
                                                                            .value = updateController
                                                                                .months[
                                                                            index];

                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }, child: Obx(() {
                                                        return Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      30),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFE3E3E3)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Center(
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  updateController
                                                                              .selectedMonths
                                                                              .value ==
                                                                          0
                                                                      ? "  Months        "
                                                                      : "${updateController.selectedMonths.value} Months ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColor
                                                                          .BROWN_SUBTEXT),
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_outlined,
                                                                  color: AppColor
                                                                      .BROWN_SUBTEXT,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      })),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 18.0),
                                                    child: Text(
                                                      'Expected Monthly Salary Range(INR)',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13,
                                                              color: AppColor
                                                                  .BROWN_TEXT),
                                                    ),
                                                  ),
                                                  Obx(() {
                                                    return RangeSlider(
                                                      values: RangeValues(
                                                        updateController
                                                            .minSalary.value,
                                                        updateController
                                                            .maxSalary.value,
                                                      ),
                                                      min: 0,
                                                      max: 100000,
                                                      divisions: 1000,
                                                      labels: RangeLabels(
                                                        updateController
                                                            .minSalary.value
                                                            .round()
                                                            .toString(),
                                                        updateController
                                                            .maxSalary.value
                                                            .round()
                                                            .toString(),
                                                      ),
                                                      onChanged:
                                                          (RangeValues values) {
                                                        updateController
                                                            .setMinSalary(
                                                                values.start);
                                                        updateController
                                                            .setMaxSalary(
                                                                values.end);
                                                      },
                                                    );
                                                  }),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'INR 10000',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 10,
                                                                  color: Color(
                                                                      0xFF9299B5)),
                                                        ),
                                                        Text(
                                                          'INR 100000',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 10,
                                                                  color: Color(
                                                                      0xFF9299B5)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Obx(() {
                                                  //   return Text(
                                                  //     'Min Salary: ${updateController.minSalary.value.round()}',
                                                  //   );
                                                  // }),
                                                  // Obx(() {
                                                  //   return Text(
                                                  //     'Max Salary: ${updateController.maxSalary.value.round()}',
                                                  //   );
                                                  // }),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Obx(() {
                                                        return Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                          child:
                                                              CheckboxListTile(
                                                            value:
                                                                updateController
                                                                    .isChecked
                                                                    .value,
                                                            onChanged: (value) {
                                                              updateController
                                                                  .toggleCheckbox();
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                      Container(
                                                          width:
                                                              Get.width * 0.75,
                                                          child: Text(
                                                            "Don’t show monthly expected salary on my profile",
                                                            style: GoogleFonts.poppins(
                                                                color: AppColor
                                                                    .BROWN_TEXT,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                          ))
                                                    ],
                                                  ),

                                                  Obx(() {
                                                    if (getProfileController
                                                        .farmerExpertiseList
                                                        .isEmpty) {
                                                      return InkWell(
                                                        onTap: () {
                                                          print(
                                                              "==================================${getProfileController.farmerExpertiseList}============");
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 40),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 16),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Color(
                                                                0x19044D3A),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Proceed",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Color(
                                                                    0xFFA0A6A3),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return InkWell(
                                                        onTap: () {
                                                          print(
                                                              "EDUCATION ID e${educationController.educationId.value}");
                                                          updateController
                                                              .updateFarmerDetails(
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.fullName ??
                                                                "",
                                                            getProfileController
                                                                .farmerExpertiseList,
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.bio ??
                                                                "",
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.mobile ??
                                                                "",
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.instagramUrl ??
                                                                "",
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.facebookUrl ??
                                                                "",
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.twitterUrl ??
                                                                "",
                                                            getProfileController
                                                                    .getProfileData
                                                                    .value
                                                                    .result
                                                                    ?.linkdinUrl ??
                                                                "",
                                                            educationController
                                                                .educationId
                                                                .value,
                                                            updateController
                                                                .experience
                                                                .value,
                                                            updateController
                                                                .selectedYear
                                                                .value,
                                                            updateController
                                                                .selectedMonths
                                                                .value,
                                                            updateController
                                                                .minSalary.value
                                                                .toInt(),
                                                            updateController
                                                                .maxSalary.value
                                                                .toInt(),
                                                            updateController
                                                                .isChecked
                                                                .value,
                                                          );
                                                          // print("================================${ getProfileController.getProfileData.value.result?.fullName}");
                                                          print(
                                                              "================================${getProfileController.farmerExpertiseList}");
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 20),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 16),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Proceed",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }),
                                                ],
                                              )
                                            : Container()
                              ],
                            );
                          }))
                    ],
                  ),
                );
        })),
      ),
    );
  }
}
