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
import 'package:ecommerce_app/feature/controller/order_cubit/user_order_cubit.dart';
import 'package:ecommerce_app/feature/model/order_model/order_repository.dart';
import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';
import 'package:flutter/scheduler.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Load user orders with debug prints
    final userId = CashHelper.getData(key: 'userId');
    print('User ID from cache: $userId'); // Debug print
    if (userId != null) {
      print('Fetching orders for user: $userId'); // Debug print
      context.read<UserOrderCubit>().getUserOrders(userId);
    } else {
      print('No user ID found in cache'); // Debug print
      // Try to get user ID from profile data
      final userData = CashHelper.getData(key: 'userData');
      if (userData != null && userData['id'] != null) {
        print('Found user ID in userData: ${userData['id']}'); // Debug print
        context.read<UserOrderCubit>().getUserOrders(userData['id']);
      } else {
        print('No user ID found in userData either'); // Debug print
        // Try to get user ID from token
        final token = CashHelper.getToken();
        if (token != null) {
          print('Found token, attempting to decode for user ID'); // Debug print
          // Verify token to get user ID
          context.read<AuthCubit>().verifyToken().then((_) {
            if (mounted) {
              final newUserId = CashHelper.getData(key: 'userId');
              if (newUserId != null) {
                print('Successfully retrieved user ID from token: $newUserId'); // Debug print
                context.read<UserOrderCubit>().getUserOrders(newUserId);
              } else {
                print('Failed to get user ID from token'); // Debug print
                // Schedule showing the SnackBar after the frame is built
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Unable to fetch orders: User ID not found'),
                        backgroundColor: ColorManager.error,
                      ),
                    );
                  }
                });
              }
            }
          });
        }
      }
    }
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
            CustomTextField(
              controller: detailsController,
              label: 'Address Details',
              hint: 'Enter address details',
              textInputType: TextInputType.streetAddress,
              validation: (value) => value?.isEmpty ?? true ? 'Address details are required' : null,
            ),
            SizedBox(height: Sizes.s12),
            CustomTextField(
              controller: phoneController,
              label: 'Phone Number',
              hint: 'Enter phone number',
              textInputType: TextInputType.phone,
              validation: (value) => value?.isEmpty ?? true ? 'Phone number is required' : null,
            ),
            SizedBox(height: Sizes.s12),
            CustomTextField(
              controller: cityController,
              label: 'City',
              hint: 'Enter city name',
              textInputType: TextInputType.text,
              validation: (value) => value?.isEmpty ?? true ? 'City is required' : null,
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

  void _showEditAddressDialog(ShippingAddress address, int index) {
    final detailsController = TextEditingController(text: address.details);
    final phoneController = TextEditingController(text: address.phone);
    final cityController = TextEditingController(text: address.city);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: detailsController,
              label: 'Address Details',
              hint: 'Enter address details',
              textInputType: TextInputType.streetAddress,
              validation: (value) => value?.isEmpty ?? true ? 'Address details are required' : null,
            ),
            SizedBox(height: Sizes.s12),
            CustomTextField(
              controller: phoneController,
              label: 'Phone Number',
              hint: 'Enter phone number',
              textInputType: TextInputType.phone,
              validation: (value) => value?.isEmpty ?? true ? 'Phone number is required' : null,
            ),
            SizedBox(height: Sizes.s12),
            CustomTextField(
              controller: cityController,
              label: 'City',
              hint: 'Enter city name',
              textInputType: TextInputType.text,
              validation: (value) => value?.isEmpty ?? true ? 'City is required' : null,
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
                final updatedAddress = ShippingAddress(
                  details: detailsController.text,
                  phone: phoneController.text,
                  city: cityController.text,
                );
                context.read<ShippingAddressCubit>().updateAddress(index, updatedAddress);
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAddressConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Address'),
        content: Text('Are you sure you want to delete this address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ShippingAddressCubit>().deleteAddress(index);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.error,
            ),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is ProfileSuccessState) {
          final userData = state.userData;
          setState(() {
            _nameController.text = userData['name'] ?? '';
            _emailController.text = userData['email'] ?? '';
            _phoneController.text = userData['phone'] ?? '';
            // Update saved values
            _savedName = userData['name'];
            _savedEmail = userData['email'];
            _savedPhone = userData['phone'];
          });
        } else if (state is UpdateProfileSuccessState) {
          // Update saved values with new data
          final userData = state.userData;
          setState(() {
            if (userData['name'] != null) _savedName = userData['name'];
            if (userData['email'] != null) _savedEmail = userData['email'];
            if (userData['phone'] != null) _savedPhone = userData['phone'];
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: ColorManager.success,
              duration: Duration(seconds: 2),
            ),
          );
          _resetEditState();
        } else if (state is ProfileErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: ColorManager.error,
              duration: Duration(seconds: 2),
            ),
          );
          _resetEditState();
        } else if (state is UpdateProfileErrorState) {
          // Revert the field values to their previous state
          setState(() {
            if (!_isEmailReadOnly) {
              _emailController.text = _savedEmail ?? '';
            }
            if (!_isFullNameReadOnly) {
              _nameController.text = _savedName ?? '';
            }
            if (!_isPhoneReadOnly) {
              _phoneController.text = _savedPhone ?? '';
            }
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: ColorManager.error,
              duration: Duration(seconds: 2),
            ),
          );
          _resetEditState();
        }
      },
      builder: (context, state) {
        return BlocListener<AuthCubit, AuthStates>(
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
              automaticallyImplyLeading: false,
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
            body: Padding(
              padding: EdgeInsets.all(Insets.s20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Header (Always Visible)
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
                          _savedName ?? _nameController.text,
                          style: getSemiBoldStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s24,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          _savedEmail ?? _emailController.text,
                          style: getRegularStyle(
                            color: ColorManager.primary.withOpacity(.5),
                            fontSize: FontSize.s16,
                          ),
                        ),
                      ),
                      SizedBox(height: Sizes.s30),

                      // Profile Information Section
                      ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                          'Edit Profile',
                          style: getSemiBoldStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s20,
                          ),
                        ),
                        children: [
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
                          SizedBox(height: Sizes.s20),
                        ],
                      ),
                      SizedBox(height: Sizes.s20),

                      // Shipping Addresses Section
                      ExpansionTile(
                        initiallyExpanded: false,
                        title: Text(
                          'Shipping Addresses',
                          style: getSemiBoldStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s20,
                          ),
                        ),
                        children: [
                          BlocBuilder<ShippingAddressCubit, ShippingAddressState>(
                            builder: (context, state) {
                              if (state is ShippingAddressLoading) {
                                return Center(child: CircularProgressIndicator());
                              } else if (state is ShippingAddressLoaded) {
                                if (state.addresses.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No addresses added yet',
                                      style: getRegularStyle(
                                        color: ColorManager.grey,
                                        fontSize: FontSize.s16,
                                      ),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.addresses.length,
                                  itemBuilder: (context, index) {
                                    final address = state.addresses[index];
                                    return Card(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: Sizes.s8,
                                        vertical: Sizes.s8,
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          address.details,
                                          style: getMediumStyle(
                                            color: ColorManager.primary,
                                            fontSize: FontSize.s16,
                                          ),
                                        ),
                                        subtitle: Text(
                                          '${address.city} - ${address.phone}',
                                          style: getRegularStyle(
                                            color: ColorManager.grey,
                                            fontSize: FontSize.s14,
                                          ),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: ColorManager.primary,
                                              ),
                                              onPressed: () => _showEditAddressDialog(address, index),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: ColorManager.error,
                                              ),
                                              onPressed: () => _showDeleteAddressConfirmation(index),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is ShippingAddressError) {
                                return Center(
                                  child: Text(
                                    state.message,
                                    style: getRegularStyle(
                                      color: ColorManager.error,
                                      fontSize: FontSize.s16,
                                    ),
                                  ),
                                );
                              }
                              return SizedBox();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.all(Sizes.s16),
                            child: ElevatedButton.icon(
                              onPressed: _showAddAddressDialog,
                              icon: Icon(Icons.add),
                              label: Text('Add New Address'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.primary,
                                foregroundColor: ColorManager.white,
                                minimumSize: Size(double.infinity, Sizes.s50),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Sizes.s20),

                      // Orders Section
                      ExpansionTile(
                        initiallyExpanded: false,
                        title: Text(
                          'Order History',
                          style: getSemiBoldStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s20,
                          ),
                        ),
                        children: [
                          BlocBuilder<UserOrderCubit, UserOrderState>(
                            builder: (context, state) {
                              if (state is UserOrderLoading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: ColorManager.primary,
                                  ),
                                );
                              } else if (state is UserOrderLoaded) {
                                if (state.orders.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No orders yet',
                                      style: getRegularStyle(
                                        fontSize: FontSize.s16,
                                        color: ColorManager.grey,
                                      ),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.orders.length,
                                  itemBuilder: (context, index) {
                                    final order = state.orders[index];
                                    return Card(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: Sizes.s8,
                                        vertical: Sizes.s8,
                                      ),
                                      child: ExpansionTile(
                                        title: Text(
                                          'Order #${order.id}',
                                          style: getMediumStyle(
                                            color: ColorManager.primary,
                                            fontSize: FontSize.s16,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Total: \$${order.totalPrice.toStringAsFixed(2)}',
                                          style: getRegularStyle(
                                            color: ColorManager.grey,
                                            fontSize: FontSize.s14,
                                          ),
                                        ),
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(Sizes.s16),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Order Details',
                                                  style: getSemiBoldStyle(
                                                    color: ColorManager.primary,
                                                    fontSize: FontSize.s16,
                                                  ),
                                                ),
                                                SizedBox(height: Sizes.s8),
                                                Text(
                                                  'Payment Method: ${order.paymentMethod}',
                                                  style: getRegularStyle(
                                                    color: ColorManager.grey,
                                                    fontSize: FontSize.s14,
                                                  ),
                                                ),
                                                Text(
                                                  'Status: ${order.isPaid ? "Paid" : "Pending"}',
                                                  style: getRegularStyle(
                                                    color: order.isPaid ? ColorManager.success : ColorManager.warning,
                                                    fontSize: FontSize.s14,
                                                  ),
                                                ),
                                                Text(
                                                  'Delivery: ${order.isDelivered ? "Delivered" : "In Progress"}',
                                                  style: getRegularStyle(
                                                    color: order.isDelivered ? ColorManager.success : ColorManager.warning,
                                                    fontSize: FontSize.s14,
                                                  ),
                                                ),
                                                SizedBox(height: Sizes.s8),
                                                Text(
                                                  'Shipping Address',
                                                  style: getSemiBoldStyle(
                                                    color: ColorManager.primary,
                                                    fontSize: FontSize.s16,
                                                  ),
                                                ),
                                                SizedBox(height: Sizes.s4),
                                                Text(
                                                  order.shippingAddress.details,
                                                  style: getRegularStyle(
                                                    color: ColorManager.grey,
                                                    fontSize: FontSize.s14,
                                                  ),
                                                ),
                                                Text(
                                                  '${order.shippingAddress.city} - ${order.shippingAddress.phone}',
                                                  style: getRegularStyle(
                                                    color: ColorManager.grey,
                                                    fontSize: FontSize.s14,
                                                  ),
                                                ),
                                                SizedBox(height: Sizes.s8),
                                                Text(
                                                  'Items',
                                                  style: getSemiBoldStyle(
                                                    color: ColorManager.primary,
                                                    fontSize: FontSize.s16,
                                                  ),
                                                ),
                                                SizedBox(height: Sizes.s4),
                                                ...order.cartItems.map((item) => Padding(
                                                  padding: EdgeInsets.symmetric(vertical: Sizes.s4),
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(Sizes.s8),
                                                        child: Image.network(
                                                          item.product.imageCover,
                                                          width: Sizes.s50,
                                                          height: Sizes.s50,
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context, error, stackTrace) => Container(
                                                            width: Sizes.s50,
                                                            height: Sizes.s50,
                                                            color: ColorManager.grey.withOpacity(0.2),
                                                            child: Icon(Icons.error),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: Sizes.s8),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              item.product.title,
                                                              style: getMediumStyle(
                                                                color: ColorManager.primary,
                                                                fontSize: FontSize.s14,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Quantity: ${item.count}',
                                                              style: getRegularStyle(
                                                                color: ColorManager.grey,
                                                                fontSize: FontSize.s12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        '\$${item.price.toStringAsFixed(2)}',
                                                        style: getMediumStyle(
                                                          color: ColorManager.primary,
                                                          fontSize: FontSize.s14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )).toList(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else if (state is UserOrderError) {
                                return Center(
                                  child: Text(
                                    state.message,
                                    style: getRegularStyle(
                                      color: ColorManager.error,
                                      fontSize: FontSize.s16,
                                    ),
                                  ),
                                );
                              }
                              return SizedBox();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: Sizes.s20),

                      BlocBuilder<ProfileCubit, ProfileStates>(
                        builder: (context, state) {
                          if (state is ProfileLoadingState || state is UpdateProfileLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.primary,
                              ),
                            );
                          }
                          return SizedBox();
                        },
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
        // Don't reset edit state here, wait for the response
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
