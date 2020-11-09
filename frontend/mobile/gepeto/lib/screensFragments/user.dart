import 'package:Gepeto/blocs/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Gepeto/main.dart';
import 'package:provider/provider.dart';

//Criteria Screen
class MyAccountFragment extends StatefulWidget {
  @override
  _MyAccountFragmentState createState() => _MyAccountFragmentState();
}

class _MyAccountFragmentState extends State<MyAccountFragment> {

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(

      drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
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
              ),//Account
              Divider(),
              GestureDetector(
                  onTap: () {
                    if (_themeChanger.getTheme() == ThemeData.dark()){
                      _themeChanger.setTheme(ThemeData.light());
                    } else {
                      _themeChanger.setTheme(ThemeData.dark());
                    }
                  },
                  child: ListTile(
                    leading: Icon(Icons.brightness_medium, color: Colors.indigo),
                    title: Text('Modo Escuro'),
                  )
              ),//DarkMode
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: Icon(Icons.assignment, color: Colors.indigo),
                  title: Text('Voltar'),
                ),
              ),//Criteria
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: Icon(Icons.memory, color: Colors.indigo),//edit settings build
                  title: Text('Minha Conta'),
                ),
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
              )//Logout
            ],
          )
      ),

      body: Builder(
        builder: (BuildContext context) {
          return AccountFragment();
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
                      Navigator.of(context).pop();
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