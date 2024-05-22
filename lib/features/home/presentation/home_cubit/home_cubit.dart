import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers/features/dome/presentation/view/screens/compass_screen.dart';
import 'package:prayers/features/dome/presentation/view/screens/dome_screen.dart';
import 'package:prayers/features/prayers/presentation/view/screens/prayers_screen.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int bottomNavIndex = 0;

  final List<Widget> screens = const [
    PrayerScreen(),
    DomeScreen(),
    CompassScreen()
  ];

  void changeBottomNavIndex(int index) {
    bottomNavIndex = index;
    emit(BottomNavBar());
  }
}
