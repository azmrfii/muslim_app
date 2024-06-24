// ignore_for_file: non_constant_identifier_names

class KapalAPN {
  final String? mobileId;
  final String? categoryName;
  final String? typeName;
  final String? sn;
  final String? imei;
  final String? legalName;
  final String? telephonePemilik;
  final String? vesselName;
  final String? description;
  final String? status;
  final String? timestamp;
  final String? latitude;
  final String? longitude;
  final String? speed;
  final String? heading;
  final String? modemstatus;
  final String? emergency;
  final String? powerStatus;
  final String? externalVoltage;
  final String? batteryVoltage;
  final String? airtimeStartDate;
  final String? airtimeEndDate;
  final String? atpNotify;
  final String? regBy;
  final String? registerDate;
  final String? isSold;
  final String? isSabotage;
  final String? isKKP;
  final String? broken;
  final String? foto;
  final String? isCharging;
  final String? idfull;
  final String? destination;
  final String? eta;
  final String? shipType;
  final String? flagCountryName;
  final String? distance;

  KapalAPN({
    this.mobileId,
    this.categoryName,
    this.typeName,
    this.sn,
    this.imei,
    this.legalName,
    this.telephonePemilik,
    this.vesselName,
    this.description,
    this.status,
    this.timestamp,
    this.latitude,
    this.longitude,
    this.speed,
    this.heading,
    this.modemstatus,
    this.emergency,
    this.powerStatus,
    this.externalVoltage,
    this.batteryVoltage,
    this.airtimeStartDate,
    this.airtimeEndDate,
    this.atpNotify,
    this.regBy,
    this.registerDate,
    this.isSold,
    this.isSabotage,
    this.isKKP,
    this.broken,
    this.foto,
    this.isCharging,
    this.idfull,
    this.destination,
    this.eta,
    this.shipType,
    this.flagCountryName,
    this.distance,
  });

  factory KapalAPN.fromJson(Map<String, dynamic> json) {
    return KapalAPN(
      mobileId: json['mobile_id'],
      categoryName: json['category_name'],
      typeName: json['type_name'],
      sn: json['sn'],
      imei: json['imei'],
      legalName: json['legal_name'],
      telephonePemilik: json['telephone_pemilik'],
      vesselName: json['vessel_name'],
      description: json['description'],
      status: json['status'],
      timestamp: json['timestamp'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      speed: json['speed'],
      heading: json['heading'],
      modemstatus: json['modemstatus'],
      emergency: json['emergency'],
      powerStatus: json['powerstatus'],
      externalVoltage: json['externalvoltage'],
      batteryVoltage: json['battery_voltage'],
      airtimeStartDate: json['airtime_start_date'],
      airtimeEndDate: json['airtime_end_date'],
      atpNotify: json['atp_notify'],
      regBy: json['regBy'],
      registerDate: json['register_date'],
      isSold: json['isSold'],
      isSabotage: json['isSabotage'],
      isKKP: json['isKKP'],
      broken: json['broken'],
      foto: json['foto'],
      isCharging: json['isCharging'],
      idfull: json['idfull'],
      destination: json['destination'],
      eta: json['eta'],
      shipType: json['ship_type'],
      flagCountryName: json['flaf_country_name'],
      distance: json['distance'],
    );
  }
}
