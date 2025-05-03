abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {
  final Map<String, dynamic> userData;
  ProfileSuccessState({required this.userData});
}

class ProfileErrorState extends ProfileStates {
  final String error;
  ProfileErrorState({required this.error});
}

class UpdateProfileLoadingState extends ProfileStates {}

class UpdateProfileSuccessState extends ProfileStates {
  final Map<String, dynamic> userData;
  UpdateProfileSuccessState({required this.userData});
}

class UpdateProfileErrorState extends ProfileStates {
  final String error;
  UpdateProfileErrorState({required this.error});
} 