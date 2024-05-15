import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/features/prayers/presentation/cubits/home_cubit/prayers_cubit.dart';
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
  late Timer timer;
  @override
  void initState() {
    super.initState();
    call();
  }

  void call() async {
    await Future.wait([
      settingsCubit.getMothodLocal(),
      settingsCubit.getLocationLocal(),
    ]);
    await prayersCubit.getCalendarMonth();
    timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      await prayersCubit.getPrayers();
      await prayersCubit.getPreviousPrayerForToday();
      await prayersCubit.getNextPrayerForToday();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayersCubit, PrayersState>(
        bloc: prayersCubit,
        builder: (context, state) => Scaffold(
              body: prayersCubit.screens[prayersCubit.bottomNavIndex],
              bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey.shade500,
                  showUnselectedLabels: true,
                  selectedIconTheme: const IconThemeData(
                      color: Colors.black, applyTextScaling: true, size: 27),
                  selectedLabelStyle: AppStyles.style16.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.black),
                  currentIndex: prayersCubit.bottomNavIndex,
                  onTap: prayersCubit.changeBottomNavIndex,
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
