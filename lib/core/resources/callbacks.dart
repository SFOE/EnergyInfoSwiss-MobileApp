import 'package:flutter/material.dart';


/// Function Typedefs
/// resp. Callbacks

typedef LocaleChangeCallback = void Function(Locale locale);
typedef LoadingCallback = Function(bool isLoading);
typedef CheckboxCallback = Function(bool checked);
typedef ResendCodeCallback = Function();
typedef OnChangeCallback = Function(String change);
typedef VerifyCallback = Function(String code);