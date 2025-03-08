import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/cashe_helper/shared_prefernce.dart';
import '../../../../core/helpers/helper_functions/helper_functions.dart';
import '../../../controller/onboarding_cubit/on_boarding_cubit.dart';
import '../../../controller/onboarding_cubit/on_boarding_states.dart';
import '../../../model/onboarding_model/onboarding_model.dart';
import '../../widgets/onboarding_widgets/on_boarding_controller_widget.dart';
import '../../widgets/onboarding_widgets/pageview_widget.dart';
import '../auth_screens/login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = OnBoardingCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(onPressed: () {
                CashHelper.setData(key: 'onboarding', value: true).then((value){
                  if(value){
                    HelperFunctions.navigateAndRemove(context,  LoginScreen());
                  }
                });
              },
                child:  Text('Skip',style: Theme.of(context).textTheme.titleSmall,),),
              const SizedBox(width: 16,)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: cubit.boardController,
                      itemBuilder: (context, index) =>
                          onBoardingItems(context, index),
                      itemCount: OnBoardingModel.boarding.length,
                      onPageChanged: (int change) {
                        cubit.onChanged(change);
                      },
                    ),
                  ),
                  smoothIndicatorWidget(context),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}




