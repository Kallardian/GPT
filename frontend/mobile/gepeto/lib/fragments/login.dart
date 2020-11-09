import 'dart:convert';

import 'package:Gepeto/api/dtos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Gepeto/screens.dart';
import 'package:http/http.dart' as http;

Future<int> loginUser(User user) async {
  final http.Response response = await http.post(
    'http://192.168.0.14:3001/api/users/login',
    headers: <String, String> {
      'Content-Type' : 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic> {
      "ra" : user.ra,
      "password" : user.password
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to Login');
  }
}

class LoginFragment extends StatelessWidget {
  LoginFragment({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Image.asset(
            "assets/image/logo.png"
          ),
          Container(
            margin: EdgeInsets.only(top: 0, bottom: 10),
            height: 100,
            child: Center(
              child: Text(
                'Preencha os campos para\nefetuar o Login',
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: Colors.indigo,
                  fontFamily: 'ShareTechMono',
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 70.0),
            margin: EdgeInsets.only(bottom: 10),
            child: Center(
              child: TextFormField(
                maxLength: 6,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Entre com seu RA'
                ),
                validator: (String value) {
                  return value.isEmpty ? 'Preencha o campo com seu RA.' : null;
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 70.0),
            child: Center(
              child: TextField(
                  obscureText: true,
                  maxLength: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Digite sua senha',
                  )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 120.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.indigoAccent,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ContextScreen()
                      ));
                    },
                    child: Text(
                      'Login',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ShareTechMono',
                      ),
                    ),
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}
