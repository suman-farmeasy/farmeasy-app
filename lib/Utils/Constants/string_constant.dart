import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class StringConstatnt{
  static Text FARM_EASY=Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: 'Farm',
          style: GoogleFonts.poppins(
            color: Color(0xFF167C0C),
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 0,
            letterSpacing: -0.24,),
        ),
        TextSpan(
          text: 'Easy',
          style: GoogleFonts.poppins(
            color: Color(0xFF044D3A),
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 0,
            letterSpacing: -0.24,
          ),
        ),
      ],
    ),
  );
  static Text WELCOME_TO_FARMEASY= Text(
    '👋 Welcome to FarmEasy ',
    style: TextStyle(
      color: Color(0xFF483C32),
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      height: 0,
      letterSpacing: -0.20,
    ),
  );
  static Text OTP_VERIFICATION= Text(
    'OTP Verification ',
    style: TextStyle(
      color: Color(0xFF483C32),
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      height: 0,
      letterSpacing: -0.20,
    ),
  );
  static Text REGISTER_TEXT= Text(
    'Please tell us a bit about you ',
    style: TextStyle(
      color: Color(0xFF483C32),
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      height: 0,
      letterSpacing: -0.20,
    ),
  );
  static String LANDOWNER= "Land Owner";
  static String FARMER= "Farmer";
  static String AGRI_PROVIDER= "Agri Service Provider";
  static String GOOGLE_PLACES_API= "AIzaSyBnqoT5GnShJwl5n-76kBGNE14VAazAZ9k";
}