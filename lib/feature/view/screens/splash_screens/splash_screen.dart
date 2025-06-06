import 'package:ecommerce_app/core/helpers/helper_functions/helper_functions.dart';
import 'package:ecommerce_app/feature/view/screens/onboarding_screen/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';
import 'package:ecommerce_app/feature/view/screens/auth_screens/login_screen.dart';
import 'package:ecommerce_app/feature/view/screens/home_screens/home_screen.dart';
import 'package:ecommerce_app/feature/controller/home_cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/feature/controller/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/feature/controller/auth_cubit/auth_states.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _offsetAnimation = Tween<Offset>(
      begin: Offset(-0.2, 0),
      end: Offset(0.2, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _navigateToNextScreen();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _navigateToNextScreen() async {
    await Future.delayed(Duration(milliseconds: 2100), () {});
    dynamic onboarding = CashHelper.getData(key: 'onboarding');
    String? token = CashHelper.getToken();
    
    if (onboarding == null) {
      HelperFunctions.navigateAndRemove(context, OnBoardingScreen());
    } else if (token == null) {
      HelperFunctions.navigateAndRemove(context, LoginScreen());
    } else {
      // Verify token before navigating to home screen
      await context.read<AuthCubit>().verifyToken();
      if (mounted) {
        context.read<HomeCubit>().changeSelectedIndex(0);
        HelperFunctions.navigateAndRemove(context, HomeScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _offsetAnimation,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _controller.value * -3.14 / 6.0,
                          child: child,
                        );
                      },
                      child: Icon(
                        Icons.shopping_cart,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'E-Commerce',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}