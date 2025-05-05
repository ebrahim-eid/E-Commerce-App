import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/utils/validator.dart';
import 'package:ecommerce_app/feature/controller/profile_cubit/profile_cubit.dart';
import 'package:ecommerce_app/feature/controller/profile_cubit/profile_states.dart';
import 'package:ecommerce_app/feature/view/widgets/auth_widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/feature/controller/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isFullNameReadOnly = true;
  bool _isEmailReadOnly = true;
  bool _isPhoneReadOnly = true;

  String? _savedEmail;
  String? _savedName;
  String? _savedPhone;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    // Load saved user data
    _savedName = CashHelper.getData(key: 'userName');
    _savedEmail = CashHelper.getData(key: 'userEmail');
    _savedPhone = CashHelper.getPhone();

    if (_savedName != null) _nameController.text = _savedName!;
    if (_savedEmail != null) _emailController.text = _savedEmail!;
    if (_savedPhone != null) _phoneController.text = _savedPhone!;

    // Get profile data from cubit
    ProfileCubit.get(context).getUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String? _validateField(String? value, bool isEditing) {
    if (!isEditing) return null;
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailError = Validator.validateEmail(value);
    if (emailError != null) {
      return emailError;
    }
    if (!_isEmailReadOnly && value == _savedEmail) {
      return 'This is your current email';
    }
    return null;
  }

  void _resetEditState() {
    setState(() {
      _isFullNameReadOnly = true;
      _isEmailReadOnly = true;
      _isPhoneReadOnly = true;
    });
  }

  void _updateProfile() {
    // Only validate the field being edited
    String? nameError = _validateField(_nameController.text, !_isFullNameReadOnly);
    String? emailError = _validateEmail(_emailController.text);
    String? phoneError = _validateField(_phoneController.text, !_isPhoneReadOnly);

    if (nameError == null && emailError == null && phoneError == null) {
      // Only send non-empty values
      final Map<String, String> updateData = {};
      
      if (!_isFullNameReadOnly && _nameController.text != _savedName) {
        updateData['name'] = _nameController.text;
      }
      
      if (!_isEmailReadOnly && _emailController.text != _savedEmail) {
        updateData['email'] = _emailController.text;
      }
      
      if (!_isPhoneReadOnly && _phoneController.text != _savedPhone) {
        updateData['phone'] = _phoneController.text;
      }

      if (updateData.isNotEmpty) {
        ProfileCubit.get(context).updateProfile(
          name: updateData['name'],
          email: updateData['email'],
          phone: updateData['phone'],
        );
      } else {
        // If no fields were edited, just reset the read-only states
        _resetEditState();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No changes to update'),
            backgroundColor: ColorManager.warning,
          ),
        );
      }
    } else {
      // Show error for the field being edited
      if (nameError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(nameError),
            backgroundColor: ColorManager.error,
          ),
        );
      }
      if (emailError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(emailError),
            backgroundColor: ColorManager.error,
          ),
        );
      }
      if (phoneError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(phoneError),
            backgroundColor: ColorManager.error,
          ),
        );
      }
      _resetEditState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is ProfileSuccessState) {
          final userData = state.userData;
          _nameController.text = userData['name'] ?? '';
          _emailController.text = userData['email'] ?? '';
          _phoneController.text = userData['phone'] ?? '';
        } else if (state is UpdateProfileSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: ColorManager.success,
            ),
          );
          _resetEditState();
        } else if (state is ProfileErrorState || state is UpdateProfileErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state is ProfileErrorState ? state.error : (state as UpdateProfileErrorState).error),
              backgroundColor: ColorManager.error,
            ),
          );
          _resetEditState();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: ColorManager.primary,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            AuthCubit.get(context).logout(context);
                          },
                          child: Text('Logout'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(Insets.s20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: ColorManager.primary.withOpacity(0.1),
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                    SizedBox(height: Sizes.s20),
                    Center(
                      child: Text(
                        _nameController.text,
                        style: getSemiBoldStyle(
                          color: ColorManager.primary,
                          fontSize: FontSize.s24,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        _emailController.text,
                        style: getRegularStyle(
                          color: ColorManager.primary.withOpacity(.5),
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ),
                    SizedBox(height: Sizes.s30),
                    CustomTextField(
                      borderBackgroundColor: ColorManager.primary.withOpacity(.5),
                      readOnly: _isFullNameReadOnly,
                      backgroundColor: ColorManager.white,
                      hint: 'Enter your full name',
                      label: 'Full Name',
                      controller: _nameController,
                      labelTextStyle: getMediumStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s18,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_isFullNameReadOnly ? Icons.edit : Icons.check),
                        onPressed: () {
                          if (_isFullNameReadOnly) {
                            setState(() {
                              _isFullNameReadOnly = false;
                              _isEmailReadOnly = true;
                              _isPhoneReadOnly = true;
                            });
                          } else {
                            _updateProfile();
                          }
                        },
                      ),
                      textInputType: TextInputType.text,
                      validation: (value) => _validateField(value, !_isFullNameReadOnly),
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
                      controller: _emailController,
                      labelTextStyle: getMediumStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s18,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_isEmailReadOnly ? Icons.edit : Icons.check),
                        onPressed: () {
                          if (_isEmailReadOnly) {
                            setState(() {
                              _isEmailReadOnly = false;
                              _isFullNameReadOnly = true;
                              _isPhoneReadOnly = true;
                            });
                          } else {
                            _updateProfile();
                          }
                        },
                      ),
                      textInputType: TextInputType.emailAddress,
                      validation: _validateEmail,
                      hintTextStyle: getRegularStyle(color: ColorManager.primary)
                          .copyWith(fontSize: 18),
                    ),
                    SizedBox(height: Sizes.s18),
                    CustomTextField(
                      controller: _phoneController,
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
                        icon: Icon(_isPhoneReadOnly ? Icons.edit : Icons.check),
                        onPressed: () {
                          if (_isPhoneReadOnly) {
                            setState(() {
                              _isPhoneReadOnly = false;
                              _isFullNameReadOnly = true;
                              _isEmailReadOnly = true;
                            });
                          } else {
                            _updateProfile();
                          }
                        },
                      ),
                      textInputType: TextInputType.phone,
                      validation: (value) => _validateField(value, !_isPhoneReadOnly),
                      hintTextStyle: getRegularStyle(color: ColorManager.primary)
                          .copyWith(fontSize: 18),
                    ),
                    SizedBox(height: Sizes.s50),
                    if (state is ProfileLoadingState || state is UpdateProfileLoadingState)
                      Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
