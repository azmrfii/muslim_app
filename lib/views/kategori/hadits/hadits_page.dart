
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:muslim_app/views/kategori/hadits/components/hadits_data_page.dart';

class HaditsPage extends StatelessWidget {
  const HaditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3,
      children: [
        HaditsTile(
            title: 'Hadits Arbain',
            apiUrl: 'https://api.myquran.com/v2/hadits/arbain/semua'),
        HaditsTile(
            title: 'Bulughul Maram',
            apiUrl: 'https://api.myquran.com/v2/hadits/arbain/semua'),
        HaditsTile(
            title: 'Hadits 9 Perawi',
            apiUrl: 'https://api.myquran.com/v2/hadits/arbain/semua'),
      ],
    );
  }
}

class HaditsTile extends StatelessWidget {
  final String title;
  final String apiUrl;

  const HaditsTile({
    super.key,
    required this.title,
    required this.apiUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () async {
          final response = await http.get(Uri.parse(apiUrl));
          if (response.statusCode == 200) {
            final jsonData = jsonDecode(response.body);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HaditsDataPage(jsonData: jsonData)),
            );
          } else {
            print('Error: ${response.statusCode}');
          }
        },
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
