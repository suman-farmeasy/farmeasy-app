import 'package:flutter/material.dart';

class AppColor {
  static const Color DARK_GREEN = Color(0xfff044D3A);
  static const Color BACKGROUND = Color(0xfffFFFFF0);
  static const Color CART_BACKGROUND = Color(0xfffFFFFF8);
  static const Color LIGHT_GREEN = Color(0xfff167C0C);
  static const Color INACTIVE_COLOR = Color(0xfff167C0C);
  static const Color GREY_BORDER = Color(0xFFE3E3E3);
  static const Color BROWN_TEXT = Color(0xfff483C32);
  static Color BROWN_SUBTEXT = Color(0xfff483C32).withOpacity(0.74);
  static Color GREEN_SUBTEXT = Color(0xfff044D3A).withOpacity(0.64);
  static Gradient PRIMARY_GRADIENT = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xfff1f881f).withOpacity(0.30),
      Color(0xfffFFE546).withOpacity(0.30),
    ],
  );
  static Gradient WHITE_GRADIENT = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white,
      Colors.white,
    ],
  );
  static Gradient BLUE_GREEN_GRADIENT = LinearGradient(
    end: Alignment(0.99, 0.10),
    begin: Alignment(-0.99, -0.1),
    colors: [
      Color(0xfff00E3AE).withOpacity(0.20),
      Color(0xfff9BE15D).withOpacity(0.20),
    ],
  );
  static Gradient YELLOW_GRADIENT = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xfffFFE7AA),
      Color(0xfffFFF9E3),
    ],
  );

  static BoxShadow BOX_SHADOW = BoxShadow(
    color: Color(0xFF000000).withOpacity(0.12),
    offset: Offset(0, 2),
    blurRadius: 10,
    blurStyle: BlurStyle.inner,
  );
  static const Color CHATGPTBACKGROUNDCOLOR = Color(0xfff343541);
  static const Color CHATGPTSENDCOLOR = Color(0xfff10A37F);
}
