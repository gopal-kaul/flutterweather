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
  int weather = 0;
  String desc = '';
  String location = 'Delhi';
  String apisite = 'https://api.openweathermap.org/data/2.5/weather?q=';
  String apikey = '&appid=5a8737d953ee376f648468efa28a0b4d';
  String iconsite = 'https://openweathermap.org/img/wn/';
  String iconloc = '';
  String colour = 'white';
  String errormsg = '';

  TextStyle tempstyle(int size) {
    return TextStyle(
        fontSize: size.toDouble(),
        color: (colour == 'white') ? Colors.white : Colors.black);
  }

  @override
  void initState() {
    super.initState();
    fetchweather(location);
  }

  Future fetchweather(String loc) async {
    try {
      var resp = await http.get(apisite + loc + apikey);
      var t = jsonDecode(resp.body);
      var data = t['main']['temp'];
      var temp = data - 273.16;
      var weatherdata = t['weather'][0]['id'];
      var icon = t['weather'][0]['icon'];
      var weatherdesc = t['weather'][0]['description'];
      temp = temp.round();
      setState(() {
        location = loc;
        temperature = temp;
        weather = weatherdata;
        iconloc = iconsite + icon.toString() + '@4x.png';
        desc = weatherdesc;
        errormsg = '';
      });
    } catch (e) {
      setState(() {
        errormsg = "You have entered an incorrect location! Please retry!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(weatherlink(weather)), fit: BoxFit.cover)),
          child: temperature == 0
              ? Center(child: CircularProgressIndicator())
              : Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          if (iconloc != '')
                            Center(
                              child: Image(
                                image: NetworkImage(iconloc),
                              ),
                            ),
                          Center(
                              child: Text(
                            temperature.toString() + " °C",
                            style: tempstyle(50),
                          )),
                          Center(
                            child: Text(
                              location,
                              style: tempstyle(40),
                            ),
                          ),
                          if (desc != '')
                            Center(
                              child: Text(
                                capitalize(desc.toString()),
                                style: tempstyle(40),
                              ),
                            )
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
                                style: tempstyle(30),
                                decoration: InputDecoration(
                                    hintText: "City, Country",
                                    hintStyle: tempstyle(30),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: (colour == 'white')
                                          ? Colors.white
                                          : Colors.black,
                                    )),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              errormsg,
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.red),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
        ));
  }

  void submitted(String input) async {
    await fetchweather(input);
  }

  String weatherlink(int weatherid) {
    if (weatherid == 0) {
      if (colour != 'white') setcolour('white');
      return "assets/images/clear.jpg";
    } else if (weatherid >= 200 && weatherid < 300) {
      if (colour != 'white') setcolour('white');
      return "assets/images/thunder.jpg";
    } else if (weatherid >= 300 && weatherid < 400) {
      if (colour != 'white') setcolour('white');
      return "assets/images/drizzle.jpg";
    } else if (weatherid >= 500 && weatherid < 600) {
      if (colour != 'white') setcolour('white');
      return "assets/images/rain.jpg";
    } else if (weatherid >= 600 && weatherid < 700) {
      if (colour != 'black') setcolour('black');
      return "/assetsimages/snow.jpg";
    } else if (weatherid >= 800 && weatherid < 900) {
      if (colour != 'white') setcolour('white');
      return "assets/images/cloudy.jpg";
    } else {
      if (colour != 'white') setcolour('white');
      return 'assets/images/clear.jpg';
    }
  }

  void setcolour(String color) {
    setState(() {
      colour = color;
    });
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
