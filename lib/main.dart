import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/helpers/dio_helper/dio_helper.dart';
import 'core/helpers/cashe_helper/shared_prefernce.dart';
import 'feature/controller/bloc_observer.dart';
import 'feature/controller/auth_cubit/auth_cubit.dart';
import 'feature/controller/cart_cubit/cart_cubit.dart';
import 'feature/controller/category_cubit/category_cubit.dart';
import 'feature/controller/home_cubit/home_cubit.dart';
import 'feature/controller/onboarding_cubit/on_boarding_cubit.dart';
import 'feature/controller/order_cubit/order_cubit.dart';
import 'feature/controller/order_cubit/user_order_cubit.dart';
import 'feature/controller/profile_cubit/profile_cubit.dart';
import 'feature/controller/product_cubit/product_cubit.dart';
import 'feature/controller/shipping_address_cubit/shipping_address_cubit.dart';
import 'feature/controller/sub_category_cubit/sub_category_cubit.dart';
import 'feature/controller/wishlist_cubit/get_wishlist_cubit.dart';
import 'feature/controller/wishlist_cubit/wishlist_cubit.dart';
import 'feature/model/categories_model/category_repository.dart';
import 'feature/model/order_model/order_repository.dart';
import 'feature/model/sub_category_model/sub_category_repository.dart';
import 'feature/model/wishlist_model/wishlist_repository.dart';
import 'feature/view/screens/splash_screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnBoardingCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(create: (context) => ShippingAddressCubit()),
        BlocProvider(
          create: (context) => OrderCubit(OrderRepository(dioHelper: DioHelper())),
        ),
        BlocProvider(
          create: (context) => UserOrderCubit(OrderRepository(dioHelper: DioHelper())),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit(
            CategoryRepository(DioHelper()),
          )..fetchCategories(),
        ),
        BlocProvider(
          create: (context) => SubCategoryCubit(
            SubCategoryRepository(),
          )..fetchSubCategories(),
        ),
        BlocProvider(
          create: (context) => WishlistCubit(WishlistApi()),
        ),
        BlocProvider(
          create: (context) => GetWishlistCubit(WishlistApi()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}