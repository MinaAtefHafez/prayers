import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import '../../../../prayers/presentation/view/widgets/tab_bar_text_gregorian.dart';

class GregorianTopPart extends StatelessWidget {
  const GregorianTopPart(
      {super.key,
      required this.back,
      required this.next,
      required this.month,
      required this.year});

  final Function() back;
  final Function() next;
  final String month;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w  ),
          child: Row(
            children: [
              IconButton(
                  onPressed: back,
                  icon: Icon(
                    size: 25.w,
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(tr(month),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.style18.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
                    10.0.width,
                    Text(year,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.style18.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
              IconButton(
                  onPressed: next,
                  icon: Icon(
                    size: 25.w,
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        30.0.height,
        Row(
          children: [
            65.0.width,
            const Expanded(child: TabBarTextGregorian(text: 'Fajr')),
            const Expanded(child: TabBarTextGregorian(text: 'Dhuhr')),
            const Expanded(child: TabBarTextGregorian(text: 'Asr')),
            const Expanded(child: TabBarTextGregorian(text: 'Maghrib')),
            const Expanded(child: TabBarTextGregorian(text: 'Isha')),
          ],
        ),
        10.0.height,
      ],
    );
  }
}
