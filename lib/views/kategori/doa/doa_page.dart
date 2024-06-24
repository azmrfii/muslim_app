import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:muslim_app/views/kategori/doa/components/doa_data_page.dart';

class DoaPage extends StatefulWidget {
  const DoaPage({super.key});

  @override
  _DoaPageState createState() => _DoaPageState();
}

class _DoaPageState extends State<DoaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doa'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: [
          DoaTile(
              title: 'Quran',
              apiUrl: 'https://api.myquran.com/v2/doa/sumber/quran'),
          DoaTile(
              title: 'Hadits',
              apiUrl: 'https://api.myquran.com/v2/doa/sumber/hadits'),
          DoaTile(
              title: 'Pilihan',
              apiUrl: 'https://api.myquran.com/v2/doa/sumber/pilihan'),
          DoaTile(
              title: 'Harian',
              apiUrl: 'https://api.myquran.com/v2/doa/sumber/harian'),
          DoaTile(
              title: 'Ibadah',
              apiUrl: 'https://api.myquran.com/v2/doa/sumber/ibadah'),
          DoaTile(
              title: 'Haji',
              apiUrl: 'https://api.myquran.com/v2/doa/sumber/haji'),
          DoaTile(
              title: 'Lainnya',
              apiUrl: 'https://api.myquran.com/v2/doa/sumber/lainnya'),
        ],
      ),
    );
  }
}

class DoaTile extends StatefulWidget {
  final String title;
  final String apiUrl;

  const DoaTile({
    super.key,
    required this.title,
    required this.apiUrl,
  });

  @override
  _DoaTileState createState() => _DoaTileState();
}

class _DoaTileState extends State<DoaTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () async {
          final response = await http.get(Uri.parse(widget.apiUrl));
          if (response.statusCode == 200) {
            final jsonData = jsonDecode(response.body);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DoaDataPage(jsonData: jsonData)),
            );
          } else {
            print('Error: ${response.statusCode}');
          }
        },
        child: Center(
          child: Text(widget.title),
        ),
      ),
    );
  }
}
