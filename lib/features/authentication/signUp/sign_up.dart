import 'package:evently/features/authentication/widgets/header_logo.dart';
import 'package:evently/features/authentication/widgets/sign_up_form_fields.dart';
import 'package:evently/features/authentication/widgets/sign_up_submit_button.dart';
import 'package:evently/features/authentication/widgets/wavy_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/routes/routes_manager.dart';
import '../../../core/utils/dialog.dart';
import '../../../l10n/app_localizations.dart';
import 'cubit/sign_up_cubit.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _rePasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed(RegisterCubit cubit) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      cubit.register(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final loc = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: colorScheme.surface,
          body: Stack(
            children: [
              const WavyBackground(),

             SafeArea(
  bottom: false,
  child: LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 20.h,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: IntrinsicHeight(
            child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterLoading) {
                  DialogUtils.showLoadingDialog(
                    context,
                    "Registering...",
                  );
                } else if (state is RegisterSuccess) {
                  DialogUtils.hideDialog(context);
                  DialogUtils.showMessage(
                    context,
                    title: "Success",
                    message: "Account created successfully",
                    posActionTitle: "Ok",
                    posAction: () => Navigator.pushReplacementNamed(
                      context,
                      RoutesManager.signIn,
                    ),
                  );
                } else if (state is RegisterFailure) {
                  DialogUtils.hideDialog(context);
                  DialogUtils.showMessage(
                    context,
                    title: "Error",
                    message: state.errorMessage,
                  );
                }
              },
              builder: (context, state) {
                final cubit = context.read<RegisterCubit>();

                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 40.h),

                      const HeaderLogo(),

                      SizedBox(height: 24.h),

                      Container(
                        padding: REdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: colorScheme.surface.withValues(alpha: .85),
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(
                            color: colorScheme.outlineVariant.withValues(alpha: .4),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .04),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.register,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 20.h),

                            SignUpFormFields(
                              nameController: _nameController,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              rePasswordController: _rePasswordController,
                              cubit: cubit,
                              loc: loc,
                            ),

                            SizedBox(height: 28.h),

                            SignUpSubmitButton(
                              state: state,
                              loc: loc,
                              onPressed: () => _onRegisterPressed(cubit),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  ),
),

              // Back Button
              Positioned(
                top: MediaQuery.of(context).padding.top + 8.h,
                left: 16.w,
                child: IconButton(
                  icon: Container(
                    padding: REdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withValues(alpha: 0.6),
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
            ],
          ),
        ),
      ),
    );
  }
}