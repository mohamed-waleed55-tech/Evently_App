import 'package:evently/core/resources/images/images_manager.dart';
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
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.forget_password),
          centerTitle: true,
        ),
        body: SafeArea(
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

                  return SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20.h),

                          Image.asset(
                            ImagesManager.forgetPassword,
                            height: 200.h,
                            fit: BoxFit.contain,
                          ),

                          SizedBox(height: 16.h),

                          CustomTextFormField(
                            label: AppLocalizations.of(context)!.email,
                            prefixIcon: Icons.email,
                            controller: cubit.emailController,
                          ),

                          SizedBox(height: 16.h),

                          CustomElevatedButton(
                            title: AppLocalizations.of(context)!.reset_password,
                            onClick: () => cubit.resetPassword(),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}