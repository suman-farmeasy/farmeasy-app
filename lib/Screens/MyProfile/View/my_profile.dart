import 'dart:convert';
import 'dart:developer';

import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/utils/Constants/image_constant.dart';
import 'package:farm_easy/widget/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/View/complete_profile.dart';
import 'package:farm_easy/Screens/ChatGpt/View/chat_gpt_start_Screen.dart';
import 'package:farm_easy/Screens/Dashboard/controller/dashboard_controller.dart';
import 'package:farm_easy/Screens/Followers/Followers/view/followers_view.dart';
import 'package:farm_easy/Screens/Followers/Followings/View/followings_view.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/home_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/View/land_details.dart';
import 'package:farm_easy/Screens/LandSection/MyLands/View/my_land.dart';
import 'package:farm_easy/Screens/MyProfile/Controller/review_controller.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});
  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final getProfileController = Get.put(GetProfileController());
  final reviewController = Get.put(ReviewListController());
  final homecontroller = Get.put(HomeController());
  final dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileController.getProfile();
    reviewController.reviewListData(
        getProfileController.getProfileData.value.result?.userId ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    bool isAnySocialMediaAvailable() {
      return getProfileController.getProfileData.value.result?.instagramUrl ==
              "" ||
          getProfileController.getProfileData.value.result?.twitterUrl == "" ||
          getProfileController.getProfileData.value.result?.facebookUrl == "" ||
          getProfileController.getProfileData.value.result?.linkdinUrl == "";
    }

    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.08),
        child: CommonAppBar(
          title: 'Profile',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getProfileController.getProfile();
          reviewController.reviewListData(
              getProfileController.getProfileData.value.result?.userId ?? 0);
        },
        child: SingleChildScrollView(
          child: Obx(() {
            return getProfileController.loading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [AppColor.BOX_SHADOW]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() {
                                return InkWell(
                                  onTap: () {
                                    print(
                                        "VALUE: ${reviewController.userId.value}");
                                  },
                                  child: Container(
                                    height: Get.height * 0.15,
                                    width: Get.width * 0.32,
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 20, left: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:
                                          AppColor.DARK_GREEN.withOpacity(0.2),
                                    ),
                                    child: getProfileController.getProfileData
                                                    .value.result?.image !=
                                                null &&
                                            getProfileController.getProfileData
                                                    .value.result?.image !=
                                                ""
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                              getProfileController
                                                      .getProfileData
                                                      .value
                                                      .result
                                                      ?.image ??
                                                  "",
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                              getProfileController
                                                      .getProfileData
                                                      .value
                                                      .result
                                                      ?.fullName
                                                      ?.substring(0, 1)
                                                      .toUpperCase() ??
                                                  "",
                                              style: GoogleFonts.poppins(
                                                fontSize: 40,
                                                color: AppColor.DARK_GREEN,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                  ),
                                );
                              }),
                              Obx(() {
                                final fullName = getProfileController
                                        .getProfileData
                                        .value
                                        .result
                                        ?.fullName ??
                                    '';
                                return Text(
                                  utf8.decode(utf8.encode(fullName)),
                                  // utf8.decode(utf8.encode(fullName)),
                                  style: GoogleFonts.notoSans(
                                    color: const Color(0xFF483C32),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                );
                              }),
                              Obx(() {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => FollowersView(
                                              userId: getProfileController
                                                      .getProfileData
                                                      .value
                                                      .result!
                                                      .userId! ??
                                                  0));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              getProfileController
                                                      .getProfileData
                                                      .value
                                                      .result
                                                      ?.followers
                                                      .toString() ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF483C32),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              'Total Followers',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF483C32),
                                                fontSize: 8,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 20,
                                        color: Colors.grey,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => FollowingView(
                                              userId: getProfileController
                                                      .getProfileData
                                                      .value
                                                      .result
                                                      ?.userId! ??
                                                  0));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: getProfileController
                                                            .getProfileData
                                                            .value
                                                            .result
                                                            ?.following
                                                            .toString() ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF483C32),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  // TextSpan(
                                                  //   text: 'Months',
                                                  //   style: GoogleFonts.poppins(
                                                  //     color: Color(0xFF483C32),
                                                  //     fontSize: 8,
                                                  //
                                                  //     fontWeight: FontWeight.w600,
                                                  //
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              'Following',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF483C32),
                                                fontSize: 8,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      getProfileController.getProfileData.value
                                                  .result?.userType ==
                                              "Land Owner"
                                          ? Container(
                                              width: 1,
                                              height: 20,
                                              color: Colors.grey,
                                            )
                                          : Container(),
                                      getProfileController.getProfileData.value
                                                  .result?.userType ==
                                              "Land Owner"
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: getProfileController
                                                                .getProfileData
                                                                .value
                                                                .result
                                                                ?.totallands
                                                                ?.toString() ??
                                                            "",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: const Color(
                                                              0xFF483C32),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  'Total Lands',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    color:
                                                        const Color(0xFF483C32),
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            )
                                          : Container()
                                    ],
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Additional Details",
                          style: GoogleFonts.poppins(
                            color: AppColor.BROWN_TEXT,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFFFFFF7),
                            boxShadow: [AppColor.BOX_SHADOW]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bio',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF483C32),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              width: Get.width * 0.9,
                              child: Obx(() => Text(
                                    getProfileController.getProfileData.value
                                                .result?.bio !=
                                            ""
                                        ? "${getProfileController.getProfileData.value.result?.bio}"
                                        : "-----",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF777777),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'City',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF483C32),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            Obx(() => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    getProfileController.getProfileData.value
                                            .result?.livesIn ??
                                        "",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF909090),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 12,
                            ),
                            Obx(() {
                              if (getProfileController
                                      .getProfileData.value.result?.userType ==
                                  "Land Owner") {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Profile',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              } else if (getProfileController
                                      .getProfileData.value.result?.userType ==
                                  "Farmer") {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Expertise',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              } else if (getProfileController
                                      .getProfileData.value.result?.userType ==
                                  "Agri Service Provider") {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Roles',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                            Obx(() {
                              if (getProfileController
                                      .getProfileData.value.result?.userType ==
                                  "Land Owner") {
                                return Text(
                                  getProfileController.getProfileData.value
                                          .result?.profileType ??
                                      "",
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF909090),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              } else if (getProfileController
                                      .getProfileData.value.result?.userType ==
                                  "Farmer") {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var role in getProfileController
                                            .getProfileData
                                            .value
                                            .result
                                            ?.expertise ??
                                        [])
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 2),
                                        child: Text(
                                          role.name ?? "",
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF909090),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              } else if (getProfileController
                                      .getProfileData.value.result?.userType ==
                                  "Agri Service Provider") {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var role in getProfileController
                                            .getProfileData
                                            .value
                                            .result
                                            ?.roles ??
                                        [])
                                      Container(
                                        child: Text(
                                          role.name ?? "",
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF909090),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            }),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Education',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF483C32),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              width: Get.width * 0.9,
                              child: Obx(() => Text(
                                    getProfileController.getProfileData.value
                                                .result?.education !=
                                            ""
                                        ? "${getProfileController.getProfileData.value.result?.education}"
                                        : "-----",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF777777),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  )),
                            ),
                            // if(isAnySocialMediaAvailable())
                            Obx(() {
                              final profileData = getProfileController
                                  .getProfileData.value.result;
                              final instagramUrl = profileData?.instagramUrl;
                              final twitterUrl = profileData?.twitterUrl;
                              final facebookUrl = profileData?.facebookUrl;
                              final linkedinUrl = profileData?.linkdinUrl;

                              // Check if any one of the URLs is not null
                              final hasAnyUrl = instagramUrl != null ||
                                  twitterUrl != null ||
                                  facebookUrl != null ||
                                  linkedinUrl != null;

                              return hasAnyUrl
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print("PRINTURL $instagramUrl");
                                          },
                                          child: Text(
                                            'Available On',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF483C32),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            instagramUrl == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () async {
                                                      final url = instagramUrl;
                                                      if (await canLaunch(
                                                          url)) {
                                                        await launch(url);
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/logos/insta.svg",
                                                    ),
                                                  ),

                                            twitterUrl == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () async {
                                                      final url = twitterUrl;
                                                      if (await canLaunch(
                                                          url)) {
                                                        await launch(url);
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/logos/twitter.svg",
                                                    ),
                                                  ),
                                            facebookUrl == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () async {
                                                      final url = facebookUrl;
                                                      if (await canLaunch(
                                                          url)) {
                                                        await launch(url);
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/logos/fb.svg",
                                                    ),
                                                  ),
                                            linkedinUrl == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () async {
                                                      final url = linkedinUrl;
                                                      if (await canLaunch(
                                                          url)) {
                                                        await launch(url);
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/logos/linkdin.svg",
                                                    ),
                                                  ),
                                            // Obx(() {
                                            //   return instagramUrl == ""
                                            //       ? Container()
                                            //       : GestureDetector(
                                            //           onTap: () async {
                                            //             final url =
                                            //                 instagramUrl;
                                            //             if (await canLaunch(
                                            //                 url!)) {
                                            //               await launch(url!);
                                            //             } else {
                                            //               throw 'Could not launch $url';
                                            //             }
                                            //           },
                                            //           child: SvgPicture.asset(
                                            //             "assets/logos/insta.svg",
                                            //           ),
                                            //         );
                                            // }),
                                            // Obx(() {
                                            //   return twitterUrl == ""
                                            //       ? Container()
                                            //       : GestureDetector(
                                            //           onTap: () async {
                                            //             final url = twitterUrl;
                                            //             if (await canLaunch(
                                            //                 url!)) {
                                            //               await launch(url);
                                            //             } else {
                                            //               throw 'Could not launch $url';
                                            //             }
                                            //           },
                                            //           child: SvgPicture.asset(
                                            //             "assets/logos/twitter.svg",
                                            //           ),
                                            //         );
                                            // }),
                                            // Obx(() {
                                            //   return facebookUrl == ""
                                            //       ? Container()
                                            //       : GestureDetector(
                                            //           onTap: () async {
                                            //             final url = facebookUrl;
                                            //             if (await canLaunch(
                                            //                 url!)) {
                                            //               await launch(url!);
                                            //             } else {
                                            //               throw 'Could not launch $url';
                                            //             }
                                            //           },
                                            //           child: SvgPicture.asset(
                                            //             "assets/logos/fb.svg",
                                            //           ),
                                            //         )
                                            //   ;
                                            // }),
                                            // Obx(() {
                                            //   return linkedinUrl == ""
                                            //       ? Container()
                                            //       : GestureDetector(
                                            //           onTap: () async {
                                            //             final url = linkedinUrl;
                                            //             if (await canLaunch(
                                            //                 url!)) {
                                            //               await launch(url);
                                            //             } else {
                                            //               throw 'Could not launch $url';
                                            //             }
                                            //           },
                                            //           child: SvgPicture.asset(
                                            //             "assets/logos/linkdin.svg",
                                            //           ),
                                            //         );
                                            // }),

                                            // if (instagramUrl != "")
                                            //   GestureDetector(
                                            //     onTap: () async {
                                            //       final url = instagramUrl;
                                            //       if (await canLaunch(url!)) {
                                            //         await launch(url!);
                                            //       } else {
                                            //         throw 'Could not launch $url';
                                            //       }
                                            //     },
                                            //     child: SvgPicture.asset(
                                            //       "assets/logos/insta.svg",
                                            //     ),
                                            //   ),
                                            // if (twitterUrl != "")
                                            //   GestureDetector(
                                            //     onTap: () async {
                                            //       final url = twitterUrl;
                                            //       if (await canLaunch(url!)) {
                                            //         await launch(url);
                                            //       } else {
                                            //         throw 'Could not launch $url';
                                            //       }
                                            //     },
                                            //     child: SvgPicture.asset(
                                            //       "assets/logos/twitter.svg",
                                            //     ),
                                            //   ),
                                            // if (facebookUrl != "")
                                            //   GestureDetector(
                                            //     onTap: () async {
                                            //       final url = facebookUrl;
                                            //       if (await canLaunch(url!)) {
                                            //         await launch(url!);
                                            //       } else {
                                            //         throw 'Could not launch $url';
                                            //       }
                                            //     },
                                            //     child: SvgPicture.asset(
                                            //       "assets/logos/fb.svg",
                                            //     ),
                                            //   ),
                                            // if (linkedinUrl != "")
                                            //   GestureDetector(
                                            //     onTap: () async {
                                            //       final url = linkedinUrl;
                                            //       if (await canLaunch(url!)) {
                                            //         await launch(url);
                                            //       } else {
                                            //         throw 'Could not launch $url';
                                            //       }
                                            //     },
                                            //     child: SvgPicture.asset(
                                            //       "assets/logos/linkdin.svg",
                                            //     ),
                                            //   ),
                                          ],
                                        )
                                      ],
                                    )
                                  : Container();
                            })
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<String>(
                              future: homecontroller.prefs.getUserRole(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData &&
                                      snapshot.data == "Land Owner") {
                                    return Obx(() {
                                      return homecontroller
                                                  .landData
                                                  .value
                                                  .result
                                                  ?.pageInfo
                                                  ?.totalObject !=
                                              0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'My Lands',
                                                  style: GoogleFonts.poppins(
                                                    color:
                                                        const Color(0xFF483C32),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(
                                                        () => const MyLands());
                                                  },
                                                  child: Text(
                                                    'View all (${homecontroller.landData.value.result?.pageInfo?.totalObject?.toInt() ?? "No land added"}) >',
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF044D3A),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Container();
                                    });
                                  } else {
                                    return Container(); // Return an empty container if user role is not "Land Owner"
                                  }
                                } else {
                                  return const CircularProgressIndicator(); // Return a loading indicator while fetching user role
                                }
                              },
                            ),
                            homecontroller
                                        .landData.value.result?.data?.length ==
                                    0
                                ? Center(
                                    child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 30),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      'Currently there are no lands, you can surely see those here, once posted.',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: const Color(0xFF777777)),
                                    ),
                                  ))
                                : Obx(() {
                                    return homecontroller.loading.value
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: homecontroller
                                                    .landData
                                                    .value
                                                    .result
                                                    ?.data
                                                    ?.length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Get.to(() => LandDetails(
                                                      id: homecontroller
                                                              .landData
                                                              .value
                                                              .result
                                                              ?.data?[index]
                                                              .id
                                                              ?.toInt() ??
                                                          0));
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 20),
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  width: double.infinity,
                                                  decoration: ShapeDecoration(
                                                    color:
                                                        const Color(0xFFFFFFF7),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    shadows: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x19000000),
                                                        blurRadius: 24,
                                                        offset: Offset(0, 2),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 15),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    homecontroller
                                                                            .landData
                                                                            .value
                                                                            .result
                                                                            ?.data?[index]
                                                                            .landTitle ??
                                                                        "",
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: AppColor
                                                                            .BROWN_TEXT,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${homecontroller.landData.value.result?.data?[index].weatherDetails?.temperature?.toInt() ?? ""}º",
                                                                        style: GoogleFonts.poppins(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: AppColor.BROWN_TEXT,
                                                                            fontSize: 15),
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            20,
                                                                        width:
                                                                            20,
                                                                        decoration:
                                                                            BoxDecoration(image: DecorationImage(image: NetworkImage("http://openweathermap.org/img/wn/${homecontroller.landData.value.result?.data?[index].weatherDetails?.imgIcon}.png"), fit: BoxFit.fill)),
                                                                      ),
                                                                      SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.26,
                                                                        child:
                                                                            Text(
                                                                          homecontroller.landData.value.result?.data?[index].weatherDetails?.description ??
                                                                              "",
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: GoogleFonts.poppins(
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColor.BROWN_TEXT,
                                                                              fontSize: 15),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    "Min: ${homecontroller.landData.value.result?.data?[index].weatherDetails?.minTemp?.toInt() ?? ""}º / Max: ${homecontroller.landData.value.result?.data?[index].weatherDetails?.maxTemp?.toInt() ?? ""}º",
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: const Color(
                                                                            0xFF61646B),
                                                                        fontSize:
                                                                            10),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Get.to(() =>
                                                                    const ChatGptStartScreen());
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    gradient:
                                                                        AppColor
                                                                            .BLUE_GREEN_GRADIENT,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          15),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                        ImageConstants
                                                                            .CHATGPT,
                                                                        height:
                                                                            20,
                                                                        width:
                                                                            20,
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          ' AI Agri-assistant',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            color:
                                                                                AppColor.BROWN_TEXT,
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            height:
                                                                                0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: List.generate(
                                                            450 ~/ 4,
                                                            (index) => Expanded(
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            12),
                                                                    color: index %
                                                                                2 ==
                                                                            0
                                                                        ? Colors
                                                                            .transparent
                                                                        : AppColor
                                                                            .GREY_BORDER,
                                                                    height: 1,
                                                                  ),
                                                                )),
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                AppDimension.w *
                                                                    0.3,
                                                            child: Center(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    ImageConstants
                                                                        .LAND,
                                                                    height: 28,
                                                                    width: 28,
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        top: 8),
                                                                    child: Text(
                                                                      'Land #${homecontroller.landData.value.result?.data?[index].id?.toInt() ?? ""}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: AppColor
                                                                            .DARK_GREEN,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        height:
                                                                            2.5,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 80,
                                                                    child: Text(
                                                                      "${homecontroller.landData.value.result?.data?[index].city ?? ""} ${homecontroller.landData.value.result?.data?[index].state ?? ""} ${homecontroller.landData.value.result?.data?[index].country ?? ""}",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: AppColor
                                                                            .GREEN_SUBTEXT,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                AppDimension.h *
                                                                    0.13,
                                                            width:
                                                                AppDimension.w *
                                                                    0.3,
                                                            child: Center(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    ImageConstants
                                                                        .AREA,
                                                                    height: 28,
                                                                    width: 28,
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        top: 8),
                                                                    child: Text(
                                                                      'Area',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: AppColor
                                                                            .DARK_GREEN,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        height:
                                                                            2.5,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: AppDimension
                                                                            .w *
                                                                        0.5,
                                                                    child: Text(
                                                                      homecontroller
                                                                              .landData
                                                                              .value
                                                                              .result
                                                                              ?.data?[index]
                                                                              .landSize ??
                                                                          "",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: AppColor
                                                                            .GREEN_SUBTEXT,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                AppDimension.w *
                                                                    0.3,
                                                            child: Center(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    ImageConstants
                                                                        .CROP,
                                                                    height: 28,
                                                                    width: 28,
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        top: 8),
                                                                    child: Text(
                                                                      'Crop Preferences',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: AppColor
                                                                            .DARK_GREEN,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        height:
                                                                            2.5,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 40,
                                                                    width:
                                                                        Get.width *
                                                                            0.2,
                                                                    child: ListView
                                                                        .builder(
                                                                            itemCount: homecontroller.landData.value.result?.data?[index].cropToGrow?.length ??
                                                                                0,
                                                                            itemBuilder:
                                                                                (context, landdata) {
                                                                              return Text(
                                                                                homecontroller.landData.value.result?.data?[index].cropToGrow?[landdata].name ?? "",
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.poppins(
                                                                                  color: AppColor.GREEN_SUBTEXT,
                                                                                  fontSize: 10,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              );
                                                                            }),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      homecontroller
                                                                  .landData
                                                                  .value
                                                                  .result
                                                                  ?.data?[index]
                                                                  .images
                                                                  ?.length !=
                                                              0
                                                          ? Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              height:
                                                                  AppDimension
                                                                          .h *
                                                                      0.16,
                                                              child: ListView
                                                                  .builder(
                                                                itemCount: homecontroller
                                                                        .landData
                                                                        .value
                                                                        .result
                                                                        ?.data?[
                                                                            index]
                                                                        .images
                                                                        ?.length ??
                                                                    0,
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                itemBuilder:
                                                                    (context,
                                                                        imgIndex) {
                                                                  final images = homecontroller
                                                                      .landData
                                                                      .value
                                                                      .result
                                                                      ?.data?[
                                                                          index]
                                                                      .images?[
                                                                          imgIndex]
                                                                      .image;
                                                                  return Container(
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            10,
                                                                        horizontal:
                                                                            10),
                                                                    height: AppDimension
                                                                            .h *
                                                                        0.14,
                                                                    width: AppDimension
                                                                            .w *
                                                                        0.28,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      image:
                                                                          DecorationImage(
                                                                        image: NetworkImage(images ??
                                                                            ""),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            )
                                                          : Container(),
                                                      const Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                ImageConstants
                                                                    .ENQUIRIES,
                                                                height: 30,
                                                              ),
                                                              Text(
                                                                '  Enquiries',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: AppColor
                                                                      .DARK_GREEN,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 0.15,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Partners  ',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: AppColor
                                                                      .DARK_GREEN,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 0.15,
                                                                ),
                                                              ),
                                                              CircleAvatar(
                                                                radius: 16,
                                                                backgroundColor:
                                                                    AppColor
                                                                        .DARK_GREEN,
                                                                child: Center(
                                                                  child: Text(
                                                                    '${homecontroller.landData.value.result?.data?[index].totalAgriServiceProvider ?? "0"}',
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      height:
                                                                          0.10,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Farmers  ',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: AppColor
                                                                      .DARK_GREEN,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 0.15,
                                                                ),
                                                              ),
                                                              CircleAvatar(
                                                                radius: 16,
                                                                backgroundColor:
                                                                    AppColor
                                                                        .DARK_GREEN,
                                                                child: Center(
                                                                  child: Text(
                                                                    '${homecontroller.landData.value.result?.data?[index].totalMatchingFarmer ?? "0"}',
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      height:
                                                                          0.10,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                  }),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              color: AppColor.GREY_BORDER,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/logos/star.svg",
                                    width: 15,
                                  ),
                                  Obx(() {
                                    return Text(
                                      '${(reviewController.reviewData.value.result?.averageRating ?? 0).toStringAsFixed(1)}  ',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF483C32),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  }),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF483C32),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Obx(() => Text(
                                        '  ${reviewController.reviewData.value.result?.pageInfo?.totalObject ?? ""} Reviews',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF483C32),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Obx(() {
                              if (reviewController.loading.value) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (reviewController
                                      .rxRequestStatus.value ==
                                  Status.ERROR) {
                                return const Center(
                                    child: Text('Error fetching data'));
                              } else if (reviewController
                                          .reviewData.value.result?.data ==
                                      null ||
                                  reviewController.reviewData.value.result?.data
                                          ?.isEmpty ==
                                      true) {
                                return Center(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 20),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'Currently there are no reviews, you can surely see those here, once posted.',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: const Color(0xFF777777)),
                                  ),
                                ));
                              } else {
                                return Container(
                                  height: Get.height * 0.2,
                                  margin: const EdgeInsets.only(bottom: 60),
                                  child: ListView.builder(
                                    itemCount: reviewController.reviewData.value
                                            .result?.data?.length ??
                                        0,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, reviews) {
                                      final review = reviewController.reviewData
                                          .value.result?.data?[reviews];

                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width: Get.width * 0.9,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: 0.8,
                                              color: AppColor.GREY_BORDER),
                                          color: const Color(0xFFFFFFF7),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  onTap: () {
                                                    Get.to(
                                                        () => UserProfileScreen(
                                                              id: review
                                                                      ?.reviewerUserId
                                                                      ?.toInt() ??
                                                                  0,
                                                              userType: review
                                                                      ?.reviewerUserType ??
                                                                  "",
                                                            ));
                                                    print("tapped");
                                                  },
                                                  leading: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: AppColor.DARK_GREEN
                                                          .withOpacity(0.2),
                                                      image: review?.reviewerImage !=
                                                                  null &&
                                                              review?.reviewerImage !=
                                                                  ""
                                                          ? DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  review?.reviewerImage ??
                                                                      ""))
                                                          : null,
                                                    ),
                                                    child: (review?.reviewerImage ==
                                                                null ||
                                                            review?.reviewerImage ==
                                                                "")
                                                        ? Center(
                                                            child: Text(
                                                              review?.reviewerName?[
                                                                      0] ??
                                                                  "",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColor
                                                                    .DARK_GREEN,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ),
                                                  title: Text(
                                                    review?.reviewerName ?? "",
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF333333),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.2,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    review?.date ?? "",
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF909090),
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.2,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/farm/locationbrown.svg",
                                                        width: 14,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: Text(
                                                          review?.reviewerLocation ??
                                                              "",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: const Color(
                                                                0xFF777777),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.2,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 12,
                                                      top: 10,
                                                      right: 20),
                                                  child: Text(
                                                    review?.description ?? "",
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      height: 1.2,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            }),
                          ],
                        ),
                      )
                    ],
                  );
          }),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Get.to(const CompleteProfile());
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          margin:
              const EdgeInsets.only(top: 18, bottom: 30, left: 10, right: 10),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColor.DARK_GREEN,
              )),
          child: Center(
            child: Text(
              "Edit Profile",
              style: GoogleFonts.poppins(
                color: AppColor.DARK_GREEN,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
