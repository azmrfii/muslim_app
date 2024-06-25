// // ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class SuratPage extends StatefulWidget {
//   const SuratPage({super.key});

//   @override
//   _SuratPageState createState() => _SuratPageState();
// }

// class _SuratPageState extends State<SuratPage> {
//   List<dynamic> _listSurat = [];
//   bool _isLoading = true;
//   String _searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     _fetchListSurat();
//   }

//   Future<void> _fetchListSurat() async {
//     final response = await http
//         .get(Uri.parse('https://api.myquran.com/v2/quran/surat/semua'));
//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       setState(() {
//         _listSurat = jsonData['data'];
//         _isLoading = false;
//       });
//     } else {
//       throw Exception('Error list surat');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding:
//                 const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelText: 'Cari',
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding: EdgeInsets.all(8),
//                 filled: true,
//                 fillColor: Colors.grey.withOpacity(0.2),
//                 hintStyle: TextStyle(color: Colors.black),
//                 suffixIcon: Icon(Icons.search),
//               ),
//               style: TextStyle(color: Colors.black),
//               onChanged: (query) {
//                 setState(() {
//                   _searchQuery = query;
//                 });
//               },
//             ),
//           ),
//           _isLoading
//               ? Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: _listSurat
//                       .where((surat) =>
//                           surat['name_id']
//                               .toLowerCase()
//                               .contains(_searchQuery.toLowerCase()) ||
//                           surat['translation_id']
//                               .toLowerCase()
//                               .contains(_searchQuery.toLowerCase()))
//                       .length,
//                   itemBuilder: (context, index) {
//                     final surat = _listSurat
//                         .where((surat) =>
//                             surat['name_id']
//                                 .toLowerCase()
//                                 .contains(_searchQuery.toLowerCase()) ||
//                             surat['translation_id']
//                                 .toLowerCase()
//                                 .contains(_searchQuery.toLowerCase()))
//                         .elementAt(index);
//                     return Column(
//                       children: [
//                         ListTile(
//                           leading: Text(
//                             surat['number'],
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.black54,
//                             ),
//                           ),
//                           title: Text(
//                             surat['name_id'],
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                             ),
//                           ),
//                           subtitle: Text(
//                             surat['translation_id'] +
//                                 '(' +
//                                 surat['number_of_verses'] +
//                                 'ayat)',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.black54,
//                             ),
//                           ),
//                           trailing: Text(
//                             surat['name_short'],
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         Divider(
//                           thickness: 1,
//                           color: Colors.grey,
//                           indent: 16,
//                           endIndent: 16,
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

// SuratPage.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:muslim_app/views/kategori/quran/components/ayat_page.dart';

class SuratPage extends StatefulWidget {
  const SuratPage({super.key});

  @override
  _SuratPageState createState() => _SuratPageState();
}

class _SuratPageState extends State<SuratPage> {
  List<dynamic> _listSurat = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchListSurat();
  }

  Future<void> _fetchListSurat() async {
    final response = await http
        .get(Uri.parse('https://api.myquran.com/v2/quran/surat/semua'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _listSurat = jsonData['data'];
        _isLoading = false;
      });
    } else {
      throw Exception('Error list surat');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 15, bottom: 15),
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
                        .where((surat) =>
                            surat['name_id']
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()) ||
                            surat['translation_id']
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()))
                        .length,
                    itemBuilder: (context, index) {
                      final surat = _listSurat
                          .where((surat) =>
                              surat['name_id']
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()) ||
                              surat['translation_id']
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()))
                          .elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AyatPage(
                                suratNumber: int.parse(surat['number']),
                                namaSurat: surat['name_id'],
                                panjangAyat: int.parse(surat['number_of_verses']),
                              ),
                            ),
                          );
                        },
                        child: Column(
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
                                surat['name_id'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                surat['translation_id'] +
                                    '(' +
                                    surat['number_of_verses'] +
                                    'ayat)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              trailing: Text(
                                surat['name_short'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
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
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
