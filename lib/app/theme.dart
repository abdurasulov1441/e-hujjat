import 'package:flutter/material.dart';

abstract final class MyColors {
  static const primary = Color(0xff7F2828);
  static const primaryDisabled = Color(0xffE3CFCF);
  static const background = Color(0xfff3f3f3);
  static const white = Color(0xffffffff);
  static const card = Color(0xffffffff);
  static const black = Color(0xff000000);
  static const text = Color(0xff090909);
  static const hint = Color(0xff797979);
  static const icon = Color(0xffababab);
  static const text2 = Color(0xffababab);
  static const shadow = Color(0xffe7e7e7);
  static const error = Color(0xffff0000);
  static const green = Color(0xff00B06C);
  static const transparent = Colors.transparent;
  static const green20 = Color(0xfff3f9ec);
  static const red = Color(0xffF76B6B);
  static const red20 = Color(0xfffef0f0);

  static const cyan = Color(0xff00DADA);
  static const purple = Color(0xff9013DD);

  static const uzcardBg = Color(0xff6B94F7);
  static const humoBg = Color(0xffF7C76B);
}

final myTheme = ThemeData(
  scaffoldBackgroundColor: MyColors.background,
  hintColor: MyColors.hint,
  colorScheme: ColorScheme.fromSeed(
    seedColor: MyColors.primary,
  ),
  checkboxTheme: CheckboxThemeData(
    visualDensity: VisualDensity.compact,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3),
    ),
    side: BorderSide(
      width: 1.3,
      color: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MyColors.primary;
        }

        return MyColors.icon;
      }),
    ),
  ),
);
