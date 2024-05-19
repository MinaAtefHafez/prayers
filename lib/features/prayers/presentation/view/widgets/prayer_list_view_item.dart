import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/enum/enum.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';
import 'package:prayers/features/prayers/data/models/prayer_model.dart';

class PrayerListViewItem extends StatefulWidget {
  const PrayerListViewItem({
    super.key,
    required this.index,
    required this.prayer,
    required this.prayerState,
    required this.isPrayerForToday,
  });

  final int index;
  final PrayerModel prayer;
  final PrayerState prayerState;
  final bool isPrayerForToday;
  @override
  State<PrayerListViewItem> createState() => _PrayerListViewItemState();
}

class _PrayerListViewItemState extends State<PrayerListViewItem>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.index * 1));
    _animation = Tween<Offset>(begin: const Offset(0, 5), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: widget.isPrayerForToday
                  ? widget.prayerState == PrayerState.next
                      ? EdgeInsets.symmetric(horizontal: 10.w)
                      : null
                  : null,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  border: widget.isPrayerForToday
                      ? widget.prayerState == PrayerState.next
                          ? Border.all(color: AppColors.primary, width: 2)
                          : null
                      : null),
              child: Row(
                children: [
                  Container(
                    padding: widget.isPrayerForToday
                        ? widget.prayerState == PrayerState.previous
                            ? EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 15.w)
                            : null
                        : null,
                    decoration: widget.isPrayerForToday
                        ? widget.prayerState == PrayerState.previous
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(40.r),
                                color: AppColors.primary.withOpacity(0.2))
                            : null
                        : null,
                    child: Text(tr(widget.prayer.prayerName!),
                        style: AppStyles.style20.copyWith(
                            color: widget.isPrayerForToday
                                ? widget.prayerState == PrayerState.next
                                    ? AppColors.primary
                                    : Colors.black
                                : Colors.black,
                            fontWeight: widget.isPrayerForToday
                                ? widget.prayerState == PrayerState.next ||
                                        widget.prayerState ==
                                            PrayerState.previous
                                    ? FontWeight.bold
                                    : FontWeight.w500
                                : FontWeight.w500)),
                  ),
                  const Spacer(),
                  Text(widget.prayer.prayerDate!.split(' ').first,
                      style: AppStyles.style18.copyWith(
                          fontWeight: widget.isPrayerForToday
                              ? widget.prayerState == PrayerState.next ||
                                      widget.prayerState == PrayerState.previous
                                  ? FontWeight.bold
                                  : FontWeight.w400
                              : FontWeight.w400,
                          color: widget.isPrayerForToday
                              ? widget.prayerState == PrayerState.next
                                  ? AppColors.primary
                                  : Colors.black
                              : Colors.black)),
                ],
              ),
            ),
          ),
          40.0.width,
          const Icon(Icons.mic),
        ],
      ),
    );
  }
}
