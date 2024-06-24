class WppRi {
  final int? id;
  final String namaWpp;
  final String keterangan;

  WppRi({
    required this.id,
    required this.namaWpp,
    required this.keterangan,
  });

  factory WppRi.fromJson(Map<String, dynamic> json) {
    return WppRi(
      // id: json['id'],
      id: int.tryParse(json['id'] ?? ''),
      namaWpp: json['nama_wpp'],
      keterangan: json['keterangan'],
    );
  }
}
