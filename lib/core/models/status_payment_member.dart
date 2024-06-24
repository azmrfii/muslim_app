// ignore_for_file: non_constant_identifier_names

class StatusPaymentMember {
  final String id;
  final String memberId;
  final String idfull;
  final String createAt;
  final int status;
  final String? namaKapal;
  final String? kategori;
  final String? type;
  final String? custamer;

  StatusPaymentMember({
    required this.id,
    required this.memberId,
    required this.idfull,
    required this.createAt,
    required this.status,
    this.namaKapal,
    this.kategori,
    this.type,
    this.custamer,
  });

  factory StatusPaymentMember.fromJson(Map<String, dynamic> json) {
    return StatusPaymentMember(
      id: json['id'],
      memberId: json['member_id'],
      idfull: json['idfull'],
      createAt: json['create_at'],
      status: int.parse(json['status']),
      namaKapal: json['nama_kapal'],
      kategori: json['kategori'],
      type: json['type'],
      custamer: json['custamer'],
    );
  }
}
