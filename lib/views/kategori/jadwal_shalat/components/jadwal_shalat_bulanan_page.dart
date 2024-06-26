// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JadwalShalatBulananPage extends StatefulWidget {
  const JadwalShalatBulananPage({super.key});

  @override
  _JadwalShalatBulananPageState createState() =>
      _JadwalShalatBulananPageState();
}

class _JadwalShalatBulananPageState extends State<JadwalShalatBulananPage> {
  List<dynamic> _jadwalShalat = [];
  String? _selectedKota;

  @override
  void initState() {
    super.initState();
    fetchJadwalShalat();
    _loadSelectedKota();
  }

  Future<void> fetchJadwalShalat() async {
    await _loadSelectedKota();

    final now = DateTime.now();
    final formatter = DateFormat('yyyy/MM/dd');
    final formattedDate = formatter.format(now);

    final year = now.year;
    final month = now.month;

    final response = await http.get(Uri.parse(
        'https://api.myquran.com/v2/sholat/jadwal/${_selectedKota}/$year/$month'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _jadwalShalat = jsonData['data']['jadwal'];
      });
    } else {
      throw Exception('Error Jadwal Shalat');
    }
  }

  Future<void> _loadSelectedKota() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedKota = prefs.getString('selectedKota');
    if (selectedKota != null) {
      setState(() {
        _selectedKota = selectedKota;
      });
    } else {
      setState(() {
        _selectedKota = '1301'; // default kota jakarta
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _jadwalShalat.isEmpty
          ? Center(
              child: Text('No data available'),
            )
          : ListView.builder(
              itemCount: _jadwalShalat.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                  child: Card(
                    color: Color.fromARGB(255, 92, 131, 116),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 8, top: 4, bottom: 4),
                            child: Text(
                              _jadwalShalat[index]['tanggal'],
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 147, 177, 166)),
                            ),
                          ),
                          SizedBox(height: 2),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Colors.grey.shade200, width: 1),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Subuh',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        color: Color.fromARGB(255, 24, 61, 61),
                                      ),
                                    ),
                                    Text(
                                      _jadwalShalat[index]['subuh'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 24, 61, 61),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Dzuhur',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        color: Color.fromARGB(255, 24, 61, 61),
                                      ),
                                    ),
                                    Text(
                                      _jadwalShalat[index]['dzuhur'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 24, 61, 61),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Ashar',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        color: Color.fromARGB(255, 24, 61, 61),
                                      ),
                                    ),
                                    Text(
                                      _jadwalShalat[index]['ashar'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 24, 61, 61),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Maghrib',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        color: Color.fromARGB(255, 24, 61, 61),
                                      ),
                                    ),
                                    Text(
                                      _jadwalShalat[index]['maghrib'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 24, 61, 61),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Isya',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        color: Color.fromARGB(255, 24, 61, 61),
                                      ),
                                    ),
                                    Text(
                                      _jadwalShalat[index]['isya'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 24, 61, 61),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
