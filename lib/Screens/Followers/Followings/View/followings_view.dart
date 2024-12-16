import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Constants/dimensions_constatnts.dart';
import 'package:farm_easy/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/Followers/Followings/Controller/follow_unfollow_controller.dart';
import 'package:farm_easy/Screens/Followers/Followings/Controller/following_controller.dart';
import 'package:farm_easy/Screens/Threads/View/threads.dart';
import 'package:farm_easy/Screens/UserProfile/View/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowingView extends StatefulWidget {
  FollowingView({super.key, required this.userId});
  final int userId;

  @override
  State<FollowingView> createState() => _FollowingViewState();
}

class _FollowingViewState extends State<FollowingView> {
  final controller = Get.put(FollwingController());
  final followUnfollowController = Get.put(FollowUnfollowController());

  @override
  void initState() {
    super.initState();
    controller.userId.value = widget.userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.08),
        child: CommonAppBar(
          title: 'Followers',
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
               controller.loading.value
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  itemCount: controller.followerslist.value.result?.data?.length ?? 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap:(){
                              //
                              // Get.to(() => UserProfileScreen(
                              //   id: controller.followerslist.value.result?.data![index].followingUserId ?? 0,
                              //   userType: controller.followerslist.value.result?.data![index].followingUserType ?? "",
                              // ));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.17,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueGrey,
                                image: DecorationImage(
                                  image: NetworkImage(controller.followerslist.value.result?.data?[index].followingUserImage ?? ""),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            margin: EdgeInsets.only(right: 10, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.followerslist.value.result?.data?[index].followingUserName ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: AppColor.BROWN_TEXT,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  controller.followerslist.value.result?.data?[index].followingUserAddress ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    color: AppColor.BROWN_TEXT,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("${controller.followerslist.value.result?.data?[index].followingUserId?.toInt() ?? 0}");
                              followUnfollowController.followUnfollow(controller.followerslist.value.result?.data?[index].followingUserId?.toInt() ?? 0);
                              controller.followerslist.value.result?.data?[index].isFollowing = !(controller.followerslist.value.result?.data?[index].isFollowing ?? false);
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: controller.followerslist.value.result?.data?[index].isFollowing == false
                                    ? AppColor.DARK_GREEN
                                    : Color(0xFFC5EBE1),
                              ),
                              child: Center(
                                child: Text(
                                  controller.followerslist.value.result?.data?[index].isFollowing == false
                                      ? "Follow"
                                      : "Unfollow",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: controller.followerslist.value.result?.data?[index].isFollowing == false
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
                    );
                  },
                )

            ],
          );
        }),
      ),
    );
  }
}

