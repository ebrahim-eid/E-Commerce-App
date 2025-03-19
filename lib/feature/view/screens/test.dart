import 'package:ecommerce_app/feature/controller/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/feature/controller/auth_cubit/auth_states.dart';
import 'package:ecommerce_app/feature/controller/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/cart_cubit/cart_states.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Column(
                children: [
                  // TextButton(
                  //   onPressed: () {
                  //     CartCubit.get(context).removeSpecificCartItem(
                  //       id: '6428ebc6dc1175abc65ca0b9',
                  //       token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3ZDlmMGYwYjNlNjliZDJmNGFhMDg1MSIsIm5hbWUiOiJNb2hhbWVkIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NDIzODc1NjQsImV4cCI6MTc1MDE2MzU2NH0.HdL1Eybb5WAb1PHF0zdIXdVUneOd_LI_1-Xfanf6IaA',
                  //     );
                  //   },
                  //   child: Text(
                  //     'Cart test',
                  //     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  //   ),
                  // ),
                  TextButton(
                    onPressed: () {
                      CartCubit.get(context).deleteUserCart("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3ZGFjMDVjYjNlNjliZDJmNGFjMzA4ZSIsIm5hbWUiOiJoZW1hIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NDIzODk2ODIsImV4cCI6MTc1MDE2NTY4Mn0.2UMbrKCU5ny60bqAhIj-Cjkacd6N8GYZgfDlPrXckk4");
                    },
                    child: Text(
                      'Login test',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     AuthCubit.get(context).forgotPassword('ibrahimeid.eng@gmail.com',);
                  //   },
                  //   child: Text(
                  //     'Forgot password test',
                  //     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  //   ),
                  // ),
                  // TextButton(
                  //   onPressed: () {
                  //     AuthCubit.get(context).verifyResetCode('697841',);
                  //   },
                  //   child: Text(
                  //     'verifyResetCode test',
                  //     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  //   ),
                  // ),
                  // TextButton(
                  //   onPressed: () {
                  //     AuthCubit.get(context).resetPassword(
                  //       email: "ibrahimeid.eng@gmail.com",
                  //       newPassword: "ibrahimei5"
                  //     );
                  //   },
                  //   child: Text(
                  //     'resetPassword test',
                  //     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  //   ),
                  // ),
                  // TextButton(
                  //   onPressed: () {
                  //     ProductCubit.get(context).getAllProducts();
                  //   },
                  //   child: Text(
                  //     'product All test',
                  //     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  //   ),
                  // ),
                  // TextButton(
                  //   onPressed: () {
                  //     ProductCubit.get(context).getProductById('6428ebc6dc1175abc65ca0b9');
                  //   },
                  //   child: Text(
                  //     'product test',
                  //     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
