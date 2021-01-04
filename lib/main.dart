import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int temperature = 0;
  int woeid = 0;
  int weather;
  String location = 'Hyderabad';
  String apisite = 'https://api.openweathermap.org/data/2.5/weather?q=';
  String apikey = '&appid=5a8737d953ee376f648468efa28a0b4d';
  void fetchweather(String loc) async {
    var resp = await http.get(apisite + loc + apikey);
    var t = jsonDecode(resp.body);
    var data = t['main']['temp'];
    var temp = data - 273.16;
    var weatherdata = t['weather'][0]['id'];
    temp = temp.round();
    setState(() {
      location = loc;
      temperature = temp;
      weather = weatherdata;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/clear.jpg'), fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Center(
                        child: Text(
                      temperature.toString() + " °C",
                      style: TextStyle(fontSize: 60.0, color: Colors.white),
                    )),
                    Center(
                      child: Text(
                        location,
                        style: TextStyle(fontSize: 40.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 400.0,
                      child: Center(
                        child: TextField(
                          onSubmitted: (String input) {
                            submitted(input);
                          },
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "City, Country",
                              hintStyle: TextStyle(
                                  fontSize: 30.0, color: Colors.white),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void submitted(String input) {
    fetchweather(input);
  }
}
