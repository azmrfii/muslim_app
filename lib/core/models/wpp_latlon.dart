class WppLatLong {
  final int id;
  final int wppId;
  final String lat;
  final String lon;

  WppLatLong({
    required this.id,
    required this.wppId,
    required this.lat,
    required this.lon,
  });

  factory WppLatLong.fromJson(Map<String, dynamic> json) {
    return WppLatLong(
      id: json['id'],
      wppId: json['wpp_id'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}