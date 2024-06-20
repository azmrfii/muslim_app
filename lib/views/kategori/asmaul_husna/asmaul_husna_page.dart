import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AsmaulHusnaPage extends StatefulWidget {
  @override
  _AsmaulHusnaPageState createState() => _AsmaulHusnaPageState();
}

class _AsmaulHusnaPageState extends State<AsmaulHusnaPage> {
  List<dynamic> _asmaulHusna = [];

  @override
  void initState() {
    super.initState();
    _fetchAsmaulHusna();
  }

  Future<void> _fetchAsmaulHusna() async {
    final response =
        await http.get(Uri.parse('https://api.myquran.com/v2/husna/all'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _asmaulHusna = jsonData['data'];
        print(_asmaulHusna);
      });
    } else {
      throw Exception('Failed to load Asmaul Husna');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asmaul Husna'),
      ),
      body: _asmaulHusna.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _asmaulHusna.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${_asmaulHusna[index]['arab']}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Arabic: ${_asmaulHusna[index]['indo']}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Translation: ${_asmaulHusna[index]['latin']}',
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
