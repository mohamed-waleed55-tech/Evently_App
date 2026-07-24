import 'package:evently/features/authentication/widgets/wavy_background_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/dialog.dart';
import '../../../../l10n/app_localizations.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../cubit/forget_password_cubit.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final loc = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              padding: REdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.surface.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: colorScheme.onSurface,
                size: 18.sp,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: CustomPaint(
          painter: VerticalWavyBackgroundPainter(
            primaryColor: colorScheme.primary,
            secondaryColor: colorScheme.secondary,
          ),
          child: SafeArea(
            child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordLoading) {
                  DialogUtils.showLoadingDialog(context, "Sending reset email...");
                } else if (state is ForgetPasswordError) {
                  DialogUtils.hideDialog(context);
                  DialogUtils.showMessage(
                    context,
                    title: "Error",
                    message: state.errorMessage,
                    posActionTitle: "Ok",
                    posAction: () {
                      context.read<ForgetPasswordCubit>().resetPassword();
                    },
                  );
                } else if (state is ForgetPasswordSuccess) {
                  DialogUtils.hideDialog(context);
                  DialogUtils.showMessage(
                    context,
                    title: "Success",
                    message: state.message,
                    posActionTitle: "Ok",
                    posAction: () {
                      Navigator.pop(context);
                    },
                  );
                }
              },
              child: Builder(
                builder: (context) {
                  final cubit = context.read<ForgetPasswordCubit>();

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Padding(
                            padding: REdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // --- Main Card Container ---
                                Container(
                                  padding: REdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: colorScheme.surface.withOpacity(0.85),
                                    borderRadius: BorderRadius.circular(24.r),
                                    border: Border.all(
                                      color: colorScheme.outlineVariant.withOpacity(0.4),
                                      width: 1.w,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Form(
                                    key: cubit.formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          loc.forget_password,
                                          style: theme.textTheme.headlineSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.onSurface,
                                          ),
                                        ),
                                        SizedBox(height: 20.h),

                                        CustomTextFormField(
                                          label: loc.email,
                                          prefixIcon: Icons.email_outlined,
                                          controller: cubit.emailController,
                                          keyboardType: TextInputType.emailAddress,
                                        ),

                                        SizedBox(height: 24.h),

                                        CustomElevatedButton(
                                          title: loc.reset_password,
                                          onClick: () => cubit.resetPassword(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}