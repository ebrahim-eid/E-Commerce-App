import 'package:ecommerce_app/feature/controller/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/feature/view/screens/splash_screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/helpers/cashe_helper/shared_prefernce.dart';
import 'core/helpers/dio_helper/dio_helper.dart';
import 'feature/controller/auth_cubit/auth_cubit.dart';
import 'feature/controller/bloc_observer.dart';
import 'feature/controller/onboarding_cubit/on_boarding_cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper().init();
  runApp(const MyApp());
    
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>OnBoardingCubit()),
        BlocProvider(create: (context)=>CartCubit()),
        BlocProvider(create:  (context) => AuthCubit()),
        // BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavorite()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(), // Set SplashScreen as the initial screen
      ),
    );
  }
}