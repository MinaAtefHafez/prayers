import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:prayers/core/helpers/api_helper/api_consumer.dart';
import 'package:prayers/core/helpers/api_helper/dio_consumer.dart';
import 'package:prayers/features/prayers/data/repository/home_repo.dart';
import 'package:prayers/features/prayers/presentation/cubits/home_cubit/prayers_cubit.dart';
import 'package:prayers/features/settings_details/data/repository/settings_repo.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';

final di = GetIt.instance;

Future<void> setUpLocator() async {
  di.registerLazySingleton(() => Dio());
  di.registerLazySingleton<ApiConsumer>(() => DioConsumer(di()));

  di.registerLazySingleton<SettingsRepo>(() => SettingsRepoImpl(di()));
  di.registerLazySingleton(() => SettingsCubit(di()));

  //! prayers
  di.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(di()));
  di.registerLazySingleton(() => PrayersCubit(di(), di()));
}
