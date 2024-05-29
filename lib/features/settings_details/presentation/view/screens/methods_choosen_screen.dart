import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers/core/dependency_injection/dependency_injection.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';

class MethodChoosenScreen extends StatefulWidget {
  const MethodChoosenScreen({super.key});

  static const name = '/MethodChoosen';

  @override
  State<MethodChoosenScreen> createState() => _MethodChoosenScreenState();
}

class _MethodChoosenScreenState extends State<MethodChoosenScreen> {
  final settingsCubit = di<SettingsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: settingsCubit,
      child: Scaffold(
          appBar: AppBar(
            title: Text(tr('Method')),
          ),
          body: Container()),
    );
  }
}
