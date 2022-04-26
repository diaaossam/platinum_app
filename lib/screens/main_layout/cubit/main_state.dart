part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}
class ChangeBottomNavItemState extends MainState {}
class UploadCarInfoLoading extends MainState {}
class UploadCarInfoSuccess extends MainState {}
class OnGetSearchLoadingState extends MainState {}
class ChooseCategoryState extends MainState {}
class ChooseFuelState extends MainState {}
class ChooseItemConState extends MainState {}
class UploadProductImageSuccessState extends MainState {}
class UploadProductVedioSuccessState extends MainState {
  File ?file;

  UploadProductVedioSuccessState(this.file);
}
class InitVedioState extends MainState {}
class UploadProductFailerState extends MainState {
  String error;

  UploadProductFailerState(this.error);
}

class GetFavourtieCarsSuccess extends MainState {}
class GetFavourtieCarsLoading extends MainState {}
class RemoveCarFavourtie extends MainState {}

class GetMyAdsCarsSuccess extends MainState {}
class GetMyAdsCarsLoading extends MainState {}
class RemoveCarMyAds extends MainState {}
class ChangeCheckBoxState extends MainState {}


class GetUserInfoSuccessProfileState extends MainState {}
class GetUserInfoFailureProfileState extends MainState {}
class ChangeUserProfileImage extends MainState {}
class SignOutSuccess extends MainState {}
class UpdateUserInfoSuccess extends MainState {}
class LoadingUser extends MainState {}
