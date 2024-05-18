import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers/core/helpers/intl_helper/intl_helper.dart';
import 'package:prayers/features/gregorian/data/models/gregorian_year_model.dart';
import 'package:prayers/features/gregorian/data/repository/gregorian_repo.dart';
import 'package:prayers/features/gregorian/presentation/gregorian_cubit/gregorian_state.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';

class GregorianCubit extends Cubit<GregorianState> {
  GregorianCubit(this._gregorianRepo, this._settingsCubit)
      : super(GregorianInitial());

  final GregorianRepo _gregorianRepo;
  final SettingsCubit _settingsCubit;

  GregorianModel? gregorianModel;
  List<GregorianYear> gregorianYear = List.empty();
  String? yearNowLocal;
  String? gregorianMonth;
  String gregorianMonthAsNumber = IntlHelper.monthNow;

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
    final gregorianMonthNow = IntlHelper.monthNow;
    gregorianYear = gregorianModel!.data[gregorianMonthNow]!;
    gregorianMonth = gregorianYear[0].date!.gregorian!.month!.en!;
    emit(ChangeMonth());
  }

  void changeToNextgregorianMonth() {
    int gregorianMonthAsInt = int.parse(gregorianMonthAsNumber);
    if (gregorianMonthAsInt == 12) return;
    gregorianMonthAsInt++;
    gregorianMonthAsNumber = gregorianMonthAsInt.toString();
    gregorianYear = gregorianModel!.data[gregorianMonthAsNumber]!;
    gregorianMonth = gregorianYear[0].date!.gregorian!.month!.en!;
    emit(ChangeMonth());
  }

  void changeToPreviousgregorianMonth() {
    int gregorianMonthAsInt = int.parse(gregorianMonthAsNumber);
    if (gregorianMonthAsInt == 1) return;
    gregorianMonthAsInt--;
    gregorianMonthAsNumber = gregorianMonthAsInt.toString();
    gregorianYear = gregorianModel!.data[gregorianMonthAsNumber]!;
    gregorianMonth = gregorianYear[0].date!.gregorian!.month!.en!;
    emit(ChangeMonth());
  }
}
