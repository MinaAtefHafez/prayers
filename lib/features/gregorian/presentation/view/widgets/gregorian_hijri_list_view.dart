import 'package:flutter/material.dart';
import 'package:prayers/features/gregorian/data/models/gregorian_year_model.dart';

import 'gregorian_list_view_item.dart';

class GregorianHijriListView extends StatelessWidget {
  const GregorianHijriListView(
      {super.key, required this.list, required this.isGregorian});

  final List<GregorianYear> list;
  final bool isGregorian;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (context, index) => Divider(
        height: 0,
        color: Colors.grey.shade300,
        thickness: 1,
      ),
      itemBuilder: (context, index) => GregorianListViewItem(
        gregorianYear: list[index],
        isGregorian: isGregorian,
      ),
    );
  }
}
