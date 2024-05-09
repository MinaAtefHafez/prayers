import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/dependency_injection/dependency_injection.dart';
import 'package:prayers/core/extensions/distance_extention.dart';
import 'package:prayers/core/extensions/navigator_extension.dart';
import 'package:prayers/core/theme/app_styles/app_styles.dart';
import 'package:prayers/core/theme/colors/colors.dart';
import 'package:prayers/features/home/presentation/view/screens/home_screen.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/method_text_field.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/methods_bottom_sheet.dart';
import 'package:prayers/features/settings_details/presentation/view/widgets/settings_button.dart';

class MethodScreen extends StatefulWidget {
  const MethodScreen({super.key});

  static const name = '/method';

  @override
  State<MethodScreen> createState() => _MethodScreenState();
}

class _MethodScreenState extends State<MethodScreen> {
  final settingsCubit = di<SettingsCubit>();

  @override
  void initState() {
    super.initState();
    settingsCubit.getMethods();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: settingsCubit,
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SaveMethodLocalSuccess) {
            context.pushNamedRemoveUntil(HomeScreen.name);
          }
        },
        child: Scaffold(
          body: Center(
            child: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
              if (settingsCubit.methodsModel != null) {
                return Padding(
                  padding: EdgeInsets.all(30.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(tr('MethodWay'),
                          style: AppStyles.style27
                              .copyWith(color: AppColors.primary)),
                      50.0.height,
                      Builder(builder: (context) {
                        return MethodTextField(
                          textEditingController: TextEditingController(
                              text: settingsCubit.method!.name),
                          label: 'Method',
                          onTap: () {
                            methodBottomSheet(context,
                                methodsModel: settingsCubit.methodsModel!,
                                onTap: settingsCubit.chooseMethod);
                          },
                        );
                      }),
                      70.0.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<SettingsCubit, SettingsState>(
                              builder: (context, state) {
                            if (state is SaveMethodLocalLoading) {
                              return const CircularProgressIndicator();
                            } else {
                              return SettingsButton(
                                  text: 'Next',
                                  onPressed: () {
                                    settingsCubit.saveMethodLocal();
                                  });
                            }
                          }),
                          SettingsButton(
                              text: 'Back',
                              onPressed: () {
                                context.pop();
                              }),
                        ],
                      )
                    ],
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
          ),
        ),
      ),
    );
  }
}
