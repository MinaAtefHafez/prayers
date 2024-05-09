import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers/features/home/data/models/calendar_month_model.dart';
import 'package:prayers/features/home/data/models/calendar_month_model_param.dart';
import 'package:prayers/features/home/data/models/prayer_model.dart';
import 'package:prayers/features/home/data/repository/home_repo.dart';
import 'package:prayers/features/home/presentation/view/screens/dome_screen.dart';
import 'package:prayers/features/home/presentation/view/screens/hijri_screen.dart';
import 'package:prayers/features/home/presentation/view/screens/prayers_screen.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';

import '../../../../../core/helpers/intl_helper/intl_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo, this._settingsCubit) : super(HomeInitial());

  final HomeRepo _homeRepo;
  final SettingsCubit _settingsCubit;
  CalendarMonthModel? calendarMonthModel;
  Datum? prayerToday;
  PrayerModel? previousPrayer;
  PrayerModel? nextPrayer;

  int bottomNavIndex = 0;

  final List<Widget> screens = const [
    PrayerScreen(),
    DomeScreen(),
    HijriScreen(),
  ];

  void changeBottomNavIndex(int index) {
    bottomNavIndex = index;
    emit(BottomNavBar());
  }

  //! Calendar

  Future<void> getCalendarMonth() async {
    emit(GetCalendarMonthLoading());
    final calendarMonthParam = CalendarMonthModelParma(
        latitude: _settingsCubit.location!.latitude!,
        longitude: _settingsCubit.location!.longitude!,
        method: _settingsCubit.method!.id!);
    final result =
        await _homeRepo.getCalendarMonth(calendarMonthParam.toJson());
    result.fold((failure) {
      emit(GetCalendarMonthFailure(failure.message));
    }, (data) async {
      calendarMonthModel = data.$1;
      await saveCalendarMonthLocal(data.$2);
      emit(GetCalendarMonthSuccess());
    });
  }

  Future<void> saveCalendarMonthLocal(Map<String, dynamic> calendar) async {
    await _homeRepo.saveCalendarMonthLocal(calendar);
    await getCalendarMonthYearLocal();
  }

  Future<void> getCalendarMonthYearLocal() async {
    calendarMonthModel = await _homeRepo.getCalendarYearLocal();
    emit(GetCalendarMonthLocalSuccess());
  }

  Future<void> getPrayersToday() async {
    final String day = IntlHelper.dayNow;
    final String dayRefactor = day.length == 1 ? '0$day' : day;
    prayerToday = calendarMonthModel!.data.singleWhere(
        (element) => element.date!.gregorian!.day.toString() == dayRefactor);
    emit(GetPrayerToday());
  }

  Future<PrayerModel> getPreviousPrayer() async {
    final List<PrayerModel> prayers = prayerToday!.timings!.prayers;
    final dateTimeNow = IntlHelper.dateTime();
    PrayerModel prayer = PrayerModel();
    for (int index = 0; index < prayers.length; index++) {
      if (index == prayers.length - 1) {
        final prayerNowAsString = prayers[index].prayerDate!.split(' ').first;
        final prayerNow = IntlHelper.dateTime(prayerNowAsString);
        final difference = dateTimeNow.difference(prayerNow).inMinutes;
        if (difference > 0 && difference < 30) {
          prayer = prayers[index];
          break;
        }
      }

      final prayerNowAsString = prayers[index].prayerDate!.split(' ').first;
      log(prayerNowAsString);
      final prayerNow = IntlHelper.dateTime(prayerNowAsString);
      final paryerNextAsString =
          prayers[index + 1].prayerDate!.split(' ').first;
      final prayerNext = IntlHelper.dateTime(paryerNextAsString);
      final bool isPrayerNowBeforeDateTime = prayerNow.isBefore(dateTimeNow);
      final bool isPrayerNextAfterDateTime = prayerNext.isAfter(dateTimeNow);
      if (isPrayerNowBeforeDateTime && isPrayerNextAfterDateTime) {
        prayer = prayers[index];
        break;
      }
    }
    return prayer;
  }

  Future<void> getPreviousPrayerForToday() async {
    previousPrayer = await getPreviousPrayer();
    emit(GetPreviousPrayer());
  }
}
