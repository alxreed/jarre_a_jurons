import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarreajurons/model/friend.dart';
import 'package:jarreajurons/model/user.dart';
import 'package:jarreajurons/services/friend_service.dart';

class MyFriendPage extends StatefulWidget {
  MyFriendPage({Key key, this.title, this.friend, this.user}) : super(key: key);

  final String title;
  final Friend friend;
  final User user;

  @override
  _MyFriendPageState createState() => _MyFriendPageState();
}

class _MyFriendPageState extends State<MyFriendPage> {
  int _moneyEarned;

  void _increaseMoneyEarned() {
    if (_moneyEarned >= 0) {
      _moneyEarned ++;
      friendService.updateMoneyEarned(widget.user, widget.friend, _moneyEarned);
    }
  }

  void _decreaseMoneyEarned() {
      if (_moneyEarned > 0) {
        _moneyEarned--;
        friendService.updateMoneyEarned(widget.user, widget.friend, _moneyEarned);
      }
  }

  void _restartCounter() {
      _moneyEarned = 0;
      friendService.updateMoneyEarned(widget.user, widget.friend, _moneyEarned);
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
    return StreamBuilder(
      builder: (BuildContext context, snapshot) {
        _moneyEarned = widget.friend.moneyEarned;
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
                                      image:
                                          NetworkImage(widget.friend.photoUrl),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Center(
                            child: Text(
                              widget.friend.name,
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
                                  backgroundColor: Colors.white,
                                  onPressed: _decreaseMoneyEarned,
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.purple[700],
                                  )),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: FittedBox(
                              child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                onPressed: _showDialog,
                                child: Icon(
                                  Icons.refresh,
                                  color: Colors.purple[700],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 70,
                            child: FittedBox(
                                child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: _increaseMoneyEarned,
                              child: Icon(
                                Icons.add,
                                color: Colors.purple[700],
                              ),
                            )),
                          ),
                        ],
                      ),
                    )
                  ],
                )));
      },
    );
  }
}
