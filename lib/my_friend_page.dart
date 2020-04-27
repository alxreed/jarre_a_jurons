import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFriendPage extends StatefulWidget {
  MyFriendPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyFriendPageState createState() => _MyFriendPageState();
}

class _MyFriendPageState extends State<MyFriendPage> {
  int _moneyEarned = 0;

  void _increaseMoneyEarned() {
    setState(() {
      _moneyEarned++;
    });
  }

  void _decreaseMoneyEarned() {
    setState(() {
      _moneyEarned--;
    });
  }

  void _restartCounter() {
    setState(() {
      _moneyEarned = 0;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content:
                Text('Es-tu sur de vouloir remettre les compteurs à zéro ?'),
            actions: <Widget>[
              FlatButton(
                child: Text('NIQUE TA MERE'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('DE OUF'),
                onPressed: () {
                  _restartCounter();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

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
                                  image: AssetImage('assets/helena.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Héléna',
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
                          'Vous doit',
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
                          '$_moneyEarned €',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Bratsy',
                              fontSize: 120,
                              height: 1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 70,
                        width: 70,
                        child: FittedBox(
                          child: FloatingActionButton(
                              onPressed: _decreaseMoneyEarned,
                              child: Icon(Icons.remove)),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        child: FittedBox(
                          child: FloatingActionButton(
                            onPressed: _showDialog,
                            child: Icon(Icons.refresh),
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        child: FittedBox(
                            child: FloatingActionButton(
                          onPressed: _increaseMoneyEarned,
                          child: Icon(Icons.add),
                        )),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
