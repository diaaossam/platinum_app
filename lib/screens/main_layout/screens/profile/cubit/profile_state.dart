part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ChangeUserImage extends ProfileState {}
class GetUserInfoLoading extends ProfileState {}
class GetUserInfoSuccess extends ProfileState {}
class GetUserInfoFailure extends ProfileState {}
