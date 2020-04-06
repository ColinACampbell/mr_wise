import 'package:flutter/material.dart';
import 'package:mr_wise/views/home.dart';

void main()
{
  runApp(App());
}

class App extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/search" : null,
      },
      title: "MR. Wise",
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        accentColor: Colors.redAccent
      ),
      home: Home(),
    );
  }
}
