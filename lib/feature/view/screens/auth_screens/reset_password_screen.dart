import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/utils/validator.dart';
import 'package:ecommerce_app/feature/view/screens/auth_screens/login_screen.dart';
import 'package:ecommerce_app/feature/view/widgets/auth_widgets/custom_button.dart';
import 'package:ecommerce_app/feature/view/widgets/auth_widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controller/auth_cubit/auth_cubit.dart';
import '../../../controller/auth_cubit/auth_states.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password reset successfully!'),
              backgroundColor: ColorManager.success,
            ),
          );
          HelperFunctions.navigateAndRemove(context, LoginScreen());
        } else if (state is ResetPasswordErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: ColorManager.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Insets.s20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: Sizes.s40),
                      Text(
                        'Reset Password',
                        style: getBoldStyle(color: ColorManager.black)
                            .copyWith(fontSize: FontSize.s28),
                      ),
                      SizedBox(height: Sizes.s8),
                      Text(
                        'Enter your new password.',
                        style: getLightStyle(color: ColorManager.grey)
                            .copyWith(fontSize: FontSize.s16),
                      ),
                      SizedBox(height: Sizes.s50),
                      CustomTextField(
                        backgroundColor: ColorManager.white,
                        hint: '********',
                        label: 'New Password',
                        textInputType: TextInputType.text,
                        validation: Validator.validatePassword,
                        isObscured: true,
                        controller: _passwordController,
                      ),
                      SizedBox(height: Sizes.s28),
                      CustomTextField(
                        backgroundColor: ColorManager.white,
                        hint: '********',
                        label: 'Confirm Password',
                        textInputType: TextInputType.text,
                        validation: (value) => Validator.validateConfirmPassword(
                          value,
                          _passwordController.text,
                        ),
                        isObscured: true,
                        controller: _confirmPasswordController,
                      ),
                      SizedBox(height: Sizes.s28),
                      Center(
                        child: SizedBox(
                          child: state is ResetPasswordLoadingState
                              ? CircularProgressIndicator(
                                  color: ColorManager.primary,
                                )
                              : CustomButton(
                                  label: 'Reset Password',
                                  backgroundColor: ColorManager.primary,
                                  isStadiumBorder: false,
                                  textStyle: getBoldStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSize.s18,
                                  ),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      AuthCubit.get(context).resetPassword(
                                        email: CashHelper.getData(key: 'forgot_email'), 
                                        newPassword: _passwordController.text,
                                      );
                                    }
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
