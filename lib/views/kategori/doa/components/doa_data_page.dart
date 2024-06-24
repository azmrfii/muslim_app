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
        title: Text('Doa'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
      ),
      body: ListView.builder(
        itemCount: jsonData['data'].length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Judul: ${jsonData['data'][index]['judul']}',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        '${jsonData['data'][index]['arab']}',
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Artinya:\n"${jsonData['data'][index]['indo']}"',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      'Source: ${jsonData['data'][index]['source']}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
