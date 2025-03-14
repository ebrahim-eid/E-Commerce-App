import 'package:flutter/material.dart';
import '../../../model/onboarding_model/onboarding_model.dart';


Widget onBoardingItems(context,index)=>SingleChildScrollView(
  child: Column(
    children: [
      Image(
        image: AssetImage(OnBoardingModel.boarding[index].image),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.55,
      ),
       Text(
          OnBoardingModel.boarding[index].onBoardingTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16,),
        Opacity(
          opacity: 0.6, 
          child: Text(
            OnBoardingModel.boarding[index].onBoardingSubTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      
    ],
  ),
);