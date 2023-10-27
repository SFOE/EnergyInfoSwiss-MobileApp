import 'package:energy_dashboard/core/resources/gaps.dart';
import 'package:energy_dashboard/core/utils/auth/auth_utils.dart';
import 'package:energy_dashboard/core/utils/translations.dart';
import 'package:energy_dashboard/core/utils/utils.dart';
import 'package:energy_dashboard/domain/services/registration_service.dart';
import 'package:energy_dashboard/presentation/components/auth/auth_footer.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/checkbox_data_privacy.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/primary_button.dart';
import 'package:energy_dashboard/presentation/components/auth/control_elements/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RegistrationFooter extends StatefulWidget {
  final AnimationController modalAnimationController;
  const RegistrationFooter({super.key, required this.modalAnimationController});

  @override
  State<RegistrationFooter> createState() => _RegistrationFooterState();
}

class _RegistrationFooterState extends State<RegistrationFooter> {

  late final RegistrationService _registrationService;
  late bool _acceptedDataPrivacy;

  @override
  void initState() {
    super.initState();
    _acceptedDataPrivacy = false;
    _registrationService = context.read<RegistrationService>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthFooter(
      children: [
        CheckboxDataPrivacy(
          checkboxCallback: (checked) => setState(() => _acceptedDataPrivacy = checked),
          openDataPrivacyModalCallback: () => Utils().openDataPrivacyModal(
            context: context,
            animationController: widget.modalAnimationController
          ),
        ),
        Gaps.vSpacingXS,
        ValueListenableBuilder(
          valueListenable: _registrationService.isLoadingVerification,
          builder: (context, loading, _) {
            return PrimaryButton(
              title: Translations.of(context)!.text('button.title.verify-email'),
              callback: () async => AuthUtils().sendRegistrationCode(
                context: context,
                registrationService: _registrationService,
                animationController: widget.modalAnimationController
              ),
              isDisabled: !_acceptedDataPrivacy,
              isLoading: loading,
            );
          }
        ),
        Gaps.vSpacingS,
        SecondaryButton(
          title: Translations.of(context)!.text('button.title.cancel'),
          callback: () => Navigator.of(context).pop()
        ),
      ],
    );
  }
}
