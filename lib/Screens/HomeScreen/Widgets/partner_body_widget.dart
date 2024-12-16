import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Constants/color_constants.dart';
import '../../../utils/Constants/dimensions_constatnts.dart';
import '../../ChatSection/view/chat_ui.dart';
import '../../RecommendedLandowners/view.dart';
import '../../UserProfile/View/profile_view.dart';
import '../Controller/home_controller.dart';
import '../Controller/recommended_landowners.dart';

class PartnerBodyWidget extends StatelessWidget {
  const PartnerBodyWidget({
    super.key,
    required this.homecontroller,
    required this.recoLandowner,
  });

  final HomeController homecontroller;
  final RecommendedLandownersController recoLandowner;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: homecontroller.prefs.getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data == "Agri Service Provider") {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Near by landowners',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF483C32),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Obx(() => Row(
                          children: [
                            recoLandowner.farmer.value.result?.count != 0
                                ? GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          () => const RecommendedLandowners());
                                    },
                                    child: Text(
                                      'View all (${recoLandowner.farmer.value.result?.count ?? 0}) ',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF044D3A),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ))
                  ],
                ),
                Obx(() {
                  return recoLandowner.farmer.value.result?.data?.length != 0
                      ? Container(
                          margin: const EdgeInsets.only(bottom: 20, top: 10),
                          height: Get.height * 0.14,
                          child: ListView.builder(
                              itemCount: recoLandowner
                                      .farmer.value.result?.data?.length ??
                                  0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  width: AppDimension.w * 0.8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColor.GREY_BORDER),
                                    boxShadow: [AppColor.BOX_SHADOW],
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => UserProfileScreen(
                                              id: recoLandowner
                                                      .farmer
                                                      .value
                                                      .result
                                                      ?.data?[index]
                                                      .userId!
                                                      .toInt() ??
                                                  0,
                                              userType: recoLandowner
                                                      .farmer
                                                      .value
                                                      .result
                                                      ?.data?[index]
                                                      .userType ??
                                                  ""));
                                        },
                                        child: Container(
                                          width: Get.width * 0.25,
                                          height: Get.height * 0.16,
                                          decoration: BoxDecoration(
                                            color: AppColor.DARK_GREEN
                                                .withOpacity(0.1),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(18),
                                              topLeft: Radius.circular(18),
                                            ),
                                            image: recoLandowner
                                                            .farmer
                                                            .value
                                                            .result
                                                            ?.data?[index]
                                                            .image !=
                                                        null &&
                                                    recoLandowner
                                                            .farmer
                                                            .value
                                                            .result
                                                            ?.data?[index]
                                                            .image !=
                                                        ""
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                      recoLandowner
                                                              .farmer
                                                              .value
                                                              .result
                                                              ?.data?[index]
                                                              .image! ??
                                                          "",
                                                    ),
                                                    fit: BoxFit.cover,
                                                  )
                                                : null, // Only apply image if it exists
                                          ),
                                          child: recoLandowner
                                                          .farmer
                                                          .value
                                                          .result
                                                          ?.data?[index]
                                                          .image ==
                                                      null ||
                                                  recoLandowner
                                                          .farmer
                                                          .value
                                                          .result
                                                          ?.data?[index]
                                                          .image ==
                                                      ""
                                              ? Center(
                                                  child: Text(
                                                    recoLandowner
                                                            .farmer
                                                            .value
                                                            .result
                                                            ?.data?[index]
                                                            .fullName![0] ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 50,
                                                      color: AppColor
                                                          .DARK_GREEN, // Text color contrasting the background
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(), // Show nothing if image exists
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              recoLandowner.farmer.value.result
                                                      ?.data?[index].fullName ??
                                                  "",
                                              style: GoogleFonts.poppins(
                                                color: AppColor.BROWN_TEXT,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/farm/locationbrown.svg",
                                                  width: 14,
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.45,
                                                  child: Text(
                                                    '  ${recoLandowner.farmer.value.result?.data?[index].livesIn ?? ""}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFF61646B),
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 80),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: AppColor.DARK_GREEN,
                                                    width: 1),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.to(() => ChatScreen(
                                                        landId: 0,
                                                        enquiryId: recoLandowner
                                                                .farmer
                                                                .value
                                                                .result
                                                                ?.data?[index]
                                                                .enquiryId
                                                                ?.toInt() ??
                                                            0,
                                                        userId: recoLandowner
                                                                .farmer
                                                                .value
                                                                .result
                                                                ?.data?[index]
                                                                .userId
                                                                ?.toInt() ??
                                                            0,
                                                        userType: recoLandowner
                                                                .farmer
                                                                .value
                                                                .result
                                                                ?.data?[index]
                                                                .userType ??
                                                            "",
                                                        userFrom: recoLandowner
                                                                .farmer
                                                                .value
                                                                .result
                                                                ?.data?[index]
                                                                .livesIn ??
                                                            "",
                                                        userName: recoLandowner
                                                                .farmer
                                                                .value
                                                                .result
                                                                ?.data?[index]
                                                                .fullName ??
                                                            "",
                                                        image: recoLandowner
                                                                .farmer
                                                                .value
                                                                .result
                                                                ?.data?[index]
                                                                .image ??
                                                            "",
                                                        isEnquiryCreatedByMe:
                                                            false,
                                                        isEnquiryDisplay: false,
                                                        enquiryData: "",
                                                      ));
                                                },
                                                child: const Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.call,
                                                      color:
                                                          AppColor.DARK_GREEN,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                      '  Contact ',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF044D3A),
                                                        fontSize: 9,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0.16,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }))
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              "There are no Partners",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        );
                })
              ],
            );
          } else {
            return Container();
          }
        } else {
          return const CircularProgressIndicator(); // Return a loading indicator while fetching user role
        }
      },
    );
  }
}
