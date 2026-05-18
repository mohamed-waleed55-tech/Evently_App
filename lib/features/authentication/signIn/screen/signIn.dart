import 'package:evently/core/app_validators/app_validators.dart';
import 'package:evently/core/resources/images/images_manager.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/core/utils/dialog.dart';
import 'package:evently/core/widgets/login_with_google.dart';
import 'package:evently/features/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/features/authentication/widgets/custom_text_button.dart';
import 'package:evently/features/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/features/authentication/widgets/or_shape.dart';
import 'package:evently/l10n/app_localizations.dart';
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
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            DialogUtils.showLoadingDialog(context, "Logging in...");
          } else if (state is LoginSuccess) {
            DialogUtils.hideDialog(context);
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
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
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: REdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 8.h),
                                  Center(
                                    child: Image.asset(
                                      ImagesManager.logo,
                                      height: 120.h,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),

                                  CustomTextFormField(
                                    controller: emailController,
                                    validator: AppValidators.validateEmail,
                                    label: AppLocalizations.of(context)!.email,
                                    prefixIcon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    autofillHints: const [AutofillHints.email],
                                  ),
                                  SizedBox(height: 16.h),

                                  CustomTextFormField(
                                    controller: passwordController,
                                    validator: AppValidators.validatePassword,
                                    label: AppLocalizations.of(
                                      context,
                                    )!.password,
                                    prefixIcon: Icons.lock_outline,
                                    isSecure: cubit.isSecure,
                                    suffixIcon: cubit.isSecure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    onClick: () =>
                                        cubit.togglePasswordVisibility(),
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    autofillHints: const [
                                      AutofillHints.password,
                                    ],
                                  ),
                                  SizedBox(height: 16.h),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomTextButton(
                                        title: AppLocalizations.of(
                                          context,
                                        )!.forget_password,
                                        onClick: () {
                                          Navigator.pushNamed(
                                            context,
                                            RoutesManager.forgetPassword,
                                          );
                                        },
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 24.h),

                                  CustomElevatedButton(
                                    title: state is LoginLoading
                                        ? "Loading..."
                                        : AppLocalizations.of(context)!.login,
                                    onClick: state is LoginLoading
                                        ? null
                                        : () => login(context, cubit),
                                  ),
                                  SizedBox(height: 24.h),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                              context,
                                            )?.dont_have_account ??
                                            "Don't have an account?",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                      CustomTextButton(
                                        title:AppLocalizations.of(context)?.create_account?? "Create Account",
                                        onClick: () {
                                          Navigator.pushNamed(
                                            context,
                                            RoutesManager.signUp,
                                          );
                                        },
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 30.h),

                                  const OrShape(),
                                  SizedBox(height: 30.h),

                                  LoginWithProviders(
                                    title: AppLocalizations.of(
                                      context,
                                    )!.login_with_google,
                                    onClick: () => cubit.loginWithGoogle(),
                                  ),
                                  SizedBox(height: 10.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void login(BuildContext context, LoginCubit cubit) {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      cubit.login(emailController.text.trim(), passwordController.text.trim());
    }
  }
}
