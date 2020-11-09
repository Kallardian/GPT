import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerEmpty extends StatelessWidget {
  DrawerEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'Por questões de segurança\nFaça o login antes de navegar\npelo App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.indigoAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}