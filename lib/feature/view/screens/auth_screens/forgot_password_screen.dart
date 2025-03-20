import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/utils/validator.dart';
import 'package:ecommerce_app/feature/view/screens/auth_screens/verify_reset_code_screen.dart';
import 'package:ecommerce_app/feature/view/widgets/onboarding_widgets/auth_widgets/custom_button.dart';
import 'package:ecommerce_app/feature/view/widgets/onboarding_widgets/auth_widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controller/auth_cubit/auth_cubit.dart';
import '../../../controller/auth_cubit/auth_states.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Reset code sent to your email!'),
              backgroundColor: ColorManager.success,
            ),
          );
          CashHelper.setData(key: 'forgot_email', value: _emailController.text);
          HelperFunctions.navigateTo(context, VerifyResetCodeScreen());
        } else if (state is ForgotPasswordErrorState) {
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
                        'Forgot Password',
                        style: getBoldStyle(color: ColorManager.black)
                            .copyWith(fontSize: FontSize.s28),
                      ),
                      SizedBox(height: Sizes.s8),
                      Text(
                        'Enter your email to reset your password.',
                        style: getLightStyle(color: ColorManager.grey)
                            .copyWith(fontSize: FontSize.s16),
                      ),
                      SizedBox(height: Sizes.s50),
                      CustomTextField(
                        backgroundColor: ColorManager.white,
                        hint: 'example@gmail.com',
                        label: 'Email',
                        textInputType: TextInputType.emailAddress,
                        validation: Validator.validateEmail,
                        controller: _emailController,
                      ),
                      SizedBox(height: Sizes.s28),
                      Center(
                        child: SizedBox(
                          child: state is ForgotPasswordLoadingState
                              ? CircularProgressIndicator(
                                  color: ColorManager.primary,
                                )
                              : CustomButton(
                                  label: 'Send Reset Code',
                                  backgroundColor: ColorManager.primary,
                                  isStadiumBorder: false,
                                  textStyle: getBoldStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSize.s18,
                                  ),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      AuthCubit.get(context).forgotPassword(
                                        _emailController.text,
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
