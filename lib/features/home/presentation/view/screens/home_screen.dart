import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:prayers/features/prayers/presentation/prayers_cubit/prayers_cubit.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';
import '../../../../../core/dependency_injection/dependency_injection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const name = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final settingsCubit = di<SettingsCubit>();
  final prayersCubit = di<PrayersCubit>();
  final homeCubit = di<HomeCubit>();
  late Timer timer30;
  late Timer timer2;
  @override
  void initState() {
    super.initState();
    call();
  }

  void call() async {
    await Future.wait([
      settingsCubit.getMothodLocal(),
      settingsCubit.getLocationLocal(),
      prayersCubit.getYearNowLocal()
    ]);
    await prayersCubit.callCalendarApiOrLocal();
    await settingsCubit.getPrayersSettingsLocal();
    await prayersCubit.getPrayers();
    await prayersCubit.filterPrayersToday();
    await prayersCubit.getPreviousPrayerForToday();
    await prayersCubit.getNextPrayerForToday();

    timer30 = Timer.periodic(const Duration(seconds: 30), (timer) async {
      await prayersCubit.getPrayers();
      await prayersCubit.filterPrayersToday();
    });

    timer2 = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await prayersCubit.getPreviousPrayerForToday();
      await prayersCubit.getNextPrayerForToday();
    });
  }

  @override
  void dispose() {
    timer30.cancel();
    timer2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        builder: (context, state) => Scaffold(
              body: homeCubit.screens[homeCubit.bottomNavIndex],
              bottomNavigationBar: BottomNavigationBar(
                  iconSize: 20.w,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey.shade500,
                  showUnselectedLabels: true,
                  selectedIconTheme: IconThemeData(
                      color: Colors.black, applyTextScaling: true, size: 22.w),
                  unselectedIconTheme: IconThemeData(
                      color: Colors.grey.shade400,
                      size: 22.w,
                      applyTextScaling: true),
                  selectedLabelStyle: AppStyles.style16.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.black),
                  currentIndex: homeCubit.bottomNavIndex,
                  onTap: homeCubit.changeBottomNavIndex,
                  items: [
                    BottomNavigationBarItem(
                        icon: const Icon(Icons.alarm), label: tr('Prayers')),
                    BottomNavigationBarItem(
                        icon: const Icon(Icons.mosque), label: tr('Dome')),
                  ]),
            ));
  }
}
