import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/utils/navigation/navigation_utils.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/domain/services/login_service.dart';
import 'package:energy_dashboard/presentation/components/auth/auth_footer.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/primary_button.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/primary_button_outlined.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthFooter(
      children: [
        ValueListenableBuilder(
          valueListenable: context.read<LoginService>().isLoading,
          builder: (context, loading, _){
            return PrimaryButton(
              title: Translations.of(context)!.text('button.title.login'),
              callback: () async => await context.read<LoginService>().signInUser(context),
              isLoading: loading,
            );
          },
        ),
        Gaps.vSpacingS,
        PrimaryButtonOutlined(
          title: Translations.of(context)!.text('button.title.registration'),
          callback: () => Navigation.goToRegistration(),
        ),
        Gaps.vSpacingS,
        SecondaryButton(
          title: Translations.of(context)!.text('button.title.continue-as-guest'),
          callback: () => Navigation.finishOnBoarding(),
        ),
      ],
    );
  }
}
