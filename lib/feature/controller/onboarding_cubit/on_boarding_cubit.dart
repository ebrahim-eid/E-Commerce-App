import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'on_boarding_states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingInitialState());

 static OnBoardingCubit get(context) => BlocProvider.of(context);
  var boardController = PageController();
  bool isLast = false;
  bool isFirst = true;

  void onChanged(int change) {
    isFirst = change == 0; 
    if (change == 2) {
      isLast = true;
      emit(OnBoardingTrueLastState());
    } else {
      isLast = false;
      emit(OnBoardingFalseLastState());
    }
  }

}
