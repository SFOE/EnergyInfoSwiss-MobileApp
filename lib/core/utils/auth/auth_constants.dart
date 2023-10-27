import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class AuthConst{

  static const double kAuthInstructionsFontSize = 14.6;
  static const double kAuthModalBorderRadius = 12;
  static const double kAuthModalCloseButtonSize = 26;
  static const int kCodeDigits = 6;
  static const double kCodeDigitFieldSize = 42;
  static const double kLoginAppTitleFontSize = 26;
  static const double kLoginSwissFlagSize = 42;
  static const double kPrimaryButtonBorderRadius = 8;
  static const double kPrimaryButtonHeight = 48;
  static const double kPrimaryButtonLoadingSpinnerSize = 22;
  static const double kSecondaryButtonHeight = 36;
  static const double kSecondaryButtonSmallHeight = 32;
  static const double kTextFieldBorderRadius = 6;
  static const double kTextFieldBorderWidth = 1;
  static const double kTextFieldErrorFontSize = 14;
  static const double kTextFieldFontSize = 14.5;
  static const double kTextFieldHintFontSize = 14.5;
  static const double kTextFieldLabelFontSize = 13.5;
  static const double kTextfieldContentPadding = Paddings.paddingXS;
  static const double kTextFieldSuffixIconSize = 22;
  static const int kButtonShrinkAnimationDuration = 120;


  // Border styles
  static final OutlineInputBorder kTextfieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
    borderSide: const BorderSide(
      width: kTextFieldBorderWidth,
      color: ColorPalette.primaryColor,
    ),
  );

  static final OutlineInputBorder kTextfieldBorderEnabled = OutlineInputBorder(
    borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
    borderSide: const BorderSide(
      width: kTextFieldBorderWidth,
      color: ColorPalette.textFieldBorderColor,
    ),
  );

  static final OutlineInputBorder kTextfieldBorderFocused = OutlineInputBorder(
    borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
    borderSide: const BorderSide(
      width: kTextFieldBorderWidth,
      color: ColorPalette.textFieldBorderFocusColor,
    ),
  );


  // Text styles
  static const TextStyle kTextFieldLabelTextStyle = TextStyle(fontSize: kTextFieldLabelFontSize, color: ColorPalette.textColor);
  static const TextStyle kTextFieldHintTextStyle = TextStyle(fontSize: kTextFieldHintFontSize, color: ColorPalette.textColorLight);
  static const TextStyle kTextFieldErrorTextStyle = TextStyle(fontSize: kTextFieldErrorFontSize, height: 1);
  static const TextStyle kTextFieldTextStyle = TextStyle(fontSize: kTextFieldFontSize, color: ColorPalette.textColor, textBaseline: TextBaseline.alphabetic);
  static const TextStyle kPrimaryButtonTextStyle = TextStyle(fontSize: 17.5, color: ColorPalette.white, fontWeight: FontWeight.w400);
  static const TextStyle kPrimaryButtonOutlinedTextStyle = TextStyle(fontSize: 17.5, color: ColorPalette.primaryColor, fontWeight: FontWeight.w400);
  static const TextStyle kSecondaryButtonTextStyle = TextStyle(fontSize: 16, color: ColorPalette.primaryColor, fontWeight: FontWeight.w400);
  static const TextStyle kSecondaryButtonSmallTextStyle = TextStyle(fontSize: 13.5, color: ColorPalette.primaryColor, fontWeight: FontWeight.w400);
  static const TextStyle kCodeDigitFieldTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPalette.textColor);
  static const TextStyle kAuthModalTitleTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorPalette.textColor);
  static const TextStyle kAuthModalInfoTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: ColorPalette.textColor);

  // Box Decorations
  static final BoxDecoration kPrimaryButtonBoxDecoration = BoxDecoration(borderRadius: BorderRadius.circular(kPrimaryButtonBorderRadius), color: ColorPalette.primaryColor);
  static final BoxDecoration kPrimaryButtonOutlinedBoxDecoration = BoxDecoration(borderRadius: BorderRadius.circular(kPrimaryButtonBorderRadius), color: ColorPalette.white, border: Border.all(color: ColorPalette.primaryColor, width: 1.4));
  static const BoxDecoration kAuthModalBoxDecorationShadow = BoxDecoration(boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 26, spreadRadius: 0, offset: Offset.zero)]);
  static const BoxDecoration kAuthModalBoxDecoration = BoxDecoration(color: ColorPalette.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(kAuthModalBorderRadius), topRight: Radius.circular(kAuthModalBorderRadius)));

  // Other
  static const Widget kPrimaryButtonLoadingSpinner = SpinKitThreeBounce(color: ColorPalette.white, size: kPrimaryButtonLoadingSpinnerSize);

  static const SizedBox kAuthModalTopGap = SizedBox(height: 52, width: double.infinity);

}