// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class AsmaulHusnaPage extends StatefulWidget {
//   @override
//   _AsmaulHusnaPageState createState() => _AsmaulHusnaPageState();
// }

// class _AsmaulHusnaPageState extends State<AsmaulHusnaPage> {
//   List<dynamic> _asmaulHusna = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchAsmaulHusna();
//   }

//   Future<void> _fetchAsmaulHusna() async {
//     final response =
//         await http.get(Uri.parse('https://api.myquran.com/v2/husna/all'));

//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       setState(() {
//         _asmaulHusna = jsonData['data'];
//         print(_asmaulHusna);
//       });
//     } else {
//       throw Exception('Failed to load Asmaul Husna');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Asmaul Husna'),
//       ),
//       body: _asmaulHusna.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _asmaulHusna.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Arab: ${_asmaulHusna[index]['arab']}',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         Text(
//                           'Indo: ${_asmaulHusna[index]['indo']}',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         Text(
//                           'Latin: ${_asmaulHusna[index]['latin']}',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

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
      });
    } else {
      throw Exception('Internal Server Error.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asmaul Husna'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: _asmaulHusna.isEmpty
            ? Center(child: CircularProgressIndicator())
            : GridView.count(
                crossAxisCount: 3,
                children: _asmaulHusna.map((asmaulHusna) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${asmaulHusna['arab']}',
                                style: TextStyle(fontSize: 18, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${asmaulHusna['latin']}',
                                style: TextStyle(fontSize: 12, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${asmaulHusna['indo']}',
                                style: TextStyle(fontSize: 10, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
