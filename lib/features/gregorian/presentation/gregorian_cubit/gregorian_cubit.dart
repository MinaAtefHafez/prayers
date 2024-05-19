import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers/core/helpers/hijri_helper/hijri_helper.dart';
import 'package:prayers/core/helpers/intl_helper/intl_helper.dart';
import 'package:prayers/core/helpers/localization_helper/localization/localization_utils.dart';
import 'package:prayers/features/gregorian/data/models/gregorian_year_model.dart';
import 'package:prayers/features/gregorian/data/models/year_month_model.dart';
import 'package:prayers/features/gregorian/data/repository/gregorian_repo.dart';
import 'package:prayers/features/gregorian/presentation/gregorian_cubit/gregorian_state.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';

class GregorianCubit extends Cubit<GregorianState> {
  GregorianCubit(this._gregorianRepo, this._settingsCubit)
      : super(GregorianInitial());

  final GregorianRepo _gregorianRepo;
  final SettingsCubit _settingsCubit;

  GregorianModel? gregorianModel;
  GregorianModel? hijriModel;
  List<GregorianYear> gregorianYearList = List.empty();
  List<GregorianYear> hijriYearList = List.empty();
  String? yearNowLocal;
  String? hijriYearLocal;
  YearMonthModel gregorian =
      YearMonthModel(isShow: true, year: IntlHelper.yearNow);
  YearMonthModel hijri =
      YearMonthModel(isShow: false, year: HijriHelper.hijriYearNow);

  String gregorianMonth = IntlHelper.monthNow;
  String hijriMonth = IntlHelper.monthNow;

  Future<void> getGregorianForYear() async {
    final param = {
      "latitude": _settingsCubit.location!.latitude,
      "longitude": _settingsCubit.location!.longitude,
      "method": _settingsCubit.method!.id
    };
    final result = await _gregorianRepo.getGregorianYear(param);
    result.fold((failure) {
      emit(GetGregorianYearFailure(failure.message));
    }, (r) async {
      gregorianModel = r.$1;
      await saveGregorianForYear(r.$2);
      await saveYearNowLocal();
      await getGregorianForYearLocal();
      emit(GetGregorianYearSuccess());
    });
  }

  Future<void> saveGregorianForYear(Map<String, dynamic> data) async {
    await _gregorianRepo.saveGregorianYearLocal(data);
  }

  Future<void> getGregorianForYearLocal() async {
    final result = await _gregorianRepo.getGregorianForYearLocal();
    gregorianModel = result;
    emit(GetGregorianYearLocalSuccess());
  }

  Future<void> saveYearNowLocal() async {
    await _gregorianRepo.saveYearNowLocal();
  }

  Future<void> getYearNowLocal() async {
    final result = await _gregorianRepo.getYearNowLocal();
    yearNowLocal = result;
  }

  Future<void> getGregorianForYearApiOrLocal() async {
    final yearNow = IntlHelper.yearNow;
    if (yearNowLocal == yearNow) {
      await getGregorianForYearLocal();
    } else {
      await getGregorianForYear();
    }
  }

  Future<void> getgregorianMonthNowFromGregorianModel() async {
    gregorianYearList = gregorianModel!.data[gregorianMonth]!;
    gregorian =
        gregorian.copyWith(year: gregorianYearList[0].date!.gregorian!.year);
    gregorian = gregorian.copyWith(
        month: gregorianYearList[0].date!.gregorian!.month!.en!);
    emit(ChangeMonth());
  }

  void changeToNextgregorianMonth() {
    int gregorianMonthAsInt = int.parse(gregorianMonth);
    if (gregorianMonthAsInt == 12) return;
    gregorianMonthAsInt++;
    gregorianMonth = gregorianMonthAsInt.toString();
    gregorianYearList = gregorianModel!.data[gregorianMonth]!;
    gregorian = gregorian.copyWith(
        month: gregorianYearList[0].date!.gregorian!.month!.en!);
    emit(ChangeMonth());
  }

  void changeToPreviousgregorianMonth() {
    int gregorianMonthAsInt = int.parse(gregorianMonth);
    if (gregorianMonthAsInt == 1) return;
    gregorianMonthAsInt--;
    gregorianMonth = gregorianMonthAsInt.toString();
    gregorianYearList = gregorianModel!.data[gregorianMonth]!;
    gregorian = gregorian.copyWith(
        month: gregorianYearList[0].date!.gregorian!.month!.en!);
    emit(ChangeMonth());
  }

  //! Hijri

  Future<void> getHijriCalendarForYear() async {
    final param = {
      "latitude": _settingsCubit.location!.latitude,
      "longitude": _settingsCubit.location!.longitude,
      "method": _settingsCubit.method!.id
    };
    final result = await _gregorianRepo.getHijriCalendarYear(param);
    result.fold((failure) {
      emit(GetGregorianYearFailure(failure.message));
    }, (r) async {
      hijriModel = r.$1;
      await saveHijriCalendarForYear(r.$2);
      await saveHijriYearNow();
      await getHijriCalendarLocal();
      emit(GetHijriCalendar());
    });
  }

  Future<void> saveHijriCalendarForYear(Map<String, dynamic> data) async {
    await _gregorianRepo.saveHijriCalendarYearLocal(data);
  }

  Future<void> getHijriCalendarLocal() async {
    final result = await _gregorianRepo.getHijriCalendarYearLocal();
    hijriModel = result;
    emit(GetHijriCalendar());
  }

  Future<void> saveHijriYearNow() async {
    await _gregorianRepo.saveHijriYearNowLocal();
  }

  Future<void> getHijriForYearLocal() async {
    final result = await _gregorianRepo.getHijriYearNowLocal();
    hijriYearLocal = result;
    emit(GetGregorianYearLocalSuccess());
  }

  Future<void> callHijriCalendarApiOrLocal() async {
    final hijriYearNow = HijriHelper.hijriYearNow;
    if (hijriYearLocal == hijriYearNow) {
      await getHijriCalendarLocal();
    } else {
      await getHijriCalendarForYear();
    }
  }

  Future<void> getHijriMonthNowFromGregorianModel() async {
    hijriYearList = hijriModel!.data[hijriMonth]!;
    hijri = hijri.copyWith(
        month: LocalizationUtils.isArabic
            ? gregorianYearList[0].date!.hijri!.month!.ar
            : gregorianYearList[0].date!.hijri!.month!.en);
    emit(ChangeMonth());
  }

  void changeToPreviousHijriMonth() {
    int gregorianMonthAsInt = int.parse(hijriMonth);
    if (gregorianMonthAsInt == 1) return;
    gregorianMonthAsInt--;
    hijriMonth = gregorianMonthAsInt.toString();
    hijriYearList = hijriModel!.data[hijriMonth]!;
    hijri = hijri.copyWith(
        month: LocalizationUtils.isArabic
            ? hijriYearList[0].date!.hijri!.month!.ar
            : hijriYearList[0].date!.hijri!.month!.en);
    emit(ChangeMonth());
  }

  void changeToNextHijriMonth() {
    int gregorianMonthAsInt = int.parse(hijriMonth);
    if (gregorianMonthAsInt == 12) return;
    gregorianMonthAsInt++;
    hijriMonth = gregorianMonthAsInt.toString();
    hijriYearList = hijriModel!.data[hijriMonth]!;
    hijri = hijri.copyWith(year: gregorianYearList[0].date!.hijri!.year);
    hijri = hijri.copyWith(
        month: LocalizationUtils.isArabic
            ? hijriYearList[0].date!.hijri!.month!.ar
            : hijriYearList[0].date!.hijri!.month!.en);
    emit(ChangeMonth());
  }

  bool get isShowGregorian => gregorian.isShow!;

  bool get isShowHijri => hijri.isShow!;

  String? get showMonth => isShowGregorian ? gregorian.month : hijri.month;

  String? get showYear => isShowGregorian ? gregorian.year : hijri.year;

  List<GregorianYear> get showPrayersList =>
      isShowGregorian ? gregorianYearList : hijriYearList;

  void chooseGregorianPicker() {
    gregorian = gregorian.copyWith(isShow: true);
    hijri = hijri.copyWith(isShow: false);
    emit(ChangeMonth());
  }

  void chooseHijriPicker() {
    gregorian = gregorian.copyWith(isShow: false);
    hijri = hijri.copyWith(isShow: true);
    emit(ChangeMonth());
  }

  void changeToPreviousGregorianOrHijriMonth() {
    if (isShowGregorian) {
      changeToPreviousgregorianMonth();
    } else {
      changeToPreviousHijriMonth();
    }
  }

  void changeToNextGregorianOrHijriMonth() {
    if (isShowGregorian) {
      changeToNextgregorianMonth();
    } else {
      changeToNextHijriMonth();
    }
  }
}
