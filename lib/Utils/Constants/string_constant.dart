import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class StringConstatnt {
  static Text FARM_EASY = Text.rich(
    TextSpan(
      children: [
        CustomTextSpan('Farm'),
        CustomTextSpan('Easy'),
      ],
    ),
  );
  static Text WELCOME_TO_FARMEASY = CustomText('Welcome to FarmEasy');
  static Text OTP_VERIFICATION = CustomText('OTP Verification');
  static Text REGISTER_TEXT = CustomText('Please tell us a bit about you');

  static String LANDOWNER = "Land Owner";
  static String FARMER = "Farmer";
  static String AGRI_PROVIDER = "Agri Service Provider";
  static String GOOGLE_PLACES_API = "AIzaSyBnqoT5GnShJwl5n-76kBGNE14VAazAZ9k";
}

// ignore: non_constant_identifier_names
TextSpan CustomTextSpan(String title) {
  return TextSpan(
    text: title,
    style: GoogleFonts.poppins(
      color: const Color(0xFF044D3A),
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 0,
      letterSpacing: -0.24,
    ),
  );
}

// ignore: non_constant_identifier_names
Text CustomText(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: Color(0xFF483C32),
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      height: 0,
      letterSpacing: -0.20,
    ),
  );
}
