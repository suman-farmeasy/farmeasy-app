import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Res/CommonWidget/App_AppBar.dart';
import 'package:farm_easy/Screens/AllEnquiries/View/all_enquiries.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
import 'package:farm_easy/Screens/Auth/EmailLogin/View/email_login.dart';
import 'package:farm_easy/Screens/ChatGpt/View/chat_gpt_start_Screen.dart';
import 'package:farm_easy/Screens/Feedback/View/feedback.dart';
import 'package:farm_easy/Screens/MarketPrices/View/market_prices.dart';
import 'package:farm_easy/Screens/MoreSection/Controller/controller.dart';
import 'package:farm_easy/Screens/MyLands/View/my_land.dart';
import 'package:farm_easy/Screens/MyProfile/View/my_profile.dart';
import 'package:farm_easy/Screens/ProductAndServices/View/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/dimensions_constatnts.dart';

class MoreSection extends StatefulWidget {
  const MoreSection({super.key});

  @override
  State<MoreSection> createState() => _MoreSectionState();
}

class _MoreSectionState extends State<MoreSection> {
  final controller = Get.put(MoreController());
  final getProfile = Get.put(GetProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppDimension.h * 0.08),
        child: CommonAppBar(
          title: 'More',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          getProfile.getProfileData.value.result?.image ?? "",
                        ),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle,
                    color: AppColor.DARK_GREEN),
              ),
            ),
            FutureBuilder<String>(
              future: controller.prefs.getUserName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Center(
                    child: Text(
                      snapshot.data.toString(),
                      style: GoogleFonts.poppins(
                        color: Color(0xFF111719),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
              },
            ),
            FutureBuilder<String>(
              future: controller.prefs.getUserRole(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data == "Farmer") {
                    return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [AppColor.BOX_SHADOW],
                            color: Color(0xFFFFFFF7)),
                        child: ListTile(
                          leading: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: AppColor.YELLOW_GRADIENT,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Text(
                                    '${getProfile.getProfileData.value.result?.farmeasyRating ?? 0.0}  ',
                                    style: GoogleFonts.poppins(
                                      color: AppColor.BROWN_TEXT,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                  "assets/logos/star.svg",
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          title: Text(
                            'Farmeasy Rating',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'This score is automatically calculated based on the information provided by you',
                            style: GoogleFonts.poppins(
                              color: Color(0xFF62666E),
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ));
                  } else {
                    return Container(); // Return an empty container if user role is not "Land Owner"
                  }
                } else {
                  return CircularProgressIndicator(); // Return a loading indicator while fetching user role
                }
              },
            ),
            InkWell(
              onTap: () {
                Get.to(() => MyProfileScreen());
              },
              child: ListTilesWidget(
                img: "assets/more/user.svg",
                title: "My Profile",
              ),
            ),
            FutureBuilder<String>(
              future: controller.prefs.getUserRole(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data == "Land Owner") {
                    return InkWell(
                      onTap: () {
                        Get.to(() => MyLands());
                      },
                      child: ListTilesWidget(
                        img: "assets/img/land.svg",
                        color: Color(0xFF484848),
                        title: "My Lands",
                      ),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data == "Agri Service Provider") {
                    return InkWell(
                      onTap: () {
                        Get.to(() => ProductView());
                      },
                      child: ListTilesWidget(
                        img: "assets/img/categoryP.svg",
                        color: Color(0xFF484848),
                        title: "Products/Services",
                      ),
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return CircularProgressIndicator(); // Return a loading indicator while fetching user role
                }
              },
            ),
            InkWell(
              onTap: () {
                Get.to(() => AllEnquiries());
              },
              child: ListTilesWidget(
                img: "assets/logos/chat 1.svg",
                title: "My Conversation",
              ),
            ),
            ListTilesWidget(
              img: "assets/more/guarantee.svg",
              title: "Subscription",
            ),
            InkWell(
              child: ListTilesWidget(
                img: "assets/more/calculator.svg",
                title: "Crop Yield Calculator",
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => ChatGptStartScreen());
              },
              child: ListTilesWidget(
                img: "assets/more/Vector.svg",
                title: "AI Assistant",
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => MarketPrices());
              },
              child: ListTilesWidget(
                img: "assets/more/price.svg",
                title: "Market Prices",
              ),
            ),
            ListTilesWidget(
              img: "assets/more/customer.svg",
              title: "Contact Us",
            ),
            ListTilesWidget(
              img: "assets/more/about.svg",
              title: "About Us",
            ),
            InkWell(
              onTap: () {
                Get.to(() => FeedBackScreen());
              },
              child: ListTilesWidget(
                img: "assets/more/about.svg",
                title: "Feedback",
              ),
            ),
            InkWell(
              onTap: () {
                controller.prefs.logout();
                Get.offAll(EmailLogin());
              },
              child: ListTilesWidget(
                img: "assets/more/power.svg",
                title: "Logout",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListTilesWidget extends StatefulWidget {
  ListTilesWidget(
      {super.key, required this.title, required this.img, this.color});
  String img = "";
  String title = "";
  Color? color;

  @override
  State<ListTilesWidget> createState() => _ListTilesWidgetState();
}

class _ListTilesWidgetState extends State<ListTilesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: SvgPicture.asset(
              "${widget.img}",
              width: 25,
              color: widget.color,
            ),
            title: Text(
              '${widget.title}',
              style: GoogleFonts.poppins(
                color: Color(0xFF484848),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            ),
          ),
        ),
        Row(
          children: List.generate(
              450 ~/ 4,
              (index) => Expanded(
                    child: Container(
                      color: index % 2 == 0
                          ? Colors.transparent
                          : AppColor.GREY_BORDER,
                      height: 1,
                    ),
                  )),
        ),
      ],
    );
  }
}
