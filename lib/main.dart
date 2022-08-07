import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController querycontroller = TextEditingController();
  getApiData(String query) async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users/$query');
    Response response = await http.get(url);
    print(response);
    print(response.statusCode);
    final data = jsonDecode(response.body);
    print(data);
    final name = data['name'];
    print(name);
  }

  @override
  void dispose() {
    querycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather Information'),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  controller: querycontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Query'),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(8.0),
                )),
                onPressed: (() {
                  getApiData(querycontroller.text);
                }),
                child: const Text('Search'),
              ),
            ],
          ),
        ));
  }
}
