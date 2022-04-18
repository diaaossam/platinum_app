part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}
class GetCarsLoading extends CategoryState {}
class GetCarsSuccess extends CategoryState {}
class AddCarToFavSuccess extends CategoryState {}
class RemoveCarFromFavSuccess extends CategoryState {}
