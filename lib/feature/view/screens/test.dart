import 'package:ecommerce_app/feature/controller/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/feature/controller/auth_cubit/auth_states.dart';
import 'package:ecommerce_app/feature/controller/product_cubit/product_cubit.dart';
import 'package:ecommerce_app/feature/controller/product_cubit/product_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
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
                  //     AuthCubit.get(context).signUp(
                  //       name: 'Mohamed',
                  //       email: 'deoemaikl.demo1@gmail.com',
                  //       password: 'DeO125##',
                  //       rePassword: 'DeO125##',
                  //       phone: '01098049337',
                  //     );
                  //   },
                  //   child: Text(
                  //     'Register test',
                  //     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  //   ),
                  // ),
                  // TextButton(
                  //   onPressed: () {
                  //     AuthCubit.get(context).loginUser(
                  //       email: 'deoemaikl.demo1@gmail.com',
                  //       password: 'DeO125##',
                  //     );
                  //   },
                  //   child: Text(
                  //     'Login test',
                  //     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  //   ),
                  // ),
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
                  TextButton(
                    onPressed: () {
                      ProductCubit.get(context).getAllProducts();
                    },
                    child: Text(
                      'product All test',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ProductCubit.get(context).getProductById('6428ebc6dc1175abc65ca0b9');
                    },
                    child: Text(
                      'product test',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                    ),
                  ),
                ],
              )
            ),
          ),
        );
      },
    );
  }
}
