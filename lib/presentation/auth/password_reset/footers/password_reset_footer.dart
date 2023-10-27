import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/domain/services/password_service.dart';
import 'package:energy_dashboard/presentation/components/auth/auth_footer.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/primary_button.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PasswordResetFooter extends StatelessWidget {
  const PasswordResetFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthFooter(
      children: [
        ValueListenableBuilder(
            valueListenable: context.read<PasswordService>().isLoading,
            builder: (context, loading, _){
              return PrimaryButton(
                title: Translations.of(context)!.text('button.title.request-code'),
                callback: () async => await context.read<PasswordService>().resetPassword(context),
                isLoading: loading,
              );
            }
        ),
        Gaps.vSpacingXS,
        SecondaryButton(
            title: Translations.of(context)!.text('button.title.cancel'),
            callback: () => context.read<PasswordService>().cancelPasswordReset()
        ),
      ],
    );
  }
}
