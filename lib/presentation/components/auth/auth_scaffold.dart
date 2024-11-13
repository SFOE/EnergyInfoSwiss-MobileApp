import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/core/utils/dismiss_keyboard.dart';
import 'package:energy_dashboard/presentation/components/app_bar/header.dart';
import 'package:flutter/material.dart';


/// This widget applies the auth scaffold design
///
/// It is used only for authentication screens
/// to keep the scaffolds consistent
class AuthScaffold extends StatelessWidget {
  final List<Widget> body;
  final Header? header;
  final Widget footer;
  const AuthScaffold({super.key, required this.body, this.header, required this.footer});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: DismissKeyboard(
        child: Scaffold(
          backgroundColor: ColorPalette.white,
          resizeToAvoidBottomInset: true,
          appBar: header,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Paddings.paddingS),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: body,
                ),
              ),
            ),
          ),
          bottomNavigationBar: footer,
        ),
      ),
    );
  }
}
