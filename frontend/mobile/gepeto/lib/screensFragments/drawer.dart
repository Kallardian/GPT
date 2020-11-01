import 'package:Gepeto/blocs/theme.dart';
import 'package:Gepeto/screensFragments/myAccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Gepeto/main.dart';
import 'package:provider/provider.dart';


class DrawerFragment extends StatefulWidget {
  @override
  _DrawerFragmentState createState() => _DrawerFragmentState();
}

class _DrawerFragmentState extends State<DrawerFragment> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10)),
                  color: Colors.indigoAccent
              ),

              child: Center(
                child: Wrap(
                  children: <Widget>[
                    Text(
                      'Leandro eu sou o batman Cruz',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ShareTechMono',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
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