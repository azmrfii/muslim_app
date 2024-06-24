// ignore_for_file: non_constant_identifier_names

class TroubleMember {
  final String id;
  final String memberId;
  final String idfull;
  final String keluhan;
  final String createAt;
  final String? namaKapal;
  final String? kategori;
  final String? type;
  final String? custamer;
  // final String? atpEnd;
  final int status;

  TroubleMember({
    required this.id,
    required this.memberId,
    required this.idfull,
    required this.keluhan,
    required this.createAt,
    required this.status,
    this.namaKapal,
    this.kategori,
    this.type,
    this.custamer,
    // this.atpEnd,
  });

  factory TroubleMember.fromJson(Map<String, dynamic> json) {
    return TroubleMember(
      id: json['id'],
      memberId: json['member_id'],
      idfull: json['idfull'],
      keluhan: json['keluhan'],
      createAt: json['create_at'],
      status: int.parse(json['status']),
      namaKapal: json['nama_kapal'],
      kategori: json['kategori'],
      type: json['type'],
      custamer: json['custamer'],
      // atpEnd: json['atp_end'],
    );
  }
}
