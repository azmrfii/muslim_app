import 'dart:ui';

class WppZoneAll {
  final int wppId;
  final String lat;
  final String lon;
  Color? color;

  WppZoneAll({
    required this.wppId,
    required this.lat,
    required this.lon,
    this.color,
  });
}
