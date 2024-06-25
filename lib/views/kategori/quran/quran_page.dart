// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:muslim_app/views/kategori/quran/components/juz_page.dart';
import 'package:muslim_app/views/kategori/quran/components/surat_page.dart';

class AlQuranPage extends StatefulWidget {
  const AlQuranPage({super.key});

  @override
  _AlQuranPageState createState() => _AlQuranPageState();
}

class _AlQuranPageState extends State<AlQuranPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Al-Qur\'an'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Surat'),
              Tab(text: 'Juz'),
            ],
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide.none,
            ),
            labelColor: Color.fromARGB(255, 92, 131, 116),
            unselectedLabelColor: Colors.black45,
            isScrollable: false,
            labelPadding: EdgeInsets.all(4),
          ),
        ),
        body: TabBarView(
          children: [
            SuratPage(),
            JuzPage(),
          ],
        ),
      ),
    );
  }
}
