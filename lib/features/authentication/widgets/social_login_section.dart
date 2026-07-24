import 'package:evently/core/widgets/login_with_google.dart';
import 'package:evently/features/authentication/widgets/or_shape.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialLoginSection extends StatelessWidget {
  final VoidCallback onGoogleClick;

  const SocialLoginSection({
    super.key,
    required this.onGoogleClick,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      children: [
        const OrShape(),
        SizedBox(height: 24.h),
        LoginWithProviders(
          title: loc.login_with_google,
          onClick: onGoogleClick,
        ),
      ],
    );
  }
}