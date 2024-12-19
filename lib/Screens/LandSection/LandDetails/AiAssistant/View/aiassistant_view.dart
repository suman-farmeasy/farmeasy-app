import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/Constants/color_constants.dart';
import '../../../../../utils/Constants/image_constant.dart';
import '../../Info/Controller/crop_suggestion_controller.dart';

class AiassistantView extends StatelessWidget {
  AiassistantView({super.key});
  final cropSugestionController = Get.put(CropSuggestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColor.GREY_BORDER),
            boxShadow: [AppColor.BOX_SHADOW],
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    ImageConstants.CHATGPT,
                    width: 40,
                  ),
                  Text(
                    '  Crop suggestions by AI Agri-assistant',
                    style: GoogleFonts.poppins(
                      color: AppColor.BROWN_TEXT,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  )
                ],
              ),
              ListView.builder(
                  itemCount: (cropSugestionController
                                  .cropData.value.result?.length ??
                              0) >
                          8
                      ? 8
                      : cropSugestionController.cropData.value.result?.length ??
                          0,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, suggestion) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cropSugestionController.cropData.value
                                        .result?[suggestion].name ??
                                    "",
                                style: const TextStyle(
                                  color: Color(0xFF044D3A),
                                  fontSize: 11,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Color(0xFFE6E6E6),
                        ),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
