// ignore_for_file: public_member_api_docs, sort_constructors_first

class YearMonthModel {
  String? year;
  String? month;
  bool? isShow;
  YearMonthModel({this.year, this.month, this.isShow});

  YearMonthModel copyWith({
    String? year,
    String? month,
    bool? isShow,
  }) {
    return YearMonthModel(
      year: year ?? this.year,
      month: month ?? this.month,
      isShow: isShow ?? this.isShow,
    );
  }
}
