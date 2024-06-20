import 'package:flutter/material.dart';

class DoaDataPage extends StatelessWidget {
  final dynamic jsonData;

  const DoaDataPage({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    if (jsonData == null || jsonData['data'] == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Doa Data Page'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Doa Data Page'),
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
