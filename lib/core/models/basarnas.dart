class Basarnas {
  final int? id;
  final double lat;
  final double lon;
  final String tipe;
  final String namaBasarnas;

  Basarnas({
    this.id,
    required this.lat,
    required this.lon,
    required this.tipe,
    required this.namaBasarnas,
  });

  factory Basarnas.fromJson(Map<String, dynamic> json) {
    return Basarnas(
      id: int.tryParse(json['id'] ?? ''),
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
      tipe: json['tipe'] as String,
      namaBasarnas: json['nama'] as String,
    );
  }
}
