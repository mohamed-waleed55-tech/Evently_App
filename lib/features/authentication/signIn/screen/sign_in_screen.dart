import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/core/utils/dialog.dart';
import 'package:evently/features/authentication/widgets/dont_have_account_row.dart';
import 'package:evently/features/authentication/widgets/header_logo.dart';
import 'package:evently/features/authentication/widgets/login_form.dart';
import 'package:evently/features/authentication/widgets/social_login_section.dart';
import 'package:evently/features/authentication/widgets/wavy_background_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/login_cubit.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context, LoginCubit cubit) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      cubit.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            DialogUtils.showLoadingDialog(context, "Logging in...");
          } else if (state is LoginSuccess) {
            DialogUtils.hideDialog(context);
            if (context.mounted) {
              Navigator.pushReplacementNamed(
                context,
                RoutesManager.mainLayout,
              );
            }
          } else if (state is LoginFailure) {
            DialogUtils.hideDialog(context);
            DialogUtils.showMessage(
              context,
              title: "Error",
              message: state.errorMessage,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: colorScheme.surface,
              body: CustomPaint(
                painter: VerticalWavyBackgroundPainter(
                  primaryColor: colorScheme.primary,
                  secondaryColor: colorScheme.secondary,
                ),
                child: SafeArea(
                  child: LayoutBuilder(
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
                                SizedBox(height: 10.h),

                                // --- Header Logo Component ---
                                const HeaderLogo(),

                                SizedBox(height: 24.h),

                                // --- Main Form Card Container ---
                                Container(
                                  padding: REdgeInsets.all(20),
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      LoginForm(
                                        formKey: _formKey,
                                        emailController: _emailController,
                                        passwordController: _passwordController,
                                        isSecure: cubit.isSecure,
                                        isLoading: state is LoginLoading,
                                        onTogglePassword: cubit.togglePasswordVisibility,
                                        onSubmit: () => _onLoginPressed(context, cubit),
                                      ),
                                      SizedBox(height: 16.h),
                                      const DontHaveAccountRow(),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 24.h),

                                // --- Social Login Section ---
                                SocialLoginSection(
                                  onGoogleClick: () => cubit.loginWithGoogle(),
                                ),

                                SizedBox(height: 16.h),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}