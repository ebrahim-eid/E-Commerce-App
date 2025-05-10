import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_states.dart';
import 'package:ecommerce_app/feature/view/widgets/cart_widgets/cart_item.dart';
import 'package:ecommerce_app/feature/view/widgets/cart_widgets/total_price_and_checkout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/feature/controller/order_cubit/order_cubit.dart';
import 'package:ecommerce_app/core/helpers/dio_helper/dio_helper.dart';
import 'package:ecommerce_app/feature/model/order_model/order_repository.dart';
import 'package:ecommerce_app/feature/model/shipping_address_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        if (state is GetCartErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: ColorManager.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final cartCubit = CartCubit.get(context);
        
        // Load cart data when screen is first built
        if (state is CartInitialState) {
          cartCubit.getCartData();
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Cart',
              style: getMediumStyle(fontSize: 20, color: ColorManager.text),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.delete_forever, color: ColorManager.error),
                tooltip: 'Remove All',
                onPressed: () {
                  final token = CashHelper.getToken();
                  if (token != null) {
                    cartCubit.deleteUserCart(token);
                  }
                },
              ),
            ],
          ),
          body: state is GetCartLoadingState
              ? const Center(child: CircularProgressIndicator())
              : cartCubit.cartModel == null || cartCubit.cartModel!.data.products.isEmpty
                  ? Center(
                      child: Text(
                        'Your cart is empty',
                        style: getMediumStyle(
                          fontSize: 20,
                          color: ColorManager.text,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(Insets.s14),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (_, index) {
                                final item = cartCubit.cartModel!.data.products[index];
                                return CartItem(
                                  cartItem: item,
                                  onQuantityChanged: (count) {
                                    cartCubit.updateCartItemQuantity(
                                      productId: item.productId,
                                      count: count,
                                      token: CashHelper.getToken()!,
                                    );
                                  },
                                  onRemove: () {
                                    cartCubit.removeSpecificCartItem(
                                      id: item.productId,
                                      token: CashHelper.getToken()!,
                                    );
                                  },
                                );
                              },
                              itemCount: cartCubit.cartModel!.data.products.length,
                              separatorBuilder: (_, __) => SizedBox(height: Sizes.s12),
                            ),
                          ),
                          TotalPriceAndCheckoutButton(
                            totalPrice: cartCubit.cartModel!.data.totalCartPrice,
                            checkoutButtonOnTap: () async {
                              final addresses = await ShippingAddressManager.getAddresses();
                              if (addresses.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please add a shipping address in your profile first'),
                                    backgroundColor: ColorManager.error,
                                  ),
                                );
                                return;
                              }

                              int selectedIndex = 0;
                              final selected = await showModalBottomSheet<int>(
                                context: context,
                                builder: (context) {
                                  int tempIndex = selectedIndex;
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Text('Select Shipping Address', style: TextStyle(fontWeight: FontWeight.bold)),
                                          ),
                                          ...List.generate(addresses.length, (i) => RadioListTile<int>(
                                            value: i,
                                            groupValue: tempIndex,
                                            onChanged: (val) => setState(() => tempIndex = val!),
                                            title: Text('${addresses[i].details}, ${addresses[i].city}'),
                                            subtitle: Text(addresses[i].phone),
                                          )),
                                          ElevatedButton(
                                            onPressed: () => Navigator.pop(context, tempIndex),
                                            child: const Text('Continue'),
                                          ),
                                          const SizedBox(height: 16),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                              if (selected != null) {
                                final token = CashHelper.getToken();
                                final cartId = cartCubit.cartModel!.cartId;
                                if (token != null) {
                                  final orderCubit = OrderCubit(OrderRepository(dioHelper: DioHelper()));
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => const Center(child: CircularProgressIndicator()),
                                  );
                                  await orderCubit.createCashOrder(
                                    userId: cartId,
                                    shippingAddress: addresses[selected].toJson(),
                                    token: token,
                                  );
                                  Navigator.pop(context); // Remove loading dialog
                                  if (orderCubit.state is OrderSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Order placed successfully!')),
                                    );
                                    cartCubit.getCartData(); // Refresh cart after order
                                  } else if (orderCubit.state is OrderError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text((orderCubit.state as OrderError).message)),
                                    );
                                  }
                                }
                              }
                            },
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
