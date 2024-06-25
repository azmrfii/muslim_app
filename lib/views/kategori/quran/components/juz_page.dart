// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JuzPage extends StatefulWidget {
  const JuzPage({super.key});

  @override
  _JuzPageState createState() => _JuzPageState();
}

class _JuzPageState extends State<JuzPage> {
  List<dynamic> _listSurat = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchListJuz();
  }

  Future<void> _fetchListJuz() async {
    final response =
        await http.get(Uri.parse('https://api.myquran.com/v2/quran/juz/semua'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _listSurat = jsonData['data'];
        _isLoading = false;
      });
    } else {
      throw Exception('Error list juz');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Cari',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.all(8),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                hintStyle: TextStyle(color: Colors.black),
                suffixIcon: Icon(Icons.search),
              ),
              style: TextStyle(color: Colors.black),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _listSurat
                      .where((surat) => surat['name']
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase()))
                      .length,
                  itemBuilder: (context, index) {
                    final surat = _listSurat
                        .where((surat) => surat['name']
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                        .elementAt(index);
                    return Column(
                      children: [
                        ListTile(
                          leading: Text(
                            surat['number'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          title: Text(
                            surat['name'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            'Di Mulai di: ' + surat['name_start_id'] + ' Ayat ' + surat['verse_start'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                          indent: 16,
                          endIndent: 16,
                        ),
                      ],
                    );
                  },
                ),
        ],
      ),
    );
  }
}
