import 'package:Gepeto/api/dtos.dart';
import 'package:Gepeto/blocs/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Gepeto/fragments/criteria.dart';
import 'package:Gepeto/fragments/classrooms.dart';
import 'package:Gepeto/fragments/groups.dart';
import 'package:Gepeto/fragments/grades.dart';
import 'package:Gepeto/components/drawer.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

//Criterion
Future<List<MediumCriterion>> showMediumCriteria(http.Client client) async {
  final response = await client.get('http://192.168.0.14:3001/api/medium-criteria/');

  return compute(parseCriteria, response.body);
}

List<MediumCriterion> parseCriteria(String responseBody) {
  final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<MediumCriterion>((json) => MediumCriterion.fromJson(json)).toList();
}

//Classroom
Future<List<Classroom>> showClassrooms(http.Client client) async {
  final response = await client.get('http://192.168.0.14:3001/api/classrooms/show/');

  return compute(parseClassrooms, response.body);
}

List<Classroom> parseClassrooms(String responseBody) {
  final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Classroom>((json) => Classroom.fromJson(json)).toList();
}

//Group
Future<List<Group>> showGroups(http.Client client, String idClassroom) async {
  final response = await client.get('http://192.168.0.14:3001/api/groups/show/' + idClassroom);

  return compute(parseGroups, response.body);
}

List<Group> parseGroups(String responseBody) {
  final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Group>((json) => Group.fromJson(json)).toList();
}

//Routes Body
class ContextScreen extends StatefulWidget {
  final int access;

  ContextScreen({this.access});

  @override
  void 

  @override
  _ContextScreenState createState() => _ContextScreenState();
}

class _ContextScreenState extends State<ContextScreen> {
  int indexContext = 0;
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(

      drawer: DrawerComponent(),

      body: Builder(
        builder: (BuildContext context) {
          return IndexedStack(
            index: indexContext,
            children: <Widget>[
              FutureBuilder<List<MediumCriterion>>(
                future: showMediumCriteria(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  return snapshot.hasData
                    ? CriteriaFragment(criteria: snapshot.data)
                    : Center(child: CircularProgressIndicator());
                }
              ),
              FutureBuilder<List<Classroom>> (
                future: showClassrooms(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  return snapshot.hasData
                    ? ClassroomsFragment(classrooms: snapshot.data)
                    : Center(child: CircularProgressIndicator());
                }
              )
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
  final String idClassroom;

  SecondScreen({Key key, this.idClassroom}) : super (key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState(idClassroom: idClassroom);
}

class _SecondScreenState extends State<SecondScreen> {
  int indexContext = 0;
  final String idClassroom;

  _SecondScreenState({this.idClassroom});

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(

      drawer: DrawerComponent(),

      body: Builder(
        builder: (BuildContext context) {
          return IndexedStack(
            index: indexContext,
            children: <Widget>[
              FutureBuilder<List<Group>>(
                future: showGroups(http.Client(), idClassroom),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  return snapshot.hasData
                    ? GroupsFragment(groups: snapshot.data)
                    : Center(child: CircularProgressIndicator());
                }
              ),
              FutureBuilder<List<MediumCriterion>>(
                future: showMediumCriteria(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  return snapshot.hasData
                      ? CriteriaFragment(criteria: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                }
              ),
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

      drawer: DrawerComponent(),

      body: Builder(
        builder: (BuildContext context) {
          return IndexedStack(
            index: indexContext,
            children: <Widget>[
              GradeFragment(),
              FutureBuilder<List<MediumCriterion>>(
                  future: showMediumCriteria(http.Client()),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    return snapshot.hasData
                        ? CriteriaFragment(criteria: snapshot.data)
                        : Center(child: CircularProgressIndicator());
                  }
              ),
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
