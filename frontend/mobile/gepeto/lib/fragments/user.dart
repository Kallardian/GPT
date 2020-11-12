import 'dart:convert';

import 'package:Gepeto/api/apiConnection.dart';
import 'package:Gepeto/api/dtos.dart';
import 'package:Gepeto/blocs/theme.dart';
import 'package:Gepeto/components/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

Future updateUserPassword(String ra, String password) async {
  final http.Response response = await http.post(
    'http://192.168.0.14:3001/api/users/password',
    headers: <String, String> {
      'Content-Type' : 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic> {
      "ra" : ra,
      "password" : password
    }),
  );
}

class UserFragment extends StatefulWidget {
  final String ra;

  UserFragment({this.ra});

  @override
  _UserFragmentState createState() => _UserFragmentState();
}

class _UserFragmentState extends State<UserFragment> {

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(

      drawer: DrawerComponent(ra: widget.ra),

      body: Builder(
        builder: (BuildContext context) {
          return AccountFragment(ra: widget.ra);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.indigo,
        child: Icon(Icons.assignment)
      ),

      bottomNavigationBar: Builder(
        builder: (BuildContext context) {
          return BottomAppBar(
            color: Colors.indigoAccent,
            notchMargin: kFloatingActionButtonMargin,
            child: Container(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 180),
                    child: FlatButton(
                      child: Icon(Icons.arrow_back),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: (){
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(Icons.list),

                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class AccountFragment extends StatelessWidget {
  final String ra;
  final TextEditingController _controllerOldPassword = TextEditingController();
  final TextEditingController _controllerNewPassword1 = TextEditingController();
  final TextEditingController _controllerNewPassword2 = TextEditingController();

  AccountFragment({this.ra});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.only(top: 60),
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 70.0),
            child: Center(
              child: TextField(
                controller: _controllerOldPassword,
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
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 70.0),
            child: Center(
              child: TextField(
                controller: _controllerNewPassword1,
                obscureText: true,
                maxLength: 20,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' Digite sua nova senha',
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 70.0),
            child: Center(
              child: TextField(
                controller: _controllerNewPassword2,
                obscureText: true,
                maxLength: 20,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' Confirme sua senha',
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
                    onPressed: (){
                      return showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text("Mudar Senha do Usuário"),
                          content: Text("Você tem certeza de que quer mudar sua senha?"),
                          actions: [
                            CupertinoDialogAction(
                              child: GestureDetector(
                                child: Text("Sim"),
                                onTap: () {
                                  User user;


                                },
                              )
                            ),
                            CupertinoDialogAction(
                              child: GestureDetector(
                                child: Container(
                                  child: Text("Não"),
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            )
                          ],
                        ),
                      );
                    },
                    child: Text(
                      'Salvar',
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