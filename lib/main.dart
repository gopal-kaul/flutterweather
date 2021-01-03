import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  int temperature = 0;
  String location = 'Hyderabad';
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
                      width: 300.0,
                      child: Center(
                        child: TextField(
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
}
