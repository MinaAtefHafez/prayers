import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/features/home/data/models/prayer_model.dart';
class PrayerListViewItem extends StatefulWidget {
  const PrayerListViewItem({super.key, required this.index, required this.prayer});

  final int index;
  final PrayerModel prayer;
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
          Text( tr(widget.prayer.prayerName!) ,
              style: AppStyles.style20
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text( widget.prayer.prayerDate!.split(' ').first ,
              style: AppStyles.style18
                  .copyWith(fontWeight: FontWeight.w400, color: Colors.black)),
          70.0.width,
          const Icon(Icons.mic),
        ],
      ),
    );
  }
}
