import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/View/login_page.dart';
import 'package:farm_easy/Screens/OnboardingScreen/controller/intro_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/image_constant.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _pageController = PageController();
  final controller = Get.put(IntropageController());

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: controller.titles.length,
                  onPageChanged: (index) {
                    controller.dotPage.value = index;
                  },
                  itemBuilder: (context, index) {
                    return IntroductionPage(
                      title: controller.titles[index],
                      subtitle: controller.subtitles[index],
                      imagePath: controller.imagePaths[index],
                    );
                  },
                ),
              ),
              Obx(
                () => Center(
                  child: Container(
                      // margin: EdgeInsets.only(bottom: 0,top: 10),
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(controller.titles.length, (index) {
                      bool isActive = controller.dotPage == index.obs;
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: isActive ? 10 * 2.5 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(5),
                              right: Radius.circular(5)),
                          color: isActive ? AppColor.DARK_GREEN : Colors.grey,
                        ),
                      );
                    }),
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // if (controller.currentPage != controller.titles.length - 1)
                    //   TextButton(
                    //     onPressed: () {
                    //       _pageController.jumpToPage(controller.titles.length - 1);
                    //     },
                    //     child: Text(
                    //       "Skip",
                    //       style: GoogleFonts.poppins(
                    //         color: Color(0xFF044D3A),
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ),

                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColor.DARK_GREEN,
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            if (controller.dotPage.value ==
                                controller.titles.length - 1) {
                              Get.to(() => (LoginPage()));
                            } else {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Hero(
              tag: 'logo',
              child: SvgPicture.asset(
                ImageConstants.LOGO_TEXT,
                width: Get.width * 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IntroductionPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  IntroductionPage({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: Get.height * 0.65,
          child: SvgPicture.asset(
            imagePath,
            width: double.infinity,
          ),
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
              color: Color(0xFF483C32),
              fontSize: 22,
              fontWeight: FontWeight.w600,
              height: 0),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              subtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Color(0xBC483C32),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
