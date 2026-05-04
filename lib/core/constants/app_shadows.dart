import 'package:flutter/material.dart';

class AppShadows {
  const AppShadows._();

  static List<BoxShadow> get premium => [
    const BoxShadow(
      color: Color(0x14000000), // 8% black (was 4%)
      blurRadius: 20,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
    const BoxShadow(
      color: Color(0x1F000000), // 12% black (was 6%)
      blurRadius: 12,
      offset: Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get premiumHover => [
    const BoxShadow(
      color: Color(0x1F000000), // 12% black (was 8%)
      blurRadius: 40,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
    const BoxShadow(
      color: Color(0x294F46E5), // 16% primary tint (was 12%)
      blurRadius: 24,
      offset: Offset(0, 12),
    ),
  ];

  static List<BoxShadow> get soft => [
    const BoxShadow(
      color: Color(0x14000000), // 8% black (was 3%)
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];
}
