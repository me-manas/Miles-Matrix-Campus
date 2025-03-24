import 'package:flutter/material.dart';

class _PrimaryColor {
  static const Color primary01 = Color(0xFF0C1F33);
  static const Color primary02 = Color(0xFF20466A);
  static const Color primary03 = Color(0xFF102335);
  static const Color primary04 = Color(0xFFFFF4D6);
  static const Color primary05 = Color(0XFFFFDD84);
  static const Color primary06 = Color(0XFFFFBA08);
}

class _SecondaryColor {
  static const Color secondary01 = Color(0xFFA75FE6);
  static const Color secondary02 = Color(0xFFBD22FF);
  static const Color secondary03 = Color(0xFFA19FFF);
  static const Color secondary04 = Color(0xFF99CCFF);
  static const Color secondary05 = Color(0xFFDFEAF7);
  static const Color secondary06 = Color(0xFF3399FF);
}

class _TextColors {
  static const Color textColor01 = Color(0xFFFFFFFF);
  static const Color textColor02 = Color(0xFFE8E8E8);
  static const Color textColor03 = Color(0xFFA1A1AA);
  static const Color textColor04 = Color(0xFF6C6A67);
  static const Color textColor05 = Color(0xFF9DB2CE);
  static const Color textColor06 = Color(0xFF000000);
}

class _ExtraColors {
  // Add new colors here
  static const Color transparent = Colors.transparent;
  static const Color extraColor01 = Color(0xFF00E1FF);
  static const Color extraColor02 = Color(0xFFFF00D4);
  static const Color extraColor03 = Color(0xFF58FF63);
  static const Color extraColor04 = Color(0xFFFF0000);
  static const Color extraColor05 = Color(0xFF131313);
  static const Color extraColor06 = Color(0xFF285785);
  static const Color extraColor07 = Color(0xFF27272A);
  static const Color extraColor08 = Color(0xFF09090B);
}

class AppColors {
  // Primary Colors
  static Color get primary01 => _PrimaryColor.primary01;
  static Color get primary02 => _PrimaryColor.primary02;
  static Color get primary03 => _PrimaryColor.primary03;
  static Color get primary04 => _PrimaryColor.primary04;
  static Color get primary05 => _PrimaryColor.primary05;
  static Color get primary06 => _PrimaryColor.primary06;

  // Secondary Colors
  static Color get secondary01 => _SecondaryColor.secondary01;
  static Color get secondary02 => _SecondaryColor.secondary02;
  static Color get secondary03 => _SecondaryColor.secondary03;
  static Color get secondary04 => _SecondaryColor.secondary04;
  static Color get secondary05 => _SecondaryColor.secondary05;
  static Color get secondary06 => _SecondaryColor.secondary06;

  // Text Colors
  static Color get text01 => _TextColors.textColor01;
  static Color get text02 => _TextColors.textColor02;
  static Color get text03 => _TextColors.textColor03;
  static Color get text04 => _TextColors.textColor04;
  static Color get text05 => _TextColors.textColor05;
  static Color get text06 => _TextColors.textColor06;

  // Extra Colors
  static Color get transparent => _ExtraColors.transparent;
  static Color get extra01 => _ExtraColors.extraColor01;
  static Color get extra02 => _ExtraColors.extraColor02;
  static Color get extra03 => _ExtraColors.extraColor03;
  static Color get extra04 => _ExtraColors.extraColor04;
  static Color get extra05 => _ExtraColors.extraColor05;
  static Color get extra06 => _ExtraColors.extraColor06;
  static Color get extra07 => _ExtraColors.extraColor07;
  static Color get extra08 => _ExtraColors.extraColor08;
}
