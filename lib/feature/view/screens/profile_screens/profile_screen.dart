import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/utils/validator.dart';
import 'package:ecommerce_app/feature/controller/profile_cubit/profile_cubit.dart';
import 'package:ecommerce_app/feature/controller/profile_cubit/profile_states.dart';
import 'package:ecommerce_app/feature/controller/shipping_address_cubit/shipping_address_cubit.dart';
import 'package:ecommerce_app/feature/model/shipping_address_model.dart';
import 'package:ecommerce_app/feature/view/widgets/auth_widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/feature/controller/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:ecommerce_app/feature/controller/auth_cubit/auth_states.dart';
import 'package:ecommerce_app/feature/controller/order_cubit/get_all_orders_cubit.dart' as get_orders_cubit;
import 'package:ecommerce_app/feature/controller/order_cubit/order_cubit.dart' as order_cubit;
import 'package:ecommerce_app/feature/model/order_model/order_repository.dart';
import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';

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
    context.read<ShippingAddressCubit>().loadAddresses();
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

  void _showAddAddressDialog() {
    final detailsController = TextEditingController();
    final phoneController = TextEditingController();
    final cityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: detailsController,
              decoration: InputDecoration(labelText: 'Address Details'),
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextFormField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (detailsController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty &&
                  cityController.text.isNotEmpty) {
                final address = ShippingAddress(
                  details: detailsController.text,
                  phone: phoneController.text,
                  city: cityController.text,
                );
                context.read<ShippingAddressCubit>().addAddress(address);
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
    }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<order_cubit.OrderCubit>(
      create: (_) => order_cubit.OrderCubit(OrderRepository(dioHelper: DioHelper())),
      child: BlocListener<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is LogoutLoadingState) {
            // Optionally show a loading indicator
          } else if (state is LogoutErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
          // On LogoutSuccessState, navigation is already handled in the cubit
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () {
                  AuthCubit.get(context).logout(context);
                },
              ),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.all(16),
            children: [
              // Profile Header
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorManager.primary,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _savedName ?? 'User Name',
                            style: getBoldStyle(fontSize: 20, color: ColorManager.primary),
                          ),
                          Text(
                            _savedEmail ?? 'user@email.com',
                            style: getRegularStyle(fontSize: 14, color: ColorManager.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Edit Profile Section
              BlocListener<ProfileCubit, ProfileStates>(
                listener: (context, state) {
                  if (state is UpdateProfileSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profile updated!')),
                    );
                    _loadUserData();
                  } else if (state is UpdateProfileErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  } else if (state is ProfileSuccessState) {
                    // Update controllers with new data
                    final userData = state.userData;
                    if (userData['name'] != null) _nameController.text = userData['name'];
                    if (userData['email'] != null) _emailController.text = userData['email'];
                    if (userData['phone'] != null) _phoneController.text = userData['phone'];
                  }
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Edit Profile',
                          style: getBoldStyle(fontSize: 18, color: ColorManager.primary),
                        ),
                        SizedBox(height: 16),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                readOnly: _isFullNameReadOnly,
                                decoration: InputDecoration(
                                  labelText: 'Full Name',
                                  suffixIcon: IconButton(
                                    icon: Icon(_isFullNameReadOnly ? Icons.edit : Icons.check),
                                    onPressed: () {
                                      setState(() {
                                        _isFullNameReadOnly = !_isFullNameReadOnly;
                                        if (!_isFullNameReadOnly) {
                                          _updateProfile();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                controller: _emailController,
                                readOnly: _isEmailReadOnly,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  suffixIcon: IconButton(
                                    icon: Icon(_isEmailReadOnly ? Icons.edit : Icons.check),
                                    onPressed: () {
                                      setState(() {
                                        _isEmailReadOnly = !_isEmailReadOnly;
                                        if (!_isEmailReadOnly) {
                                          _updateProfile();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                controller: _phoneController,
                                readOnly: _isPhoneReadOnly,
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                  suffixIcon: IconButton(
                                    icon: Icon(_isPhoneReadOnly ? Icons.edit : Icons.check),
                                    onPressed: () {
                                      setState(() {
                                        _isPhoneReadOnly = !_isPhoneReadOnly;
                                        if (!_isPhoneReadOnly) {
                                          _updateProfile();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Shipping Addresses Section
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shipping Addresses',
                            style: getBoldStyle(fontSize: 18, color: ColorManager.primary),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: _showAddAddressDialog,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      BlocBuilder<ShippingAddressCubit, ShippingAddressState>(
                        builder: (context, state) {
                          if (state is ShippingAddressLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is ShippingAddressLoaded) {
                            if (state.addresses.isEmpty) {
                              return Center(
                                child: Text('No addresses added yet'),
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.addresses.length,
                              itemBuilder: (context, index) {
                                final address = state.addresses[index];
                                return ListTile(
                                  title: Text(address.details),
                                  subtitle: Text('${address.city} - ${address.phone}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          // TODO: Implement edit address
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          context.read<ShippingAddressCubit>().deleteAddress(index);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else if (state is ShippingAddressError) {
                            return Center(
                              child: Text(state.message),
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Orders Section
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order History',
                        style: getBoldStyle(fontSize: 18, color: ColorManager.primary),
                      ),
                      SizedBox(height: 16),
                      Center(child: Text('Order history (coming soon)', style: getRegularStyle(fontSize: 16, color: ColorManager.grey))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateProfile() {
    String? nameError = _validateField(_nameController.text, !_isFullNameReadOnly);
    String? emailError = _validateEmail(_emailController.text);
    String? phoneError = _validateField(_phoneController.text, !_isPhoneReadOnly);

    if (nameError == null && emailError == null && phoneError == null) {
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
      }
    }
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
}
