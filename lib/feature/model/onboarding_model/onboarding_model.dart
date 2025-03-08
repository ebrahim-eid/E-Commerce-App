
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
      onBoardingTitle: 'Choose your product',
      onBoardingSubTitle: "Welcome to a World of Limitless Choices Your Perfect Product Awaits!",
    ),
    OnBoardingModel(
      image: ImagesPath.onBoarding2,
      onBoardingTitle: 'Select Payment Method',
      onBoardingSubTitle: "For Seamless Transactions, Choose Your Payment Path Your Convenience, Our Priority!",
    ),
    OnBoardingModel(
      image: ImagesPath.onBoarding3,
      onBoardingTitle: 'Deliver at your door step',
      onBoardingSubTitle: "From Our Doorstep to Yours Swift, Secure, and Contactless Delivery!"
    ),
  ];
}
