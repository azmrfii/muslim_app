// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_local_variable, unnecessary_brace_in_string_interps, unused_field

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JadwalShalatPage extends StatefulWidget {
  const JadwalShalatPage({super.key});

  @override
  _JadwalShalatPageState createState() => _JadwalShalatPageState();
}

class _JadwalShalatPageState extends State<JadwalShalatPage> {
  Map<String, dynamic>? jadwalShalat;
  String _backgroundImage = 'assets/images/isya.png';
  String? _selectedKota;
  Timer? _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    fetchjadwalShalat();
    _setBackgroundImage();
    _updateTime();
    _loadSelectedKota();
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

  void _updateTime() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime =
            '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}';
      });
    });
  }

  Future<void> fetchjadwalShalat() async {
    await _loadSelectedKota();

    final now = DateTime.now();
    final formatter = DateFormat('yyyy/MM/dd');
    final formattedDate = formatter.format(now);

    final year = now.year;
    final month = now.month;
    final day = now.day;

    final response = await http.get(Uri.parse(
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

  void _setBackgroundImage() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;

    if (hour >= 3 && hour < 6) {
      _backgroundImage = 'assets/images/shubuh.png';
    } else if (hour >= 6 && hour < 17) {
      _backgroundImage = 'assets/images/dzuhur.png';
    } else if (hour >= 17 && (hour < 18 || (hour == 18 && minute < 30))) {
      _backgroundImage = 'assets/images/magrib.png';
    } else {
      _backgroundImage = 'assets/images/isya.png';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text(
              jadwalShalat != null ? jadwalShalat!['lokasi'] : '',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(3, 2),
                    blurRadius: 2,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            Text(
              _currentTime,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'OpenSans',
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Expanded(
              child: Container(),
            ),
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
