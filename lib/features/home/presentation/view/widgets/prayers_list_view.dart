import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/features/home/data/models/prayer_model.dart';
import 'package:prayers/features/home/presentation/view/widgets/prayer_list_view_item.dart';

class PrayersListView extends StatelessWidget {
  const PrayersListView({super.key, required this.prayers});

  final List<PrayerModel> prayers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: prayers.length,
        itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: PrayerListViewItem(
                index: index,
                prayer: prayers[index],
              ),
            ));
  }
}
