import 'package:flutter/material.dart';
// import 'package:muslim_app/views/kategori/asmaul_husna/asmaul_husna_page.dart';
// import 'package:muslim_app/views/kategori/hadits/hadits_page.dart';
import 'package:muslim_app/views/kategori/jadwal_shalat/jadwal_shalat_page.dart';
// import 'package:muslim_app/views/kategori/doa/doa_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Muslim App'),
        ),
        body: JadwalShalatPage(),
      ),
    );
  }
}