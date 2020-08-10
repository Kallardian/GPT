import 'package:Gepeto/blocs/theme.dart';
import 'package:Gepeto/screensContext/myAccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Gepeto/main.dart';
import 'package:Gepeto/screensContext/criteria.dart';
import 'package:Gepeto/screensContext/classes.dart';
import 'package:provider/provider.dart';

//Routes Body
class ContextScreen extends StatefulWidget {
  @override
  _ContextScreenState createState() => _ContextScreenState();
}

class _ContextScreenState extends State<ContextScreen> {
  int indexContext = 0;
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
              ),//Data
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
                  setState(() {
                    indexContext = 0;
                  });
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: Icon(Icons.assignment, color: Colors.indigo),
                  title: Text('Critérios 2020'),
                ),//Criteria,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    indexContext = 1;
                  });
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: Icon(Icons.library_books, color: Colors.indigo),
                  title: Text('Salas'),
                ),//Classes
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyAccountFragment()
                  ));
                },
                child: ListTile(
                  leading: Icon(Icons.memory, color: Colors.indigo),//edit settings build
                  title: Text('Minha Conta'),
                ),//QuickNotes
              ),
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
          return IndexedStack(
            index: indexContext,
            children: <Widget>[
              CriteriaFragment(),
              ClassesFragment(),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(indexContext == 0) {
            setState(() {
              indexContext = 1;
            });
          } else if(indexContext == 1) {
            setState(() {
              indexContext = 0;
            });
          }
        },
        backgroundColor: Colors.indigo,
        child: IndexedStack(
          index: indexContext,
          children: <Widget>[
            Icon(Icons.library_books),
            Icon(Icons.assignment),
          ],
        ),
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
                      child: Icon(
                          Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: (){},
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: (){
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(
                        Icons.list,
                        color: Colors.black,
                      ),

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

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int indexContext = 0;
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
              ),//Data
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
                  setState(() {
                    indexContext = 1;
                  });
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: Icon(Icons.assignment, color: Colors.indigo),
                  title: Text('Critérios 2020'),
                ),//Criteria,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    indexContext = 0;
                  });
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: Icon(Icons.library_books, color: Colors.indigo),
                  title: Text('Salas'),
                ),//Classes
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyAccountFragment()
                  ));
                },
                child: ListTile(
                  leading: Icon(Icons.memory, color: Colors.indigo),//edit settings build
                  title: Text('Minha Conta'),
                ),//QuickNotes
              ),
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
          return IndexedStack(
            index: indexContext,
            children: <Widget>[
              GroupsFragment(),
              CriteriaFragment(),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(indexContext == 0) {
            setState(() {
              indexContext = 1;
            });
          } else if(indexContext == 1) {
            setState(() {
              indexContext = 0;
            });
          }
        },
        backgroundColor: Colors.indigo,
        child: IndexedStack(
          index: indexContext,
          children: <Widget>[
            Icon(Icons.library_books),
            Icon(Icons.assignment),
          ],
        ),
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

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  int indexContext = 0;
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
              ),//Data
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
                  setState(() {
                    indexContext = 1;
                  });
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: Icon(Icons.assignment, color: Colors.indigo),
                  title: Text('Critérios 2020'),
                ),//Criteria,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    indexContext = 0;
                  });
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: Icon(Icons.library_books, color: Colors.indigo),
                  title: Text('Salas'),
                ),//Classes
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyAccountFragment()
                  ));
                },
                child: ListTile(
                  leading: Icon(Icons.memory, color: Colors.indigo),//edit settings build
                  title: Text('Minha Conta'),
                ),//QuickNotes
              ),
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
          return IndexedStack(
            index: indexContext,
            children: <Widget>[
              GradeFragment(),
              CriteriaFragment(),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(indexContext == 0) {
            setState(() {
              indexContext = 1;
            });
          } else if(indexContext == 1) {
            setState(() {
              indexContext = 0;
            });
          }
        },
        backgroundColor: Colors.indigo,
        child: IndexedStack(
          index: indexContext,
          children: <Widget>[
            Icon(Icons.library_books),
            Icon(Icons.assignment),
          ],
        ),
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
