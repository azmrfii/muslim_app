// ignore_for_file: non_constant_identifier_names

class NotificationMember {
  final String id;
  final String judul;
  final String teksNotification;
  final String createAt;
  final String memberId;
  // final String tujuan;
  final String readStatus;

  NotificationMember({
    required this.id,
    required this.judul,
    required this.teksNotification,
    required this.memberId,
    // required this.tujuan,
    required this.createAt,
    required this.readStatus,
  });

  factory NotificationMember.fromJson(Map<String, dynamic> json) {
    return NotificationMember(
      id: json['id'],
      judul: json['judul'],
      teksNotification: json['teks'],
      memberId: json['member_id'],
      // tujuan: json['tujuan'],
      createAt: json['create_at'],
      readStatus: json['read_status'],
    );
  }
}
