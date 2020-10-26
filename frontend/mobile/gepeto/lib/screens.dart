import 'package:Gepeto/blocs/theme.dart';
import 'package:Gepeto/screensFragments/myAccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Gepeto/main.dart';
import 'package:Gepeto/screensFragments/criteria.dart';
import 'package:Gepeto/screensFragments/classrooms.dart';
import 'package:Gepeto/screensFragments/groups.dart';
import 'package:Gepeto/screensFragments/grades.dart';
import 'package:Gepeto/screensFragments/drawer.dart';
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

      drawer: DrawerFragment(),

      body: Builder(
        builder: (BuildContext context) {
          return IndexedStack(
            index: indexContext,
            children: <Widget>[
              CriteriaFragment(),
              ClassroomsFragment(),
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

      drawer: DrawerFragment(),

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

      drawer: DrawerFragment(),

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
