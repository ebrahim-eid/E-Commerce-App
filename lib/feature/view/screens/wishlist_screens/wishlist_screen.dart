import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/feature/controller/wishlist_cubit/get_wishlist_cubit.dart';
import 'package:ecommerce_app/feature/model/wishlist_model/wishlist_model.dart';
import 'package:ecommerce_app/feature/view/widgets/wishlist_widgets/wishlist_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:ecommerce_app/feature/controller/wishlist_cubit/wishlist_cubit.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen();

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    final token = CashHelper.getToken();
    if (token != null) {
      context.read<GetWishlistCubit>().getWishlist(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WishlistCubit, WishlistState>(
      listener: (context, state) async {
        if (state is WishlistSuccess) {
          final token = CashHelper.getToken();
          if (token != null) {
            await context.read<GetWishlistCubit>().refreshWishlist(token);
          }
        }
      },
      child: BlocBuilder<GetWishlistCubit, GetWishlistState>(
        builder: (context, state) {
          if (state is GetWishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetWishlistLoaded) {
            final wishlist = state.wishlist;
            if (wishlist.isEmpty) {
              return const Center(child: Text('No items in wishlist'));
            }
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.s14,
        vertical: Sizes.s10,
      ),
      child: ListView.builder(
                itemCount: wishlist.length,
        itemBuilder: (_, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: Sizes.s12),
                  child: WishlistItem(product: wishlist[index], isInWishlist: true),
                ),
        ),
            );
          } else if (state is GetWishlistError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
