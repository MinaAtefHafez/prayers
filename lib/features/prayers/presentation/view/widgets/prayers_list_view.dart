import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/enum/enum.dart';
import 'package:prayers/features/prayers/data/models/prayer_model.dart';
import 'package:prayers/features/prayers/presentation/view/widgets/prayer_list_view_item.dart';

class PrayersListView extends StatelessWidget {
  const PrayersListView(
      {super.key,
      required this.prayers,
      required this.prayerState,
      required this.isPrayersForToday});

  final List<PrayerModel> prayers;
  final PrayerState Function(PrayerModel prayer) prayerState;
  final bool isPrayersForToday;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: prayers.length,
        itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 15.h ),
              child: Builder(builder: (context) {
                final state = prayerState(prayers[index]);
                return PrayerListViewItem(
                  isPrayerForToday: isPrayersForToday,
                  prayerState: state,
                  index: index,
                  prayer: prayers[index],
                );
              }),
            ));
  }
}
