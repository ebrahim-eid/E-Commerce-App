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
import 'package:ecommerce_app/feature/controller/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/feature/controller/auth_cubit/auth_states.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration successful!'),backgroundColor: ColorManager.success,),
          );
          HelperFunctions.navigateAndRemove(context, LoginScreen());
        } else if (state is SignUpErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
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
                      Text(
                        'Sign Up',
                        style: getBoldStyle(color: ColorManager.black)
                            .copyWith(fontSize: FontSize.s28),
                      ),
                      SizedBox(
                        height: Sizes.s8,
                      ),
                      Text(
                        'Create an account to get started!',
                        style: getLightStyle(color: ColorManager.grey)
                            .copyWith(fontSize: FontSize.s16),
                      ),
                      SizedBox(
                        height: Sizes.s50,
                      ),
                      CustomTextField(
                        backgroundColor: ColorManager.white,
                        hint: 'Enter your full name',
                        label: 'Full Name',
                        textInputType: TextInputType.name,
                        validation: Validator.validateFullName,
                        controller: _nameController,
                      ),
                      SizedBox(
                        height: Sizes.s18,
                      ),
                      CustomTextField(
                        hint: 'Enter your Phone number',
                        backgroundColor: ColorManager.white,
                        label: 'Mobile Number',
                        validation: Validator.validatePhoneNumber,
                        textInputType: TextInputType.phone,
                        controller: _phoneController,
                      ),
                      SizedBox(
                        height: Sizes.s18,
                      ),
                      CustomTextField(
                        hint: 'examble@gmail.com',
                        backgroundColor: ColorManager.white,
                        label: 'E-mail address',
                        validation: Validator.validateEmail,
                        textInputType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      SizedBox(
                        height: Sizes.s18,
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
                        height: Sizes.s18,
                      ),
                      CustomTextField(
                        hint: '********',
                        backgroundColor: ColorManager.white,
                        label: 'Confirm Password',
                        validation: (val) => Validator.validateConfirmPassword(
                          val,
                          _passwordController.text,
                        ),
                        isObscured: true,
                        textInputType: TextInputType.text,
                        controller: _rePasswordController,
                      ),
                      SizedBox(
                        height: Sizes.s28,
                      ),
                      Center(
                        child: SizedBox(
                          height: Sizes.s60,
                          width: MediaQuery.sizeOf(context).width * .9,
                          child: state is SignUpLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  label: 'Sign Up',
                                  backgroundColor: ColorManager.primary,
                                  isStadiumBorder: false,
                                  textStyle: getBoldStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSize.s20,
                                  ),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      AuthCubit.get(context).signUp(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        rePassword: _rePasswordController.text,
                                        phone: _phoneController.text,
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
                            'Already have an account?',
                            style: getSemiBoldStyle(color: ColorManager.black)
                                .copyWith(fontSize: FontSize.s16),
                          ),
                          SizedBox(
                            width: Sizes.s8,
                          ),
                          GestureDetector(
                            onTap: () => HelperFunctions.navigateAndRemove(context,  LoginScreen()),
                            child: Text(
                              'Login',
                              style: getSemiBoldStyle(color: ColorManager.primary)
                                  .copyWith(fontSize: FontSize.s16, decoration: TextDecoration.underline),
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }
}