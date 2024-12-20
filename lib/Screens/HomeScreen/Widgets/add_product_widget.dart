import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/utils/localization/localization_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Constants/color_constants.dart';
import '../../ProductAndServices/View/add_product.dart';

class AddProductWidget extends StatelessWidget {
  AddProductWidget({
    super.key,
  });

  final localeController = Get.put(LocaleController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const AddProduct());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: AppColor.YELLOW_GRADIENT,
          border: Border.all(color: AppColor.BROWN_SUBTEXT, width: 0.2),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20, left: 5),
                child: DottedBorder(
                  color: Colors.grey,
                  borderType: BorderType.RRect,
                  dashPattern: const [4, 4],
                  radius: const Radius.circular(12),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          Get.to(() => const AddProduct());
                        },
                        icon: const Icon(
                          Icons.add_rounded,
                          color: AppColor.BROWN_TEXT,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add New Product'.tr,
                    style: GoogleFonts.poppins(
                      color: AppColor.BROWN_TEXT,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: Text(
                      'To find relevant product and services'.tr,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF666666),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
