// ignore_for_file: unused_field, avoid_unnecessary_containers, prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, deprecated_member_use, unnecessary_cast

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:muslim_app/views/kategori/categories_page.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _backgroundImage = '';
  Map<String, dynamic>? _kalenderHijriah;
  Timer? _timer;
  String _currentTime = '';
  List<dynamic> _kota = [];
  String? _selectedKota;

  @override
  void initState() {
    super.initState();
    _setBackgroundImage();
    fetchKalenderHijriah();
    _updateTime();
    fetchKota();
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
                    height: 50,
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
                      height: 150,
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
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_kalenderHijriah!['date'][0]}, ${_kalenderHijriah!['date'][1]}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(1, 1),
                                            blurRadius: 2,
                                            color: Colors.black45,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      DateFormat.yMMMMd()
                                          .format(DateTime.now()),
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(1, 1),
                                            blurRadius: 2,
                                            color: Colors.black45,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Text('Loading...'),
                          Spacer(),
                          Expanded(
                            child: Text(
                              _currentTime,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                    color: Colors.black45,
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
