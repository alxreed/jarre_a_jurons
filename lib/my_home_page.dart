import 'package:flutter/material.dart';
import 'package:jarreajurons/routing_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[700],
        body: GestureDetector(
          child: Center(
            child: Text(
              'La Jarre à Jurons',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Bratsy',
                  fontSize: 80,
                  height: 1),
              textAlign: TextAlign.center,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
//              MaterialPageRoute(builder: (context) => RoutingPage()),
              MaterialPageRoute(builder: (context) => RoutingPage()),
            );
          },
        ));
  }
}
