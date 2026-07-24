import 'package:evently/features/authentication/signUp/cubit/sign_up_cubit.dart';
import 'package:evently/features/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SignUpSubmitButton extends StatelessWidget {
  final RegisterState state;
  final AppLocalizations loc;
  final VoidCallback onPressed;

  const SignUpSubmitButton({
    super.key, 
    required this.state,
    required this.loc,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      title: state is RegisterLoading ? "Registering..." : loc.create_account,
      onClick: state is RegisterLoading ? null : onPressed,
    );
  }
}