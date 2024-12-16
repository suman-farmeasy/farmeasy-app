import 'package:farm_easy/Constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatefulWidget {
  CommonAppBar({super.key, required this.title});
  String title = "";
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
        padding: EdgeInsets.only(top: isIOS ? 65 : 40, left: 10, right: 30, bottom: 0),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 17,
              ),
            ),
            Spacer(),
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                height: 0.09,
              ),
            ),
            Spacer(), // This will push the text to the center
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
