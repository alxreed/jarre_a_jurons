import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.purple[700],
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('assets/alex.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Alexandre',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Bratsy',
                              fontSize: 40,
                              height: 1.3),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Vous devez',
                          style: TextStyle(
                              color: Colors.yellow[800],
                              fontFamily: 'Bratsy',
                              fontSize: 70,
                              height: 1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          '10 €',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Bratsy',
                              fontSize: 120,
                              height: 1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          'à Héléna',
                          style: TextStyle(
                              color: Colors.yellow[800],
                              fontFamily: 'Bratsy',
                              fontSize: 70,
                              height: 0.5),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    print("rends l'argent");
                    _showDialog();
                  },
                  label: Text('Payer'),
                )
              ],
            )));
  }

  void _showDialog() {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        content: Text('Aucun moyen de paiement connecté'),
        actions: <Widget>[
          FlatButton(
            child: Text('OK BB'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
