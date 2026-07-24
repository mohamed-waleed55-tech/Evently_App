import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/features/authentication/widgets/custom_text_button.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DontHaveAccountRow extends StatelessWidget {
  const DontHaveAccountRow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final loc = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          loc.dont_have_account,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        CustomTextButton(
          title: loc.create_account,
          onClick: () {
            Navigator.pushNamed(
              context,
              RoutesManager.signUp,
            );
          },
        ),
      ],
    );
  }
}