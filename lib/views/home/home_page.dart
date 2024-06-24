// ignore_for_file: unused_field, avoid_unnecessary_containers, prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muslim_app/views/kategori/categories_page.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _backgroundImage = '';

  @override
  void initState() {
    super.initState();
    _setBackgroundImage();
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
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
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
                          Text(
                            'Jadwal Shalat Berikutnya',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'test:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
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
