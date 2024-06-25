// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors, prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:muslim_app/views/entrypoint/components/custom_button_app_navigation.dart';
import 'package:muslim_app/views/home/home_page.dart';
import 'package:muslim_app/views/kategori/jadwal_shalat/jadwal_shalat_page.dart';
import 'package:muslim_app/views/kategori/kiblat/kiblat_page.dart';

class EntryPointNav extends StatefulWidget {
  const EntryPointNav({Key? key}) : super(key: key);

  @override
  State<EntryPointNav> createState() => _EntryPointNavState();
}

class _EntryPointNavState extends State<EntryPointNav> {
  @override
  void initState() {
    super.initState();
  }
  int _selectedIndex = 0;

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          [
            HomePage(),
            JadwalShalatPage(),
            // KiblatCompassPage(),
            HomePage(),
            HomePage(),
          ][_selectedIndex],
          BottomGradientWidget(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          onItemTapped: _onItemTapped, selectedIndex: _selectedIndex),
    );
  }
}

class BottomGradientWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          // Color(0xFF107873).withOpacity(0.2),
          // Color(0xFF107873).withOpacity(0)
          Color.fromARGB(255, 92, 131, 116).withOpacity(0.2),
          Color.fromARGB(255, 147, 177, 166).withOpacity(0),
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
      ),
    );
  }
}
