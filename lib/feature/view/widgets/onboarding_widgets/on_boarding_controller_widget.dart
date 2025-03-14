import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/helpers/cashe_helper/shared_prefernce.dart';
import '../../../../core/helpers/helper_functions/helper_functions.dart';
import '../../../controller/onboarding_cubit/on_boarding_cubit.dart';
import '../../../model/onboarding_model/onboarding_model.dart';
import '../../screens/auth_screens/login_screen.dart';
import '../../screens/onboarding_screen/on_boarding_screen.dart';

Widget smoothIndicatorWidget(context) => Column(
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60, 
          alignment: Alignment.center,
          child: !OnBoardingCubit.get(context).isFirst
              ? ElevatedButton(
                  onPressed: () {
                    OnBoardingCubit.get(context).boardController.previousPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    iconColor: const Color(0xff004182),
                    side: BorderSide(color: const Color(0xff004182), width: 1.5),
                    backgroundColor: Colors.white70,
                    padding: const EdgeInsets.all(16),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.arrow_back_ios_outlined, size: 24),
                )
              : null,
        ),
        const Spacer(), 
        SmoothPageIndicator(
          controller: OnBoardingCubit.get(context).boardController,
          effect: const ExpandingDotsEffect(
            activeDotColor: Colors.blue,
            dotHeight: 12,
            dotWidth: 12,
            spacing: 5,
            expansionFactor: 3 ,
          ),
          count: OnBoardingModel.boarding.length,
        ),
        const Spacer(), 
        ElevatedButton(
          onPressed: () {
            if (OnBoardingCubit.get(context).isLast == true) {
              CashHelper.setData(key: 'onboarding', value: true).then((value) {
                if (value) {
                  HelperFunctions.navigateAndRemove(context, LoginScreen());
                }
              });
            } else {
              OnBoardingCubit.get(context).boardController.nextPage(
                duration: const Duration(milliseconds: 800),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            iconColor: Colors.white,
            shape: const CircleBorder(),
            backgroundColor: const Color(0xff004182),
            padding: const EdgeInsets.all(16),
          ),
          child: const Icon(Icons.arrow_forward_ios_outlined, size: 24),
        ),
      ],
    ),
    const Spacer(),
  ],
);
