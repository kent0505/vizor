part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeFavorite extends HomeState {}

final class HomeSettings extends HomeState {}
