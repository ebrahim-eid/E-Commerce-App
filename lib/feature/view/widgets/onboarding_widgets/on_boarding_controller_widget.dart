import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/helpers/cashe_helper/shared_prefernce.dart';
import '../../../../core/helpers/helper_functions/helper_functions.dart';
import '../../../controller/onboarding_cubit/on_boarding_cubit.dart';
import '../../../model/onboarding_model/onboarding_model.dart';
import '../../screens/auth_screens/login_screen.dart';
import '../../screens/onboarding_screen/on_boarding_screen.dart';

Widget smoothIndicatorWidget(context) => Row(
      children: [
        SmoothPageIndicator(
            controller: OnBoardingCubit.get(context).boardController,
            effect: const ExpandingDotsEffect(
                // dotColor: Colors.black,
                activeDotColor: Colors.red,
                dotHeight: 6,
                dotWidth: 10,
                spacing: 5,
                expansionFactor: 5),
            count: OnBoardingModel.boarding.length),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            if (OnBoardingCubit.get(context).isLast == true) {
              CashHelper.setData(key: 'onboarding', value: true).then((value){
                if(value){
                  HelperFunctions.navigateAndRemove(context,  LoginScreen());
                }
              });
            } else {
              OnBoardingCubit.get(context).boardController.nextPage(
                  duration: const Duration(
                    milliseconds: 800,
                  ),
                  curve: Curves.fastLinearToSlowEaseIn);
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.black,
          ),
          child: const Icon(Icons.arrow_forward_ios_outlined),
        ),
      ],
    );
