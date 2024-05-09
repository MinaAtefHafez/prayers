part of 'home_cubit.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class BottomNavBar extends HomeState {}

//! calendar

final class GetCalendarMonthLoading extends HomeState {}

final class GetCalendarMonthSuccess extends HomeState {}

final class GetCalendarMonthFailure extends HomeState {
  final String errMessage;

  GetCalendarMonthFailure(this.errMessage);
}


final class GetCalendarMonthLocalSuccess extends HomeState {}

final class GetPrayerToday extends HomeState {}

final class GetPreviousPrayer extends HomeState {}
