// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim_app/views/entrypoint/entrypoint_nav.dart';
import 'package:muslim_app/views/kategori/asmaul_husna/asmaul_husna_page.dart';
import 'package:muslim_app/views/kategori/doa/doa_page.dart';
import 'package:muslim_app/views/kategori/hadits/hadits_page.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CategoryBox(
            svgAsset: 'assets/icons/quran.svg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EntryPointNav()),
              );
            },
          ),
          CategoryBox(
            svgAsset: 'assets/icons/asmaul_husna.svg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AsmaulHusnaPage()),
              );
            },
          ),
          CategoryBox(
            svgAsset: 'assets/icons/doa.svg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoaPage()),
              );
            },
          ),
          CategoryBox(
            svgAsset: 'assets/icons/more.svg',
            onPressed: () {
              // TODO: implement Quran page
              _showBottomSheet(context);
            },
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CategoryBox(
              svgAsset: 'assets/icons/quran.svg',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EntryPointNav()),
                );
              },
            ),
            CategoryBox(
              svgAsset: 'assets/icons/asmaul_husna.svg',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AsmaulHusnaPage()),
                );
              },
            ),
            CategoryBox(
              svgAsset: 'assets/icons/doa.svg',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoaPage()),
                );
              },
            ),
            CategoryBox(
              svgAsset: 'assets/icons/hadith.svg',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HaditsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
  final String svgAsset;
  final VoidCallback onPressed;

  CategoryBox({required this.svgAsset, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 92, 131, 116).withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 7,
              offset: Offset(0, 6),
            ),
            BoxShadow(
              color: Color.fromARGB(255, 147, 177, 166).withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 7,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              svgAsset,
              color: Color.fromARGB(255, 92, 131, 116),
              width: 30,
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
