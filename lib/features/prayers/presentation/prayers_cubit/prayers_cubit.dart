import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers/features/prayers/data/models/calendar_month_model.dart';
import 'package:prayers/features/prayers/data/models/calendar_month_model_param.dart';
import 'package:prayers/features/prayers/data/models/prayer_model.dart';
import 'package:prayers/features/prayers/data/repository/home_repo.dart';
import 'package:prayers/features/settings_details/data/repository/settings_repo.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';
import '../../../../core/enum/enum.dart';
import '../../../../core/helpers/intl_helper/intl_helper.dart';
part 'prayers_state.dart';

class PrayersCubit extends Cubit<PrayersState> {
  PrayersCubit(
    this._homeRepo,
    this._settingsCubit,
    this._settingsRepo,
  ) : super(PrayersInitial());

  final HomeRepo _homeRepo;
  final SettingsCubit _settingsCubit;
  final SettingsRepo _settingsRepo;
  CalendarMonthModel? calendarMonthModel;
  Datum? prayerToday;
  List<PrayerModel> prayerTodayAfterFilterAccordingSettings = List.empty();
  PrayerModel? previousPrayer;
  PrayerModel? nextPrayer;
  String? yearNowLocal;

  //! Calendar

  Datum? get getPrayerToday => prayerToday;

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
      await saveYearNowLocal();
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

  Future<void> getPrayers([String? searchDay]) async {
    final String day = searchDay ?? IntlHelper.dayNow;
    final String dayRefactor = day.length == 1 ? '0$day' : day;
    for (var e in calendarMonthModel!.data) {
      if (e.date!.gregorian!.day == dayRefactor) {
        prayerToday = e;
        break;
      }
    }
    emit(GetPrayerToday());
  }

  Future<List<PrayerModel>> filterPrayersAccordingSettings(
      {required Datum prayer}) async {
    final Map<dynamic, dynamic>? settings = _settingsRepo.settingsMap;
    List<PrayerModel> filterList =
        List.from(prayer.timings!.prayers.map((e) => e));
    if (_settingsRepo.settingsMap == null) return filterList;
    filterList.removeWhere((element) => !settings![element.prayerName].isShow);
    return filterList;
  }

  Future<void> filterPrayersToday() async {
    prayerTodayAfterFilterAccordingSettings =
        await filterPrayersAccordingSettings(
      prayer: prayerToday!,
    );
    emit(FilterPrayersAccordingSettings());
  }

  Future<PrayerModel?> getPreviousPrayer(List<PrayerModel> prayers) async {
    final dateTimeNow = IntlHelper.dateTime();
    PrayerModel? prayer;
    for (int index = 0; index < prayers.length; index++) {
      if (index == prayers.length - 1) {
        final prayerNowAsString = prayers[index].prayerDate!.split(' ').first;
        final prayerNow = IntlHelper.dateTime(prayerNowAsString);
        final difference = dateTimeNow.difference(prayerNow).inMinutes;
        if (difference > 0 && difference <= 30) {
          prayer = prayers[index];
          break;
        }
      }

      if (index < prayers.length - 1) {
        final prayerNowAsString = prayers[index].prayerDate!.split(' ').first;

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
    }
    return prayer;
  }

  Future<PrayerModel?> getNextPrayer(List<PrayerModel> prayers) async {
    final dateTimeNow = IntlHelper.dateTime();
    PrayerModel? prayer;
    for (int index = 0; index < prayers.length; index++) {
      final prayerNextAsString = prayers[index].prayerDate!.split(' ').first;
      final prayerNext = IntlHelper.dateTime(prayerNextAsString);
      if (prayerNext.isAfter(dateTimeNow)) {
        prayer = prayers[index];
        break;
      }
    }
    return prayer;
  }

  String get differenceBetweenTimeNowAndPreviousPrayer {
    final timeNow = IntlHelper.dateTime();
    final timePreviousPrayerAsString =
        previousPrayer?.prayerDate?.split(' ').first;
    final previousTime = IntlHelper.dateTime(timePreviousPrayerAsString);
    final differene = timeNow.difference(previousTime);
    return differene.inMinutes.toString();
  }

  String get differenceBetweenNextPrayerAndTimeNow {
    final timeNow = IntlHelper.dateTime();
    final timeNextPrayerAsString = nextPrayer?.prayerDate?.split(' ').first;
    final nextTime = IntlHelper.dateTime(timeNextPrayerAsString);
    final differene = nextTime.difference(timeNow);
    return differene.inMinutes.toString();
  }

  Future<void> getPreviousPrayerForToday() async {
    previousPrayer =
        await getPreviousPrayer(prayerTodayAfterFilterAccordingSettings);
    previousPrayer = previousPrayer?.copyWith(
        differnece: differenceBetweenTimeNowAndPreviousPrayer);
    emit(GetPrayer());
  }

  Future<void> getNextPrayerForToday() async {
    nextPrayer = await getNextPrayer(prayerTodayAfterFilterAccordingSettings);
    nextPrayer =
        nextPrayer?.copyWith(differnece: differenceBetweenNextPrayerAndTimeNow);
    emit(GetPrayer());
  }

  PrayerState getPrayerState(PrayerModel prayer) {
    if (previousPrayer?.prayerName == prayer.prayerName) {
      return PrayerState.previous;
    } else if (nextPrayer?.prayerName == prayer.prayerName) {
      return PrayerState.next;
    } else {
      return PrayerState.normal;
    }
  }

  bool get isPraviousPrayerNow {
    if (previousPrayer == null) return false;
    final dateTimeNow = IntlHelper.dateTime();
    final previousPrayerDateAsString =
        previousPrayer?.prayerDate?.split(' ').first;
    final prayerDateTime = IntlHelper.dateTime(previousPrayerDateAsString);
    final difference = dateTimeNow.difference(prayerDateTime).inMinutes;
    if (difference > 0 && difference <= 60) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> saveYearNowLocal() async {
    await _homeRepo.saveYearNowLocal();
  }

  Future<void> getYearNowLocal() async {
    final result = await _homeRepo.getYearNowLocal();
    yearNowLocal = result;
  }

  Future<void> callCalendarApiOrLocal() async {
    final yearNow = IntlHelper.yearNow;
    if (yearNow == yearNowLocal) {
      await getCalendarMonthYearLocal();
    } else {
      await getCalendarMonth();
    }
  }
}
