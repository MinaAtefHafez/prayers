import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:prayers/core/helpers/api_helper/api_consumer.dart';
import 'package:prayers/core/helpers/api_helper/dio_consumer.dart';
import 'package:prayers/features/home/data/repository/home_repo.dart';
import 'package:prayers/features/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:prayers/features/settings_details/data/repository/settings_repo.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';

final di = GetIt.instance;

Future<void> setUpLocator() async {
  di.registerLazySingleton(() => Dio());
  di.registerLazySingleton<ApiConsumer>(() => DioConsumer(di()));

  di.registerLazySingleton<SettingsRepo>(() => SettingsRepoImpl(di()));
  di.registerLazySingleton(() => SettingsCubit(di()));

  //! Home
  di.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(di()));
  di.registerLazySingleton(() => HomeCubit(di(), di()));
}
