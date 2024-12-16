import 'package:farm_easy/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatefulWidget {
  CommonAppBar(
      {super.key,
      required this.title,
      this.isbackButton = true,
      this.onBackPressed});
  final bool? isbackButton;
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
          left: 10.w,
          right: 30.w,
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
            Spacer(),
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 17.sp, // Responsive font size
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
            Spacer(),
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
