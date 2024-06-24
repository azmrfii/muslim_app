// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class JadwalShalatPage extends StatefulWidget {
  const JadwalShalatPage({super.key});

  @override
  _JadwalShalatPageState createState() => _JadwalShalatPageState();
}

class _JadwalShalatPageState extends State<JadwalShalatPage> {
  Map<String, dynamic>? jadwalShalat;
  String _backgroundImage = 'assets/images/shubuh.png';
  List<dynamic> _kota = [];
  String? _selectedKota = '1301';

  Future<void> fetchKota() async {
    final response = await http
        .get(Uri.parse('https://api.myquran.com/v2/sholat/kota/semua'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _kota = jsonData['data'];
        print(_kota);
      });
    } else {
      throw Exception('Error Lokasi');
    }
  }

  Future<void> fetchjadwalShalat() async {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy/MM/dd');
    final formattedDate = formatter.format(now);

    final year = now.year;
    final month = now.month;
    final day = now.day;

    final response = await http.get(Uri.parse(
        // 'https://api.myquran.com/v2/sholat/jadwal/1204/$year/$month/$day'));
        'https://api.myquran.com/v2/sholat/jadwal/${_selectedKota}/$year/$month/$day'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        jadwalShalat = jsonData['data'];
      });
    } else {
      throw Exception('Error Jadwal Shalat');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchjadwalShalat();
    fetchKota();
    _setBackgroundImage();
  }

  void _setBackgroundImage() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;

    if (hour == 11 && minute >= 0) {
      _backgroundImage = 'assets/images/dzuhur.png';
    } else if (hour == 17 && minute >= 0) {
      _backgroundImage = 'assets/images/maghrib.png';
    } else if (hour == 18 && minute >= 0) {
      _backgroundImage = 'assets/images/isya.png';
    } else if (hour == 4 && minute >= 0) {
      _backgroundImage = 'assets/images/shubuh.png';
    } else {
      _backgroundImage = 'assets/images/shubuh.png';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 200,
          // height: 300,
          child: DropdownButton(
            isExpanded: true,
            value: _selectedKota,
            onChanged: (value) {
              setState(() {
                _selectedKota = value as String?;
                fetchjadwalShalat();
              });
            },
            items: _kota.map((kota) {
              return DropdownMenuItem(
                value: kota['id'].toString(),
                child: Text(kota['lokasi']),
              );
            }).toList(),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundImage),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Container(
              width: double.infinity,
              height: 270,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: jadwalShalat == null
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Imsak',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 18),
                                    SizedBox(width: 5),
                                    Text(
                                      jadwalShalat!['jadwal']['imsak'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subuh',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 18),
                                    SizedBox(width: 5),
                                    Text(
                                      jadwalShalat!['jadwal']['subuh'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Terbit',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 18),
                                    SizedBox(width: 5),
                                    Text(
                                      jadwalShalat!['jadwal']['terbit'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dhuha',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 18),
                                    SizedBox(width: 5),
                                    Text(
                                      jadwalShalat!['jadwal']['dhuha'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dzuhur',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 18),
                                    SizedBox(width: 5),
                                    Text(
                                      jadwalShalat!['jadwal']['dzuhur'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ashar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 18),
                                    SizedBox(width: 5),
                                    Text(
                                      jadwalShalat!['jadwal']['ashar'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Maghrib',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 18),
                                    SizedBox(width: 5),
                                    Text(
                                      jadwalShalat!['jadwal']['maghrib'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Isya',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 18),
                                    SizedBox(width: 5),
                                    Text(
                                      jadwalShalat!['jadwal']['isya'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
