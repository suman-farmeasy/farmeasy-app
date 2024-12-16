import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Res/CommonWidget/App_AppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SOP extends StatelessWidget {
  const SOP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.width * 0.16),
        child: CommonAppBar(
          title: 'SOP',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Standard Operating Procedure (SOP) ",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColor.BROWN_TEXT,
                    ),
                  ),
                  TextSpan(
                      text:
                          "for Efficient Negotiation Between Farmers and Landowners",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColor.BROWN_TEXT,
                      )),
                ])),
                SizedBox(height: 10),
                Text(
                  "Purpose",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.BROWN_TEXT),
                ),
                Text(
                  "This SOP aims to provide guidelines for efficient negotiation between farmers and landowners regarding the employment of farmers on a salary basis and the leasing of land. The goal is to ensure clear communication, fair agreements, and mutual benefits.",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.BROWN_TEXT),
                ),
                SizedBox(height: 10),
                Text(
                  "Scope",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.BROWN_TEXT),
                ),
                Text(
                  "This SOP applies to all farmers seeking employment on a salary basis on landowner farms and landowners looking to lease their land to farmers.",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.BROWN_TEXT),
                ),
                SizedBox(height: 10),
                Text(
                  "Procedures",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.BROWN_TEXT),
                ),
                SizedBox(height: 10),
                Text(
                  "1. Initial Preparation",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.BROWN_TEXT),
                ),
                SizedBox(height: 10),
                Text(
                  "1.1 Gather Information",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.BROWN_TEXT),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "  - Landowners should prepare detailed information about the land, including size, soil quality, water availability, previous crops grown, shelter and any restrictions or requirements.\n  -Farmers should showcase their expertise, skills, experience, salary expectations and other requirements in a transparent way",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.BROWN_TEXT),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "1.2 Set Objectives",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.BROWN_TEXT),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "  - Both parties should define their objectives and expectations clearly. Landowners should specify what they require from the farmer, while farmers should outline their salary expectations and any specific needs for the farm operation.",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.BROWN_TEXT),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "2. Initial Meeting",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.BROWN_TEXT),
                ),
                SizedBox(height: 10),
                Text(
                  "2.1 Schedule the Meeting",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.BROWN_TEXT),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "   - Agree on a convenient time and place for the initial meeting. It could be held at the farm, a neutral location, or virtually.",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.BROWN_TEXT),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "2.2 Prepare Documentation",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.BROWN_TEXT),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "- Landowners should bring land documents, previous lease agreements (if any), and any relevant legal documents.\n   - Farmers should bring their portfolio, references, and Aadhar Card for verification. ",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.BROWN_TEXT),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "3. Discussion Points",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.BROWN_TEXT),
                ),
                SizedBox(height: 10),
                Text(
                  "3.1 Landowner's -",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.BROWN_TEXT),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "   - Landowners should present detailed information about the land, soil reports, water sources, shelter, transportation, security and any past issues or challenges.",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.BROWN_TEXT),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "3.2 Farmer's -",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.BROWN_TEXT),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "- Farmers should present their experience, skills, and how they plan to manage the farm. They should also discuss their salary expectations, manpower required, where to sell, availability of transport, etc.",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.BROWN_TEXT),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "3.3 Terms of Employment or Lease",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.BROWN_TEXT),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "- Discuss the length of employment or lease. \n - Agree on the salary or lease amount, payment schedule, and any bonuses or incentives.\n - Outline the responsibilities of both parties (including sales, transportation, input, machinery, etc) \n - Profit sharing (in case of share-profit leasing)",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.BROWN_TEXT),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "This SOP provides a structured approach to negotiation, ensuring both parties have clear expectations and a mutual understanding, leading to successful and fair agreements.",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.BROWN_TEXT),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
