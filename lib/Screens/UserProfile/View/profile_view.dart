import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Constants/string_constant.dart';
import 'package:farm_easy/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/ChatSection/view/chat_ui.dart';
import 'package:farm_easy/Screens/Followers/Followers/view/followers_view.dart';
import 'package:farm_easy/Screens/Followers/Followings/Controller/follow_unfollow_controller.dart';
import 'package:farm_easy/Screens/Followers/Followings/View/followings_view.dart';
import 'package:farm_easy/Screens/LandSection/UserLands/View/user_land_list.dart';
import 'package:farm_easy/Screens/MyProfile/Controller/review_controller.dart';
import 'package:farm_easy/Screens/ProductAndServices/Controller/product_view_controller.dart';
import 'package:farm_easy/Screens/UserProfile/Controller/rate_review_controller.dart';
import 'package:farm_easy/Screens/UserProfile/Controller/user_controller.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen(
      {super.key, required this.id, required this.userType});
  final String userType;
  final int id;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final userController = Get.put(UserProfileController());
  final followUnfollowController = Get.put(FollowUnfollowController());
  final reviewController = Get.put(ReviewListController());
  final rateReviewController = Get.put(RateReviewController());
  final controller = Get.put(ProductViewController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userController.userDetails(widget.id, widget.userType);
      reviewController.reviewListData(userController.userId.value);
    });
    controller.userProductList(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    userController.userType.value = widget.userType;
    userController.userId.value = widget.id;
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppDimension.h * 0.08),
          child: CommonAppBar(
            isbackButton: true,
            title: '${widget.userType}',
          )),
      body: SingleChildScrollView(child: Obx(() {
        return userController.loading.value
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return Center(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [AppColor.BOX_SHADOW]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: Get.height * 0.15,
                                      width: Get.width * 0.32,
                                      margin: EdgeInsets.only(
                                          top: 10, bottom: 20, left: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColor.DARK_GREEN
                                            .withOpacity(0.2),
                                      ),
                                      child: userController.userData.value
                                                      .result?.image !=
                                                  null &&
                                              userController.userData.value
                                                      .result?.image !=
                                                  ""
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                userController.userData.value
                                                        .result?.image ??
                                                    "",
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                            )
                                          : Center(
                                              child: Text(
                                                userController.userData.value
                                                        .result?.fullName
                                                        ?.substring(0, 1)
                                                        .toUpperCase() ??
                                                    "",
                                                style: TextStyle(
                                                  fontSize: 40,
                                                  color: AppColor.DARK_GREEN,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        userController.userData.value.result
                                                ?.fullName ??
                                            "",
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(
                                          color: Color(0xFF483C32),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    userController.userType.value == "Farmer"
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Farmer Score:",
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xFF483C32),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                ),
                                              ),
                                              Text(
                                                " ${userController.userData.value.result?.farmeasyRating ?? 0.0}  ",
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xFF483C32),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  height: 0,
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                  "assets/logos/star.svg")
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(() =>
                                            FollowersView(userId: widget.id));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: userController
                                                          .userData
                                                          .value
                                                          .result
                                                          ?.followers
                                                          .toString() ??
                                                      "",
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0xFF483C32),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            'Followers',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              color: Color(0xFF483C32),
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      height: 1,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => FollowingView(
                                              userId: widget.id,
                                            ));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userController.userData.value.result
                                                    ?.following
                                                    .toString() ??
                                                "",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              color: Color(0xFF483C32),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Following',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              color: Color(0xFF483C32),
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      height: 1,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                    widget.userType == "Land Owner"
                                        ? InkWell(
                                            onTap: () {
                                              Get.to(() => UserLandList(
                                                    userId: widget.id,
                                                  ));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: userController
                                                                .userData
                                                                .value
                                                                .result
                                                                ?.totalLands
                                                                .toString() ??
                                                            "",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF483C32),
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
                                                    color: Color(0xFF483C32),
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: userController
                                                                  .userData
                                                                  .value
                                                                  .result
                                                                  ?.experienceInYears ==
                                                              null
                                                          ? "0"
                                                          : userController
                                                                  .userData
                                                                  .value
                                                                  .result
                                                                  ?.experienceInYears
                                                                  .toString() ??
                                                              "",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            Color(0xFF483C32),
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
                                                'Years of Experience',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xFF483C32),
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          )
                                  ],
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                // Toggle follow/unfollow state
                                followUnfollowController.followUnfollow(
                                    userController
                                            .userData.value.result?.userId!
                                            .toInt() ??
                                        0);

                                // Check the current follow state and update the followers count accordingly
                                bool isCurrentlyFollowing = userController
                                        .userData.value.result?.isFollowing ??
                                    false;

                                if (isCurrentlyFollowing) {
                                  // User is unfollowing, decrease followers count by 1
                                  userController.userData.value.result
                                      ?.followers = (userController.userData
                                              .value.result?.followers ??
                                          1) -
                                      1;
                                } else {
                                  // User is following, increase followers count by 1
                                  userController.userData.value.result
                                      ?.followers = (userController.userData
                                              .value.result?.followers ??
                                          0) +
                                      1;
                                }

                                // Toggle the follow state
                                userController.userData.value.result
                                    ?.isFollowing = !isCurrentlyFollowing;

                                // Update the controller to reflect the changes in the UI
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: userController.userData.value.result
                                                ?.isFollowing ==
                                            false
                                        ? Colors.transparent
                                        : AppColor.DARK_GREEN,
                                  ),
                                  color: userController.userData.value.result
                                              ?.isFollowing ==
                                          false
                                      ? AppColor.DARK_GREEN
                                      : Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    userController.userData.value.result
                                                ?.isFollowing ==
                                            false
                                        ? "Follow"
                                        : "Unfollow",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: userController.userData.value
                                                  .result?.isFollowing ==
                                              false
                                          ? Colors.white
                                          : AppColor.DARK_GREEN,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //     color: Colors.white,
                    //     boxShadow: [AppColor.BOX_SHADOW]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          titleAlignment: ListTileTitleAlignment.titleHeight,
                          contentPadding: EdgeInsets.zero,
                          leading: SvgPicture.asset(
                            "assets/logos/loc.svg",
                            height: 22,
                          ),
                          title: Text(
                            'Location',
                            style: GoogleFonts.poppins(
                              color: Color(0xFF483C32),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Obx(() => Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  userController
                                          .userData.value.result?.livesIn ??
                                      "",
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF909090),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              )),
                        ),
                        ListTile(
                          titleAlignment: ListTileTitleAlignment.titleHeight,
                          contentPadding: EdgeInsets.zero,
                          leading: SvgPicture.asset(
                            "assets/logos/expertise.svg",
                            height: 20,
                          ),
                          title: Obx(() {
                            if (userController.userType.value == "Land Owner") {
                              return Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'Profile',
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF333333),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            } else if (userController.userType.value ==
                                "Farmer") {
                              return Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'Expertise',
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF333333),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            } else if (userController.userType.value ==
                                StringConstatnt.AGRI_PROVIDER) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'Roles',
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF333333),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                          subtitle: Obx(() {
                            if (userController.userType.value == "Land Owner") {
                              return Text(
                                userController
                                        .userData.value.result?.profileType ??
                                    "",
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF909090),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            } else if (userController.userType.value ==
                                "Farmer") {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (userController.userData.value.result
                                                ?.expertise ==
                                            null ||
                                        userController.userData.value.result!
                                            .expertise!.isEmpty)
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 10, bottom: 2),
                                        child: Text(
                                          "------",
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF909090),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    else
                                      for (var role in userController.userData
                                              .value.result?.expertise ??
                                          [])
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 10, bottom: 2),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 0),
                                          child: Text(
                                            role.name ?? "",
                                            style: GoogleFonts.poppins(
                                              color: Color(0xFF909090),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                  ],
                                ),
                              );
                            } else if (userController.userType.value ==
                                "Agri Service Provider") {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var role in userController
                                            .userData.value.result?.services ??
                                        [])
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 10, bottom: 2),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 0),
                                        child: Text(
                                          role.name ?? "",
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF909090),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                        ),
                        Obx(() => userController.userType.value == "Farmer"
                            ? ListTile(
                                titleAlignment:
                                    ListTileTitleAlignment.titleHeight,
                                contentPadding: EdgeInsets.zero,
                                leading: SvgPicture.asset(
                                  "assets/logos/payroll.svg",
                                  height: 20,
                                ),
                                title: Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Crop Expertise',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF333333),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                subtitle: Obx(
                                  () => userController.userType.value ==
                                          "Farmer"
                                      ? SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              for (var cropExpertise
                                                  in userController
                                                          .userData
                                                          .value
                                                          .result
                                                          ?.cropExpertise ??
                                                      [])
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10, bottom: 2),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 6,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xFF777777)),
                                                  ),
                                                  child: Text(
                                                    cropExpertise.name ?? "",
                                                    style: GoogleFonts.poppins(
                                                      color: Color(0xFF909090),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                ),
                              )
                            : Container()),
                        Obx(() => userController
                                    .userData.value.result?.isSalaryVisible ==
                                true
                            ? ListTile(
                                titleAlignment:
                                    ListTileTitleAlignment.titleHeight,
                                contentPadding: EdgeInsets.zero,
                                leading: SvgPicture.asset(
                                  "assets/logos/payroll.svg",
                                  height: 20,
                                ),
                                title: Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Expected Monthly Salary Range',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                subtitle: Container(
                                  child: userController.userData.value.result
                                              ?.minSalary ==
                                          null
                                      ? Text("--")
                                      : Text(
                                          "INR ${userController.userData.value.result?.minSalary} to INR ${userController.userData.value.result?.maxSalary}",
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF909090),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                ))
                            : Container()),
                        Obx(() {
                          final profileData =
                              userController.userData.value.result;
                          final instagramUrl = profileData?.instagramUrl;
                          final twitterUrl = profileData?.twitterUrl;
                          final facebookUrl = profileData?.facebookUrl;
                          final linkedinUrl = profileData?.linkedinUrl;

                          // Check if any one of the URLs is not null
                          final hasAnyUrl = instagramUrl != null ||
                              twitterUrl != null ||
                              facebookUrl != null ||
                              linkedinUrl != null;

                          return hasAnyUrl
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Available On',
                                      style: GoogleFonts.poppins(
                                        color: Color(0xFF483C32),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (instagramUrl != null)
                                          GestureDetector(
                                            onTap: () async {
                                              final url = instagramUrl;
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              "assets/logos/insta.svg",
                                            ),
                                          ),
                                        if (twitterUrl != null)
                                          GestureDetector(
                                            onTap: () async {
                                              final url = twitterUrl;
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              "assets/logos/twitter.svg",
                                            ),
                                          ),
                                        if (facebookUrl != null)
                                          GestureDetector(
                                            onTap: () async {
                                              final url = facebookUrl;
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              "assets/logos/fb.svg",
                                            ),
                                          ),
                                        if (linkedinUrl != null)
                                          GestureDetector(
                                            onTap: () async {
                                              final url = linkedinUrl;
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              "assets/logos/linkdin.svg",
                                            ),
                                          ),
                                      ],
                                    )
                                  ],
                                )
                              : Container();
                        }),
                        Divider(),
                        Text(
                          'Bio',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF483C32),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          width: Get.width * 0.9,
                          child: Obx(() => Text(
                                userController.userData.value.result?.bio != ""
                                    ? "${userController.userData.value.result?.bio}"
                                    : "-----",
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF777777),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              )),
                        ),
                        Obx(() {
                          return userController.userType.value ==
                                  StringConstatnt.AGRI_PROVIDER
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ' My Products (${controller.productData.value.result?.data?.length ?? 0})',
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF483C32),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: controller.productData.value
                                                .result?.data?.length ??
                                            0,
                                        itemBuilder: (context, products) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  width: double.infinity,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFFFFFFF7),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    shadows: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x19000000),
                                                        blurRadius: 24,
                                                        offset: Offset(0, 2),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      controller
                                                                  .productData
                                                                  .value
                                                                  .result
                                                                  ?.data?[
                                                                      products]
                                                                  .image
                                                                  ?.length !=
                                                              0
                                                          ? Container(
                                                              height:
                                                                  Get.height *
                                                                      0.14,
                                                              child: ListView
                                                                  .builder(
                                                                      itemCount: controller
                                                                              .productData
                                                                              .value
                                                                              .result
                                                                              ?.data?[
                                                                                  products]
                                                                              .image
                                                                              ?.length ??
                                                                          0,
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      itemBuilder:
                                                                          (context,
                                                                              img) {
                                                                        return Container(
                                                                          margin: EdgeInsets.only(
                                                                              bottom: 10,
                                                                              right: 8),
                                                                          height:
                                                                              Get.height * 0.14,
                                                                          width:
                                                                              Get.width * 0.3,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.black,
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              image: DecorationImage(image: NetworkImage(controller.productData.value.result?.data?[products].image?[img].image ?? ""), fit: BoxFit.cover)),
                                                                        );
                                                                      }),
                                                            )
                                                          : Container(),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 0,
                                                                horizontal: 0),
                                                        child: Text(
                                                          '${controller.productData.value.result?.data?[products].name ?? ""}',
                                                          style: TextStyle(
                                                            color: AppColor
                                                                .BROWN_TEXT,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 5,
                                                            left: 0,
                                                            right: 10,
                                                            top: 5),
                                                        child: Text(
                                                          '${controller.productData.value.result?.data?[products].description ?? ""}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Color(
                                                                0xFF61646B),
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          '${controller.productData.value.result?.data?[products].currency ?? ""} ${controller.productData.value.result?.data?[products].unitPrice}/${controller.productData.value.result?.data?[products].unitValue} ${controller.productData.value.result?.data?[products].unit}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: AppColor
                                                                .DARK_GREEN,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ],
                                )
                              : Container();
                        }),
                        Divider(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 0, left: 15, right: 25, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  color: Color(0xFF483C32),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: ShapeDecoration(
                                color: Color(0xFF483C32),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Obx(() => Text(
                                  '  ${reviewController.reviewData.value.result?.pageInfo?.totalObject ?? ""} Reviews',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF483C32),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                      Center(
                                        child: Text(
                                          "Rate & Review",
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF483C32),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      ListTile(
                                        leading: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      userController
                                                              .userData
                                                              .value
                                                              .result
                                                              ?.image ??
                                                          "")),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        title: Text(
                                          userController.userData.value.result
                                                  ?.fullName ??
                                              "",
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF483C32),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          margin: EdgeInsets.only(
                                              left: 20, top: 10),
                                          child: ListView.builder(
                                              itemCount: 5,
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, rate) {
                                                return Obx(() =>
                                                    GestureDetector(
                                                      onTap: () {
                                                        rateReviewController
                                                            .onStarTap(
                                                                rate + 1);
                                                        print(
                                                            "RATING COUNT ${rateReviewController.selectedRating.value}");
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 20),
                                                        child: Center(
                                                            child: Icon(
                                                          rate <
                                                                  rateReviewController
                                                                      .selectedRating
                                                                      .value
                                                              ? CupertinoIcons
                                                                  .star_fill
                                                              : CupertinoIcons
                                                                  .star,
                                                          size: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                          color: rate <
                                                                  rateReviewController
                                                                      .selectedRating
                                                                      .value
                                                              ? AppColor
                                                                  .DARK_GREEN
                                                              : Colors.grey,
                                                        )),
                                                      ),
                                                    ));
                                              }),
                                        ),
                                      ),
                                      Obx(() {
                                        return rateReviewController
                                                    .selectedRating.value ==
                                                0
                                            ? Container()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30,
                                                    bottom: 10,
                                                    left: 15,
                                                    right: 15),
                                                child: TextFormField(
                                                  controller:
                                                      rateReviewController
                                                          .reviewController
                                                          .value,
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                BorderSide(
                                                              color: AppColor
                                                                  .DARK_GREEN,
                                                            )),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                BorderSide(
                                                              color: AppColor
                                                                  .DARK_GREEN,
                                                            )),
                                                    hintText:
                                                        "(Optional) Tell others what you think",
                                                    labelText: "Public review",
                                                    hintStyle:
                                                        GoogleFonts.poppins(
                                                      color: Color(0xFF49454F),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 13),
                                                  ),
                                                ),
                                              );
                                      }),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 55),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: AppColor
                                                            .DARK_GREEN)),
                                                child: Center(
                                                  child: Text(
                                                    "Not now",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.DARK_GREEN,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Obx(() {
                                              return rateReviewController
                                                          .selectedRating
                                                          .value ==
                                                      0
                                                  ? Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 55),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: Colors
                                                              .grey.shade200),
                                                      child: Center(
                                                        child: Text(
                                                          "Submit",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xFF858588),
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        print(
                                                            'Star tappedSAHIL: ${rateReviewController.selectedRating.value}');
                                                        rateReviewController.postReview(
                                                            userController
                                                                    .userData
                                                                    .value
                                                                    .result
                                                                    ?.userId!
                                                                    .toInt() ??
                                                                0,
                                                            rateReviewController
                                                                .selectedRating
                                                                .value,
                                                            rateReviewController
                                                                .reviewController
                                                                .value
                                                                .text);
                                                        Get.back();
                                                        reviewController
                                                            .reviewListData(
                                                                widget.id);
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10,
                                                                horizontal: 55),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            border: Border.all(
                                                                color: AppColor
                                                                    .DARK_GREEN),
                                                            color: AppColor
                                                                .DARK_GREEN),
                                                        child: Center(
                                                          child: Text(
                                                            "Submit",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                            })
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            'Add Review',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: AppColor.DARK_GREEN,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ),
                  Obx(() {
                    if (reviewController.loading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (reviewController.rxRequestStatus.value ==
                        Status.ERROR) {
                      return Center(child: Text('Error fetching data'));
                    } else if (reviewController.reviewData.value.result?.data ==
                            null ||
                        reviewController
                                .reviewData.value.result?.data?.isEmpty ==
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
                              color: Color(0xFF777777)),
                        ),
                      ));
                    } else {
                      return Container(
                        height: Get.height * 0.2,
                        margin: EdgeInsets.only(bottom: 60),
                        child: ListView.builder(
                          itemCount: reviewController
                                  .reviewData.value.result?.data?.length ??
                              0,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, reviews) {
                            final review = reviewController
                                .reviewData.value.result?.data?[reviews];

                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              width: Get.width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 0.8, color: AppColor.GREY_BORDER),
                                color: Color(0xFFFFFFF7),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Get.to(() => UserProfileScreen(
                                                id: review?.reviewerUserId
                                                        ?.toInt() ??
                                                    0,
                                                userType:
                                                    review?.reviewerUserType ??
                                                        "",
                                              ));
                                          print("tapped");
                                        },
                                        leading: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColor.DARK_GREEN
                                                .withOpacity(0.2),
                                            image: review?.reviewerImage !=
                                                        null &&
                                                    review?.reviewerImage != ""
                                                ? DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        review?.reviewerImage ??
                                                            ""))
                                                : null,
                                          ),
                                          child: (review?.reviewerImage ==
                                                      null ||
                                                  review?.reviewerImage == "")
                                              ? Center(
                                                  child: Text(
                                                    review?.reviewerName?[0] ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColor.DARK_GREEN,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ),
                                        title: Text(
                                          review?.reviewerName ?? "",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            height: 1.2,
                                          ),
                                        ),
                                        subtitle: Text(
                                          review?.date ?? "",
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF909090),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/farm/locationbrown.svg",
                                              width: 14,
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                review?.reviewerLocation ?? "",
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xFF777777),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.2,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, top: 10, right: 20),
                                        child: Text(
                                          review?.description ?? "",
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF777777),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2,
                                          ),
                                          overflow: TextOverflow.ellipsis,
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
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
      })),
      bottomNavigationBar: InkWell(
        onTap: () {
          Get.to(() => ChatScreen(
                landId: 0,
                enquiryId: 0,
                userId:
                    userController.userData.value.result!.userId?.toInt() ?? 0,
                userType: userController.userData.value.result!.userType ?? "",
                userFrom: userController.userData.value.result!.livesIn ?? "",
                userName: userController.userData.value.result!.fullName ?? "",
                image: userController.userData.value.result!.image ?? "",
                isEnquiryCreatedByMe: false,
                isEnquiryDisplay: false,
                enquiryData: "",
              ));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          height: Get.height * 0.06,
          padding: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.DARK_GREEN),
          child: Center(
            child: Text(
              'Contact',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
