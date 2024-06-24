class PortPelabuhan {
  // final int? id;
  final String namaPelabuhan;
  final String kodePelabuhan;
  final double lat;
  final double lon;

  PortPelabuhan({
    // this.id,
    required this.namaPelabuhan,
    required this.kodePelabuhan,
    required this.lat,
    required this.lon,
  });

  factory PortPelabuhan.fromJson(Map<String, dynamic> json) {
    return PortPelabuhan(
      // id: json['id'],
      namaPelabuhan: json['nama'],
      kodePelabuhan: json['kd_pelabuhan'],
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
    );
  }
}