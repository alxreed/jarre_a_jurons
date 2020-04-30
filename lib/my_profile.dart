import 'package:flutter/material.dart';
import 'package:jarreajurons/services/auth_service.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  int _moneyEarnedBy = 10;
  Map<String, dynamic> _profile;
  bool _loading = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.purple[700],
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      child: FittedBox(
                        child: FlatButton(
                            onPressed: null,
                            child: Icon(Icons.drafts, color: Colors.white, size: 60,)),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      child: FittedBox(
                          child: FlatButton(
                            onPressed: () => authService.signOut(),
                            child: Icon(Icons.power_settings_new, color: Colors.white, size: 60,),
                          )),
                    ),
                  ],
                ),
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
                      if (_moneyEarnedBy != 0) ...[
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
                            '$_moneyEarnedBy €',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Bratsy',
                                fontSize: 120,
                                height: 1),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      if ( _moneyEarnedBy == 0)
                        Center(
                          child: Text(
                            'Vous ne devez rien',
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
                          'à Héléna',
                          style: TextStyle(
                              color: Colors.yellow[800],
                              fontFamily: 'Bratsy',
                              fontSize: 70,
                              height: _moneyEarnedBy != 0 ? 0.5 : 1.2),
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
                ),
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
