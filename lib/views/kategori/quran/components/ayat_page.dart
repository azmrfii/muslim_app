// AyatPage.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AyatPage extends StatefulWidget {
  final int suratNumber;
  final String namaSurat;
  final int panjangAyat;

  const AyatPage({
    super.key,
    required this.suratNumber,
    required this.panjangAyat,
    required this.namaSurat,
  });

  @override
  _AyatPageState createState() => _AyatPageState();
}

class _AyatPageState extends State<AyatPage> {
  List<dynamic> _ayatList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAyatList();
  }

  Future<void> _fetchAyatList() async {
    final response = await http.get(Uri.parse(
        'https://api.myquran.com/v2/quran/ayat/${widget.suratNumber}/1/${widget.panjangAyat}'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _ayatList = jsonData['data'];
        _isLoading = false;
      });
    } else {
      throw Exception('Error ayat list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surat ${widget.namaSurat}'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _ayatList.length,
              itemBuilder: (context, index) {
                final ayat = _ayatList[index];
                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ayat['ayah'],
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            ayat['arab'],
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Text(
                        ayat['latin'],
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        ayat['text'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
