import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/utils/validator.dart';
import 'package:ecommerce_app/feature/view/widgets/auth_widgets/text_form.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen();

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool _isFullNameReadOnly = true;
  bool _isEmailReadOnly = true;
  bool _isPasswordReadOnly = true;
  bool _isPhoneReadOnly = true;
  bool _isAddressReadOnly = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Insets.s20),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              SizedBox(height: Sizes.s20),
              Text(
                'Welcome, Mohamed',
                style: getSemiBoldStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s18,
                ),
              ),
              Text(
                'mohamed.N@gmail.com',
                style: getRegularStyle(
                  color: ColorManager.primary.withOpacity(.5),
                  fontSize: FontSize.s14,
                ),
              ),
              SizedBox(height: Sizes.s18),
              CustomTextField(
                borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                readOnly: _isFullNameReadOnly,
                backgroundColor: ColorManager.white,
                hint: 'Enter your full name',
                label: 'Full Name',
                controller:
                    TextEditingController(text: 'Mohamed Mohamed Nabil'),
                labelTextStyle: getMediumStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s18,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => setState(() => _isFullNameReadOnly = false),
                ),
                textInputType: TextInputType.text,
                validation: Validator.validateFullName,
                hintTextStyle: getRegularStyle(color: ColorManager.primary)
                    .copyWith(fontSize: 18),
              ),
              SizedBox(height: Sizes.s18),
              CustomTextField(
                borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                readOnly: _isEmailReadOnly,
                backgroundColor: ColorManager.white,
                hint: 'Enter your email address',
                label: 'E-mail address',
                controller: TextEditingController(text: 'mohamed.N@gmail.com'),
                labelTextStyle: getMediumStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s18,
                ),
                suffixIcon: IconButton(
                  icon:  Icon(Icons.edit),
                  onPressed: () => setState(() => _isEmailReadOnly = false),
                ),
                textInputType: TextInputType.emailAddress,
                validation: Validator.validateEmail,
                hintTextStyle: getRegularStyle(color: ColorManager.primary)
                    .copyWith(fontSize: 18),
              ),
              SizedBox(height: Sizes.s18),
              CustomTextField(
                onTap: () => setState(() => _isPasswordReadOnly = false),
                controller: TextEditingController(text: '123456789123456'),
                borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                readOnly: _isPasswordReadOnly,
                backgroundColor: ColorManager.white,
                hint: 'Enter your password',
                label: 'Password',
                isObscured: true,
                labelTextStyle: getMediumStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s18,
                ),
                suffixIcon: Icon(Icons.edit),
                textInputType: TextInputType.text,
                validation: Validator.validatePassword,
                hintTextStyle: getRegularStyle(color: ColorManager.primary)
                    .copyWith(fontSize: 18),
              ),
              SizedBox(height: Sizes.s18),
              CustomTextField(
                controller: TextEditingController(text: '01122118855'),
                borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                readOnly: _isPhoneReadOnly,
                backgroundColor: ColorManager.white,
                hint: 'Enter your mobile no.',
                label: 'Your mobile number',
                labelTextStyle: getMediumStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s18,
                ),
                suffixIcon: IconButton(
                  icon:  Icon(Icons.edit),
                  onPressed: () => setState(() => _isPhoneReadOnly = false),
                ),
                textInputType: TextInputType.phone,
                validation: Validator.validatePhoneNumber,
                hintTextStyle: getRegularStyle(color: ColorManager.primary)
                    .copyWith(fontSize: 18),
              ),
              SizedBox(height: Sizes.s18),
              CustomTextField(
                controller:
                    TextEditingController(text: '6th October, street 11.....'),
                borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                readOnly: _isAddressReadOnly,
                backgroundColor: ColorManager.white,
                hint: '6th October, street 11.....',
                label: 'Your Address',
                labelTextStyle: getMediumStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s18,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => setState(() => _isAddressReadOnly = false),
                ),
                textInputType: TextInputType.streetAddress,
                validation: Validator.validateFullName,
                hintTextStyle: getRegularStyle(color: ColorManager.primary)
                    .copyWith(fontSize: 18),
              ),
              SizedBox(height: Sizes.s50),
            ],
          ),
        ),
      ),
    );
  }
}
