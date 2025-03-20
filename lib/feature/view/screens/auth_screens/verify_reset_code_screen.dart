import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/utils/validator.dart';
import 'package:ecommerce_app/feature/view/screens/auth_screens/reset_password_screen.dart';
import 'package:ecommerce_app/feature/view/widgets/auth_widgets/custom_button.dart';
import 'package:ecommerce_app/feature/view/widgets/auth_widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controller/auth_cubit/auth_cubit.dart';
import '../../../controller/auth_cubit/auth_states.dart';

class VerifyResetCodeScreen extends StatelessWidget {
  VerifyResetCodeScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _resetCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is VerifyResetCodeSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Reset code verified successfully!'),
              backgroundColor: ColorManager.success,
            ),
          );
          HelperFunctions.navigateTo(context, ResetPasswordScreen());
        } else if (state is VerifyResetCodeErrorState) {
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
                        'Verify Reset Code',
                        style: getBoldStyle(color: ColorManager.black)
                            .copyWith(fontSize: FontSize.s28),
                      ),
                      SizedBox(height: Sizes.s8),
                      Text(
                        'Enter the reset code sent to your email.',
                        style: getLightStyle(color: ColorManager.grey)
                            .copyWith(fontSize: FontSize.s16),
                      ),
                      SizedBox(height: Sizes.s50),
                      CustomTextField(
                        backgroundColor: ColorManager.white,
                        hint: 'Enter reset code',
                        label: 'Reset Code',
                        textInputType: TextInputType.number,
                        validation: Validator.validateResetCode,
                        controller: _resetCodeController,
                      ),
                      SizedBox(height: Sizes.s28),
                      Center(
                        child: SizedBox(
                          child: state is VerifyResetCodeLoadingState
                              ? CircularProgressIndicator(
                                  color: ColorManager.primary,
                                )
                              : CustomButton(
                                  label: 'Verify Code',
                                  backgroundColor: ColorManager.primary,
                                  isStadiumBorder: false,
                                  textStyle: getBoldStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSize.s18,
                                  ),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      AuthCubit.get(context).verifyResetCode(
                                        _resetCodeController.text,
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
