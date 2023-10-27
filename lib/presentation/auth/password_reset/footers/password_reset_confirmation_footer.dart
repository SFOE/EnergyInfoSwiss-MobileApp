import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/utils/auth/auth_utils.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/domain/services/password_service.dart';
import 'package:energy_dashboard/presentation/components/auth/auth_footer.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/primary_button.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PasswordResetConfirmationFooter extends StatelessWidget {
  final List<TextEditingController> codeControllers;
  const PasswordResetConfirmationFooter({super.key, required this.codeControllers});

  @override
  Widget build(BuildContext context) {
    return AuthFooter(
      children: [
        ValueListenableBuilder(
          valueListenable: context.read<PasswordService>().isLoading,
          builder: (context, loading, _){
            return PrimaryButton(
              title: Translations.of(context)!.text('button.title.reset-password'),
              callback: () async => await context.read<PasswordService>().setNewPassword(AuthUtils().getCodeByControllers(codeControllers), context),
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
