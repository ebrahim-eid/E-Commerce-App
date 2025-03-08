import 'package:flutter/material.dart';

class HelperFunctions{
  /// navigation
  static void navigateTo(BuildContext context, Widget screen) =>
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );


  /// navigation replace
  static void navigateAndRemove(context,Widget widget)=>
      Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context)=>widget));
  /// get screen width
  static dynamic getScreenWidth(context) =>MediaQuery.of(context).size.width;

  /// get screen height
  static dynamic getScreenHeight(context) =>MediaQuery.of(context).size.height;
}

