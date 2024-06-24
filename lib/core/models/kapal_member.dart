// ignore_for_file: non_constant_identifier_names

class KapalMember {
  final String id;
  final String memberId;
  final String idfull;
  final String createAt;
  final String? namaKapal;
  final String? kategori;
  final String? type;
  final String? custamer;
  final String? atpEnd;
  final double lat;
  final double lon;

  KapalMember({
    required this.id,
    required this.memberId,
    required this.idfull,
    required this.createAt,
    this.namaKapal,
    this.kategori,
    this.type,
    this.custamer,
    this.atpEnd,
    required this.lat,
    required this.lon,
  });

  factory KapalMember.fromJson(Map<String, dynamic> json) {
    return KapalMember(
      id: json['id'],
      memberId: json['member_id'],
      idfull: json['idfull'],
      createAt: json['create_at'],
      namaKapal: json['nama_kapal'],
      kategori: json['kategori'],
      type: json['type'],
      custamer: json['custamer'],
      atpEnd: json['atp_end'],
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
    );
  }
}
