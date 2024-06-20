import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
          title: Text('Menu Doa'),
        ),
        body: MenuGrid(),
      ),
    );
  }
}

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3,
      children: [
        MenuTile(
            title: 'Quran',
            apiUrl: 'https://api.myquran.com/v2/doa/sumber/quran'),
        MenuTile(
            title: 'Hadits',
            apiUrl: 'https://api.myquran.com/v2/doa/sumber/hadits'),
        MenuTile(
            title: 'Pilihan',
            apiUrl: 'https://api.myquran.com/v2/doa/sumber/pilihan'),
        MenuTile(
            title: 'Harian',
            apiUrl: 'https://api.myquran.com/v2/doa/sumber/harian'),
        MenuTile(
            title: 'Ibadah',
            apiUrl: 'https://api.myquran.com/v2/doa/sumber/ibadah'),
        MenuTile(
            title: 'Haji',
            apiUrl: 'https://api.myquran.com/v2/doa/sumber/haji'),
        MenuTile(
            title: 'Lainnya',
            apiUrl: 'https://api.myquran.com/v2/doa/sumber/lainnya'),
      ],
    );
  }
}

class MenuTile extends StatelessWidget {
  final String title;
  final String apiUrl;

  const MenuTile({
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
                  builder: (context) => DataPage(jsonData: jsonData)),
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

class DataPage extends StatelessWidget {
  final dynamic jsonData;

  const DataPage({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    if (jsonData == null || jsonData['data'] == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Data Page'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Data Page'),
      ),
      body: ListView.builder(
        itemCount: jsonData['data'].length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Arab: ${jsonData['data'][index]['arab']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Indo: ${jsonData['data'][index]['indo']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Judul: ${jsonData['data'][index]['judul']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Source: ${jsonData['data'][index]['source']}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
