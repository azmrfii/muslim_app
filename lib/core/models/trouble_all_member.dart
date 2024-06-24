// ignore_for_file: non_constant_identifier_names

class TroubleAllMember {
  final String id;
  final String memberId;
  final String nameMember;
  final String emailMember;
  final String idfull;
  final String keluhan;
  final String createAt;
  final String status;
  final String? namaKapal;
  final String? kategori;
  final String? type;
  final String? custamer;

  TroubleAllMember({
    required this.id,
    required this.memberId,
    required this.nameMember,
    required this.emailMember,
    required this.idfull,
    required this.keluhan,
    required this.createAt,
    required this.status,
    this.namaKapal,
    this.kategori,
    this.type,
    this.custamer,
  });

  factory TroubleAllMember.fromJson(Map<String, dynamic> json) {
    return TroubleAllMember(
      id: json['id'],
      memberId: json['member_id'],
      nameMember: json['nameMember'],
      emailMember: json['emailMember'],
      idfull: json['idfull'],
      keluhan: json['keluhan'],
      createAt: json['create_at'],
      status: json['status'],
      namaKapal: json['nama_kapal'],
      kategori: json['kategori'],
      type: json['type'],
      custamer: json['custamer'],
    );
  }
}
