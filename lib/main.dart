import 'package:ecommerce_app/feature/controller/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/helpers/cashe_helper/shared_prefernce.dart';
import 'core/helpers/dio_helper/dio_helper.dart';
import 'feature/controller/auth_cubit/auth_cubit.dart';
import 'feature/controller/bloc_observer.dart';
import 'feature/controller/onboarding_cubit/on_boarding_cubit.dart';
<<<<<<< HEAD
import 'feature/view/screens/splash_screens/splash_screen.dart';
=======
import 'feature/controller/product_cubit/product_cubit.dart';
import 'feature/view/screens/auth_screens/login_screen.dart';
import 'feature/view/screens/home_screens/home_screen.dart';
import 'feature/view/screens/onboarding_screen/on_boarding_screen.dart';
import 'feature/view/screens/test.dart';
>>>>>>> ibrahim

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
<<<<<<< HEAD
  DioHelper.init();
  runApp(MyApp());
=======
  DioHelper().init();
  dynamic onboarding = CashHelper.getData(key: 'onboarding');
  dynamic token = CashHelper.getData(key: 'token');
  runApp( MyApp(onboarding: onboarding,token: token,));
>>>>>>> ibrahim
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
<<<<<<< HEAD
        BlocProvider(create: (context) => OnBoardingCubit()),
        // BlocProvider(create: (context) => AuthCubit()..getUserData()),
        // BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavorite()),
=======
        BlocProvider(create: (context)=>OnBoardingCubit()),
        BlocProvider(create: (context)=>CartCubit()),
        // BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavorite()),
>>>>>>> ibrahim
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
<<<<<<< HEAD
        home: SplashScreen(), // Set SplashScreen as the initial screen
=======
        home: TestScreen(),
>>>>>>> ibrahim
      ),
    );
  }
}