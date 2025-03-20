import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/utils/validator.dart';
import 'package:ecommerce_app/feature/view/screens/auth_screens/forgot_password_screen.dart';
import 'package:ecommerce_app/feature/view/screens/auth_screens/register_screen.dart';
import 'package:ecommerce_app/feature/view/screens/home_screens/home_screen.dart';
import 'package:ecommerce_app/feature/view/widgets/onboarding_widgets/auth_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/onboarding_widgets/auth_widgets/text_form.dart';
import '../../../controller/auth_cubit/auth_cubit.dart';
import '../../../controller/auth_cubit/auth_states.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
    final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Logged in successfully!'),
              backgroundColor: ColorManager.success,
            ),
          );
          HelperFunctions.navigateAndRemove(context, HomeScreen());
        } else if (state is LoginErrorState) {
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
                      SizedBox(
                        height: Sizes.s40,
                      ),
                      SizedBox(
                        height: Sizes.s40,
                      ),
                      Text(
                        'Sign In',
                        style: getBoldStyle(color: ColorManager.black)
                            .copyWith(fontSize: FontSize.s28),
                      ),
                      SizedBox(
                        height: Sizes.s8,
                      ),
                      Text(
                        'Welcome back, you’ve been missed!',
                        style: getLightStyle(color: ColorManager.grey)
                            .copyWith(fontSize: FontSize.s16),
                      ),
                      SizedBox(
                        height: Sizes.s50,
                      ),
                      CustomTextField(
                        backgroundColor: ColorManager.white,
                        hint: 'examble@gmail.com',
                        label: 'Email',
                        textInputType: TextInputType.emailAddress,
                        validation: Validator.validateEmail,
                        controller: _emailController,
                      ),
                      SizedBox(
                        height: Sizes.s28,
                      ),
                      CustomTextField(
                        hint: '********',
                        backgroundColor: ColorManager.white,
                        label: 'Password',
                        validation: Validator.validatePassword,
                        isObscured: true,
                        textInputType: TextInputType.text,
                        controller: _passwordController,
                      ),
                      SizedBox(
                        height: Sizes.s8,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTap: () => HelperFunctions.navigateTo(context, ForgotPasswordScreen()),
                            child: Text(
                              'Forget password?',
                              style: getMediumStyle(color: ColorManager.primary).copyWith(
                                fontSize: FontSize.s16,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Sizes.s28,
                      ),
                      Center(
                        child: SizedBox(
                          child: state is LoginLoadingState
                              ? CircularProgressIndicator(
                                  color: ColorManager.white,
                                )
                              : CustomButton(
                                  label: 'Sign In',
                                  backgroundColor: ColorManager.primary,
                                  isStadiumBorder: false,
                                  textStyle: getBoldStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSize.s18,
                                  ),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      AuthCubit.get(context).loginUser(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );
                                    }
                                  },
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account?',
                            style: getSemiBoldStyle(color: ColorManager.black)
                                .copyWith(fontSize: FontSize.s16),
                          ),
                          SizedBox(
                            width: Sizes.s8,
                          ),
                          GestureDetector(
                            onTap: () => HelperFunctions.navigateAndRemove(context,  RegisterScreen()),
                            child: Text(
                              'Sign Up',
                              style: getSemiBoldStyle(color: ColorManager.primary)
                                  .copyWith(fontSize: FontSize.s16,decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
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
