import 'package:Gepeto/api/apiConnection.dart';
import 'package:Gepeto/api/dtos.dart';
import 'package:Gepeto/blocs/theme.dart';
import 'package:Gepeto/fragments/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Gepeto/main.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

class DrawerComponent extends StatefulWidget {
  @override
  _DrawerComponentState createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = Conn().getUserById("654321");
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10)
                ),
                color: Colors.indigoAccent
              ),

              child: Center(
                child: Wrap(
                  children: <Widget>[
                    FutureBuilder<User>(
                      future: futureUser,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            convert.utf8.decode(convert.latin1.encode(snapshot.data.fullName)),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'ShareTechMono',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          textAlign: TextAlign.justify,
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        return CircularProgressIndicator();
                      }
                    ),
                    Divider(
                      color: Colors.indigo,
                    ),

                    FutureBuilder<User>(
                        future: futureUser,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.access == 3) {
                              return Text('Professor de Projetos');
                            } else if (snapshot.data.access == 4) {
                              return Text('Professor da Banca');
                            }
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }

                          return CircularProgressIndicator();
                        }
                    ),
                  ],
                ),
              ),
            ), //Data
            Divider(),

            GestureDetector(
                onTap: () {
                  if (_themeChanger.getTheme() == ThemeData.dark()) {
                    _themeChanger.setTheme(ThemeData.light());
                  } else {
                    _themeChanger.setTheme(ThemeData.dark());
                  }
                },
                child: ListTile(
                  leading: Icon(Icons.brightness_medium, color: Colors.indigo),
                  title: Text('Modo Escuro'),
                )
            ), //DarkMode
            Divider(),

            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserFragment()
                ));
              },
              child: ListTile(
                leading: Icon(Icons.memory, color: Colors.indigo),
                //edit settings build
                title: Text('Minha Conta'),
              ), //QuickNotes
            ),//MyAccount
            Divider(),

            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MainScreen()
                  ));
                },
                child: ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.red),
                  title: Text('Logout'),
                )
            ) //Logout
          ],
        )
    );
  }
}