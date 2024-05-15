class CalendarMonthModelParma {
  final double latitude;
  final double longitude;
  final int method;

  CalendarMonthModelParma(
      {required this.latitude, required this.longitude, required this.method});

 Map <String, dynamic> toJson () => {
   "latitude": latitude,
   "longitude": longitude,
   "method": method
 };

}
