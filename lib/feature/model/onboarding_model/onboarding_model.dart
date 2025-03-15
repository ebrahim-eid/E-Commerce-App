
import '../../../core/images/images_path.dart';

class OnBoardingModel {
  final String image;
  final String onBoardingTitle;
  final String onBoardingSubTitle;

  OnBoardingModel(
      {required this.onBoardingTitle,
        required this.onBoardingSubTitle,
        required this.image});

  static List<OnBoardingModel> boarding = [
    OnBoardingModel(
      image: ImagesPath.onBoarding1,
      onBoardingTitle: 'Purchase Online',
      onBoardingSubTitle: "Welcome to a World of Limitless Choices Your Perfect Product Awaits!",
    ),
    OnBoardingModel(
      image: ImagesPath.onBoarding2,
      onBoardingTitle: 'Track order',
      onBoardingSubTitle: "Manage your tasks efficiently with our tools!",
    ),
    OnBoardingModel(
      image: ImagesPath.onBoarding3,
      onBoardingTitle: 'Get your order',
      onBoardingSubTitle: "Sign up and start your journey today."
    ),
  ];
}
