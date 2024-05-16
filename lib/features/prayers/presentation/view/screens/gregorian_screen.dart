import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';
import 'package:prayers/features/prayers/presentation/view/widgets/tab_bar_text_gregorian.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';

import '../../../../../core/dependency_injection/dependency_injection.dart';

class GregorianScreen extends StatefulWidget {
  const GregorianScreen({super.key});

  static const name = '/gregorian';

  @override
  State<GregorianScreen> createState() => _GregorianScreenState();
}

class _GregorianScreenState extends State<GregorianScreen> {
  final settingsCubit = di<SettingsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(settingsCubit.location!.locationName!),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(150.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            size: 25.w,
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            
                          )),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('fsdfsdfsdf',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyles.style18.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  )),
                              30.0.width,
                                  Icon(Icons.arrow_drop_down,
                                  color: Colors.white , 
                                   size: 30.w ,
                                  ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
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
                    70.0.width,
                    const Expanded(child: TabBarTextGregorian(text: 'Fajr')),
                    const Expanded(child: TabBarTextGregorian(text: 'Dhuhr')),
                    const Expanded(child: TabBarTextGregorian(text: 'Asr')),
                    const Expanded(child: TabBarTextGregorian(text: 'Maghrib')),
                    const Expanded(child: TabBarTextGregorian(text: 'Isha')),
                  ],
                ),
                10.0.height,
              ],
            )),
      ),
      body: ListView.separated(
        itemCount: 30,
        separatorBuilder: (context, index) => Divider(
          height: 0,
          color: Colors.grey.shade300,
          thickness: 1,
        ),
        itemBuilder: (context, index) => Container(
          alignment: Alignment.center,
          height: 60.h,
          child: Row(
            children: [
            Container(
              width: 55.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  ),
              child: Text('31',
                  style: AppStyles.style18.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Expanded(
                child: Center(
              child: Text('4:55',
                  style: AppStyles.style18
                      .copyWith(color: Colors.grey.shade500)),
            )),
            Expanded(
                child: Center(
              child: Text('4:55',
                  style: AppStyles.style18
                      .copyWith(color: Colors.grey.shade500)),
            )),
            Expanded(
                child: Center(
              child: Text('4:55',
                  style: AppStyles.style18
                      .copyWith(color: Colors.grey.shade500)),
            )),
            Expanded(
                child: Center(
              child: Text('4:55',
                  style: AppStyles.style18
                      .copyWith(color: Colors.grey.shade500)),
            )),
            Expanded(
                child: Center(
              child: Text('4:55',
                  style: AppStyles.style18
                      .copyWith(color: Colors.grey.shade500)),
            )),
          ]),
        ),
      ),
    );
  }
}
