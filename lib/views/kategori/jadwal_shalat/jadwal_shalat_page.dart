import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JadwalShalatPage extends StatefulWidget {
  @override
  _JadwalShalatPageState createState() => _JadwalShalatPageState();
}

class _JadwalShalatPageState extends State<JadwalShalatPage> {
  Map<String, dynamic>? jadwalShalat;

  Future<void> fetchjadwalShalat() async {
    final response = await http.get(
        Uri.parse('https://api.myquran.com/v2/sholat/jadwal/1204/2024/06'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        jadwalShalat = jsonData['data'];
        print(jadwalShalat);
      });
    } else {
      throw Exception('e Jadwal Shalat');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchjadwalShalat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Shalat d bogor sementara'),
      ),
      body: jadwalShalat == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: jadwalShalat!['jadwal'].length,
              itemBuilder: (context, index) {
                final shalat = jadwalShalat!['jadwal'][index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Text(
                      shalat['tanggal'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('imsak: ${shalat['imsak']}'),
                        Text('Subuh: ${shalat['subuh']}'),
                        Text('terbit: ${shalat['terbit']}'),
                        Text('dhuha: ${shalat['dhuha']}'),
                        Text('Dzuhur: ${shalat['dzuhur']}'),
                        Text('Ashar: ${shalat['ashar']}'),
                        Text('Maghrib: ${shalat['maghrib']}'),
                        Text('Isya: ${shalat['isya']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
