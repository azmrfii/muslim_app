// ignore_for_file: non_constant_identifier_names

class Airtime{
  String idfull, nama_kapal, sn, imei, custamer, timestamp, lat, lon, speed, heading, atp_start, atp_end;

  Airtime({
    required this.idfull, 
    required this.nama_kapal, 
    required this.sn, 
    required this.imei,
    required this.custamer,
    required this.timestamp,
    required this.lat,
    required this.lon,
    required this.speed,
    required this.heading,
    required this.atp_start,
    required this.atp_end,
  });

  factory Airtime.fromJson(Map<String, dynamic> json){
    return Airtime(
      idfull: json['idfull'] as String,
      nama_kapal: json['nama_kapal'] as String,
      sn: json['sn'] as String,
      imei: json['imei'] as String,
      custamer: json['custamer'] as String,
      timestamp: json['timestamp'] as String,
      lat: json['lat'] as String,
      lon: json['lon'] as String,
      speed: json['speed'] as String,
      heading: json['heading'] as String,
      atp_start: json['atp_start'] as String,
      atp_end: json['atp_end'] as String,
    );
  }
}


// class Airtime {
//   String idfull, nama_kapal, sn, imei, custamer, timestamp, lat, lon, speed, heading, atp_start, atp_end;
//   // final List<AirtimePeriod> airtime;

//   Airtime({
//     required this.idfull, 
//     required this.nama_kapal, 
//     required this.sn, 
//     required this.imei,
//     required this.custamer,
//     required this.timestamp,
//     required this.lat,
//     required this.lon,
//     required this.speed,
//     required this.heading,
//     required this.atp_start,
//     required this.atp_end,
//     // required this.airtime,
//   });

//   factory Airtime.fromJson(Map<String, dynamic> json) {
//     // final airtimeJson = json['airtime'] as List;
//     // final airtime = airtimeJson.map((e) => AirtimePeriod.fromJson(e)).toList();
    
//     return Airtime(
//       idfull: json['idfull'],
//       nama_kapal: json['nama_kapal'],
//       sn: json['sn'],
//       imei: json['imei'],
//       custamer: json['custamer'],
//       timestamp: json['timestamp'],
//       lat: json['lat'],
//       lon: json['lon'],
//       speed: json['speed'],
//       heading: json['heading'],
//       atp_start: json['atp_start'],
//       atp_end: json['atp_end'],
//       // airtime: airtime,
//     );
//   }
// }

// // class AirtimePeriod {
// //   final String airtime_start, airtime_end;

// //   AirtimePeriod({
// //     required this.airtime_start,
// //     required this.airtime_end,
// //   });

// //   factory AirtimePeriod.fromJson(Map<String, dynamic> json) {
// //     return AirtimePeriod(
// //       airtime_start: json['airtime_start'],
// //       airtime_end: json['airtime_end'],
// //     );
// //   }
// // }