import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/helpers/cashe_helper/shared_prefernce.dart';
import 'core/helpers/dio_helper/dio_helper.dart';
import 'feature/controller/auth_cubit/auth_cubit.dart';
import 'feature/controller/bloc_observer.dart';
import 'feature/controller/onboarding_cubit/on_boarding_cubit.dart';
import 'feature/controller/product_cubit/product_cubit.dart';
import 'feature/view/screens/auth_screens/login_screen.dart';
import 'feature/view/screens/home_screens/home_screen.dart';
import 'feature/view/screens/onboarding_screen/on_boarding_screen.dart';
import 'feature/view/screens/test.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper().init();
  dynamic onboarding = CashHelper.getData(key: 'onboarding');
  dynamic token = CashHelper.getData(key: 'token');
  runApp( MyApp(onboarding: onboarding,token: token,));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key, this.onboarding, this.token});
  final dynamic onboarding;
  final dynamic token;

  @override
  Widget build(BuildContext context) {
    Widget homeWidget =onboarding ==null ? const OnBoardingScreen() : token==null? LoginScreen():HomeScreen();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>OnBoardingCubit()),
        BlocProvider(create: (context)=>ProductCubit()),
        // BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavorite()),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TestScreen(),
      ),
    );
  }
}