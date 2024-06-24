// ignore_for_file: unused_field, avoid_unnecessary_containers, prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:muslim_app/views/kategori/asmaul_husna/asmaul_husna_page.dart';
import 'package:muslim_app/views/kategori/doa/doa_page.dart';
import 'package:muslim_app/views/kategori/jadwal_shalat/jadwal_shalat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  // Container(
                  //   height: constraints.maxHeight * 0.3,
                  //   child: JadwalShalatPage(),
                  // ),
                  // SizedBox(
                  //   height: constraints.maxHeight * 0.15,
                  // ),
                  Container(
                    height: constraints.maxHeight,
                    child: DoaPage(),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.15,
                  ),
                  // Container(
                  //   height: constraints.maxHeight * 0.3,
                  //   child: AsmaulHusnaPage(),
                  // ),
                  // SizedBox(
                  //   height: constraints.maxHeight * 0.15,
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
