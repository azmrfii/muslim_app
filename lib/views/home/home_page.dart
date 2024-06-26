// ignore_for_file: unused_field, avoid_unnecessary_containers, prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, deprecated_member_use, unnecessary_cast, unused_local_variable

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:muslim_app/views/kategori/categories_page.dart';

import 'package:http/http.dart' as http;
import 'package:muslim_app/views/kategori/jadwal_shalat/jadwal_shalat_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _backgroundImage = '';
  Map<String, dynamic>? jadwalShalat;
  Map<String, dynamic>? _kalenderHijriah;
  Timer? _timer;
  String _currentTime = '';
  List<dynamic> _kota = [];
  String? _selectedKota;

  @override
  void initState() {
    super.initState();
    fetchKalenderHijriah();
    fetchKota();
    fetchjadwalShalat();
    _setBackgroundImage();
    _updateTime();
    _loadSelectedKota();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
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

  Future<void> _saveSelectedKota(String kotaId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedKota', kotaId);
  }

  void _updateTime() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime =
            '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}';
      });
    });
  }

  void _setBackgroundImage() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;

    if (hour >= 3 && hour < 6) {
      _backgroundImage = 'assets/images/shubuh_crop.png';
    } else if (hour >= 6 && hour < 17) {
      _backgroundImage = 'assets/images/dzuhur_crop.png';
    } else if (hour >= 17 && (hour < 18 || (hour == 18 && minute < 30))) {
      _backgroundImage = 'assets/images/magrib_crop.png';
    } else {
      _backgroundImage = 'assets/images/isya_crop.png';
    }
    setState(() {});
  }

  String _getCurrentPrayerText() {
    if (jadwalShalat == null) {
      return 'Loading...';
    }
    
    final currentTime = TimeOfDay.now();
    final prayerTimes = jadwalShalat!['jadwal'];

    final subuhTime = _parseTime(prayerTimes['subuh']);
    final dzuhurTime = _parseTime(prayerTimes['dzuhur']);
    final asharTime = _parseTime(prayerTimes['ashar']);
    final maghribTime = _parseTime(prayerTimes['maghrib']);
    final isyaTime = _parseTime(prayerTimes['isya']);

    if (currentTime.hour < subuhTime.hour ||
        (currentTime.hour == subuhTime.hour &&
            currentTime.minute < subuhTime.minute)) {
      return 'Menuju Subuh';
    } else if (currentTime.hour < dzuhurTime.hour ||
        (currentTime.hour == dzuhurTime.hour &&
            currentTime.minute < dzuhurTime.minute)) {
      return 'Menuju Dzuhur';
    } else if (currentTime.hour < asharTime.hour ||
        (currentTime.hour == asharTime.hour &&
            currentTime.minute < asharTime.minute)) {
      return 'Menuju Ashar';
    } else if (currentTime.hour < maghribTime.hour ||
        (currentTime.hour == maghribTime.hour &&
            currentTime.minute < maghribTime.minute)) {
      return 'Menuju Maghrib';
    } else {
      return 'Menuju Isya';
    }
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  Future<void> fetchKalenderHijriah() async {
    final response =
        await http.get(Uri.parse('https://api.myquran.com/v2/cal/hijr'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _kalenderHijriah = jsonData['data'];
      });
    } else {
      throw Exception('Error Kalender');
    }
  }

  Future<void> fetchKota() async {
    final response = await http
        .get(Uri.parse('https://api.myquran.com/v2/sholat/kota/semua'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _kota = jsonData['data'];
      });
    } else {
      throw Exception('Error Lokasi');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              'Lokasi',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            margin: EdgeInsets.only(left: 15),
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: DropdownButton(
                              value: _selectedKota,
                              onChanged: (value) async {
                                setState(() {
                                  _selectedKota = value as String?;
                                });
                                await _saveSelectedKota(value as String);
                                fetchjadwalShalat();
                              },
                              items: _kota.map((kota) {
                                return DropdownMenuItem(
                                  value: kota['id'].toString(),
                                  child: Text(kota['lokasi']),
                                );
                              }).toList(),
                              isExpanded: true,
                              menuMaxHeight: 250,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/setting.svg',
                          color: Color.fromARGB(255, 92, 131, 116),
                          width: 30,
                          height: 30,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 15, top: 10),
                    child: Container(
                      width: constraints.maxWidth,
                      padding: const EdgeInsets.all(15),
                      height: 210,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_backgroundImage),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 92, 131, 116)
                                .withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 7,
                            offset: Offset(0, 10),
                          ),
                          BoxShadow(
                            color: Color.fromARGB(255, 147, 177, 166)
                                .withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 7,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _kalenderHijriah != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${_kalenderHijriah!['date'][0]}, ${_kalenderHijriah!['date'][1]}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('dd MMM y')
                                          .format(DateTime.now()),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Text('Loading...'),
                          SizedBox(height: 7),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  _currentTime,
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // SizedBox(height: 2),
                                Text(
                                  _getCurrentPrayerText(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          jadwalShalat == null
                              ? Center(child: CircularProgressIndicator())
                              : SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, top: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      JadwalShalatPage()),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Subuh',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'OpenSans',
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      jadwalShalat!['jadwal']
                                                          ['subuh'],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
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
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      jadwalShalat!['jadwal']
                                                          ['dzuhur'],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
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
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      jadwalShalat!['jadwal']
                                                          ['ashar'],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
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
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      jadwalShalat!['jadwal']
                                                          ['maghrib'],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
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
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      jadwalShalat!['jadwal']
                                                          ['isya'],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Categories(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
