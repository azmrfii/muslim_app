// quran_service.dart
// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranService {
  Future<void> fetchKalenderHijriah() async {
    final response =
        await http.get(Uri.parse('https://api.myquran.com/v2/cal/hijr'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['data'];
    } else {
      throw Exception('Error Kalender');
    }
  }

  Future<void> fetchKota() async {
    final response = await http
        .get(Uri.parse('https://api.myquran.com/v2/sholat/kota/semua'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['data'];
    } else {
      throw Exception('Error Lokasi');
    }
  }

  Future<void> fetchJadwalShalat(String kotaId) async {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy/MM/dd');
    final formattedDate = formatter.format(now);

    final year = now.year;
    final month = now.month;
    final day = now.day;

    final response = await http.get(Uri.parse(
        'https://api.myquran.com/v2/sholat/jadwal/$kotaId/$year/$month/$day'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['data'];
    } else {
      throw Exception('Error Jadwal Shalat');
    }
  }

  Future<void> saveSelectedKota(String kotaId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedKota', kotaId);
  }

  Future<String?> loadSelectedKota() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedKota');
  }
}
