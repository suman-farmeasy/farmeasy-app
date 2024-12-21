import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Screens/Threads/CreateThreads/View/create_threads.dart';

class CommonAppBar extends StatefulWidget {
  CommonAppBar(
      {super.key,
      required this.title,
      this.isbackButton = true,
      this.postButton = false,
      this.onBackPressed});
  final bool? isbackButton;
  final bool? postButton;
  String title = "";
  final VoidCallback? onBackPressed;
  @override
  State<CommonAppBar> createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.DARK_GREEN,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(
          top: isIOS ? 55.h : 40.h,
          left: widget.title == 'Community' ? 50.w : 10.w,
          right: widget.title == 'New Post' ? 50.w : 0.w,
          bottom: 0,
        ),
        child: Row(
          children: [
            widget.isbackButton == true
                ? IconButton(
                    onPressed: widget.onBackPressed ?? Get.back,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 17.sp, // Responsive icon size
                    ),
                  )
                : Container(),
            const Spacer(),
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 17.sp, // Responsive font size
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
            const Spacer(),
            widget.postButton == false
                ? Container()
                : GestureDetector(
                    onTap: () {
                      Get.to(() => const CreateThreads());
                    },
                    child: Container(
                      width: Get.width * 0.15,
                      height: Get.width * 0.15,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF9F9DF),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: Get.width * 0.4,
                          child: SvgPicture.asset("assets/logos/thread.svg"),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    );
  }
}
