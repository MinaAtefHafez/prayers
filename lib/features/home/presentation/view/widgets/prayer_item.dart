import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/features/home/data/models/prayer_model.dart';

class PrayerItem extends StatefulWidget {
  const PrayerItem(
      {super.key,
      required this.prayerModel,
      this.isPrayerNext = false,
      required this.isPrayerNow});

  final PrayerModel prayerModel;
  final bool isPrayerNext;
  final bool isPrayerNow;

  @override
  State<PrayerItem> createState() => _PrayerItemState();
}

class _PrayerItemState extends State<PrayerItem> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isPrayerNow) ...[
          FadeTransition(
            opacity: _animation,
            child: Text(tr(widget.prayerModel.prayerName!),
                style: AppStyles.style25.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ] else ...[
          Text(tr(widget.prayerModel.prayerName!),
              style: AppStyles.style25
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
        Text(widget.prayerModel.prayerDate!.split(' ').first,
            style: AppStyles.style30
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        10.0.height,
        IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.grey.shade400, width: 2)),
            child: Visibility(
              visible: widget.isPrayerNext,
              replacement: Text(
                  '${tr('Since')} ${widget.prayerModel.differnece!}${tr('Min')}',
                  style: AppStyles.style18.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600)),
              child: Text('${widget.prayerModel.differnece!}${tr('Min')}',
                  style: AppStyles.style18.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ],
    );
  }
}
