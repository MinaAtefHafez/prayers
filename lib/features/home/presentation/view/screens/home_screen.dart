import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/features/home/presentation/cubits/home_cubit/home_cubit.dart';
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
  final homeCubit = di<HomeCubit>();
  late Timer timer;
  @override
  void initState() {
    super.initState();
    call();
  }

  void call() async {
    await settingsCubit.getMothodLocal();
    await settingsCubit.getLocationLocal();
    await homeCubit.getCalendarMonth();
    timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      await homeCubit.getPrayersToday();
      await homeCubit.getPreviousPrayerForToday();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        builder: (context, state) => Scaffold(
              body: homeCubit.screens[homeCubit.bottomNavIndex],
              bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey.shade500,
                  showUnselectedLabels: true,
                  selectedIconTheme: const IconThemeData(
                      color: Colors.black, applyTextScaling: true, size: 27),
                  selectedLabelStyle: AppStyles.style16.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.black),
                  currentIndex: homeCubit.bottomNavIndex,
                  onTap: homeCubit.changeBottomNavIndex,
                  items: [
                    BottomNavigationBarItem(
                        icon: const Icon(Icons.alarm), label: tr('Prayers')),
                    BottomNavigationBarItem(
                        icon: const Icon(Icons.mosque), label: tr('Dome')),
                    BottomNavigationBarItem(
                        icon: const Icon(Icons.date_range), label: tr('Hijri')),
                    BottomNavigationBarItem(
                        icon: const Icon(Icons.more_horiz), label: tr('More'))
                  ]),
            ));
  }
}
