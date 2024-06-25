import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AyatJuzPage extends StatefulWidget {
  final int juzNumber;

  const AyatJuzPage({
    super.key,
    required this.juzNumber,
  });

  @override
  _AyatPageState createState() => _AyatPageState();
}

class _AyatPageState extends State<AyatJuzPage> {
  List<dynamic> _ayatList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAyatList();
  }

  Future<void> _fetchAyatList() async {
    final response = await http.get(Uri.parse(
        'https://api.myquran.com/v2/quran/ayat/juz/${widget.juzNumber}'));
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
        title: Text('Juz ${widget.juzNumber}'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _ayatList.length,
              itemBuilder: (context, index) {
                final ayat = _ayatList[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          ayat['ayah'],
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          ayat['arab'],
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          ayat['latin'],
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          ayat['text'],
                          style: TextStyle(fontSize: 16),
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
