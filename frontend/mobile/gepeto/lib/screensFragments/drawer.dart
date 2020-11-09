import 'package:Gepeto/blocs/theme.dart';
import 'package:Gepeto/screensFragments/myAccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Gepeto/main.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class User {
  final String ra;
  final String fullName;
  final String password;
  final int access;

  User({this.ra, this.fullName, this.password, this.access});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      ra: json['ra'],
      fullName: json['fullName'],
      password: json['password'],
      access: json['access']
    );
  }
}

Future<User> getUserById(String ra) async {
  final response = await http.get('http://192.168.0.14:3001/api/users/' + ra);

  if (response.statusCode == 200) {
    return User.fromJson(convert.jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

class DrawerFragment extends StatefulWidget {
  @override
  _DrawerFragmentState createState() => _DrawerFragmentState();
}

class _DrawerFragmentState extends State<DrawerFragment> {
  Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = getUserById("123321");
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
                            snapshot.data.fullName,
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

                    Text('Professor da Banca')
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
                    builder: (context) => MyAccountFragment()
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