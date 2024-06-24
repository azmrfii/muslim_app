class TroubleMemberDetail {
  String? troubleMemberId;
  String? adminId;
  String? userGeoId;
  String? memberId;
  String? respon;
  String? responMember;
  String? createAt;
  String? createAtMember;
  String? nameUser;
  String? nameAdmin;
  String? nameMember;
  String? isAdminMember;

  TroubleMemberDetail({
    this.troubleMemberId,
    this.adminId,
    this.userGeoId,
    this.memberId,
    this.respon,
    this.responMember,
    this.createAt,
    this.createAtMember,
    this.nameUser,
    this.nameAdmin,
    this.nameMember,
    this.isAdminMember,
  });

  factory TroubleMemberDetail.fromJson(Map<String, dynamic> json) {
    return TroubleMemberDetail(
      troubleMemberId: json['trouble_member_id'],
      adminId: json['admin_id'],
      userGeoId: json['user_geo_id'],
      memberId: json['member_id'],
      respon: json['respon'],
      responMember: json['responMember'],
      createAt: json['create_at'],
      createAtMember: json['create_at_member'],
      nameUser: json['nameUser'],
      nameAdmin: json['nameAdmin'],
      nameMember: json['nameMember'],
      isAdminMember: json['is_admin_member'],
    );
  }
}