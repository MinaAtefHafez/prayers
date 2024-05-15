part of 'prayers_cubit.dart';

abstract class PrayersState {}

final class PrayersInitial extends PrayersState {}

final class BottomNavBar extends PrayersState {}

//! calendar

final class GetCalendarMonthLoading extends PrayersState {}

final class GetCalendarMonthSuccess extends PrayersState {}

final class GetCalendarMonthFailure extends PrayersState {
  final String errMessage;

  GetCalendarMonthFailure(this.errMessage);
}


final class GetCalendarMonthLocalSuccess extends PrayersState {}

final class GetPrayerToday extends PrayersState {}

final class GetPrayer extends PrayersState {}
