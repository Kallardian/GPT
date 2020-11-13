import 'package:Gepeto/api/dtos.dart';
import 'package:Gepeto/blocs/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Gepeto/fragments/criteria.dart';
import 'package:Gepeto/fragments/classrooms.dart';
import 'package:Gepeto/components/drawer.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<MediumCriterion>> showMediumCriteria(http.Client client) async {
  final response =
      await client.get('http://192.168.0.14:3001/api/medium-criteria/');

  return compute(parseCriteria, response.body);
}

List<MediumCriterion> parseCriteria(String responseBody) {
  final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<MediumCriterion>((json) => MediumCriterion.fromJson(json))
      .toList();
}

Future<List<Classroom>> showClassrooms(http.Client client) async {
  final response =
      await client.get('http://192.168.0.14:3001/api/classrooms/show/');

  return compute(parseClassrooms, response.body);
}

List<Classroom> parseClassrooms(String responseBody) {
  final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Classroom>((json) => Classroom.fromJson(json)).toList();
}

class CriterionClassroomScreen extends StatefulWidget {
  final String ra;

  CriterionClassroomScreen({this.ra});

  @override
  _CriterionClassroomScreenState createState() =>
      _CriterionClassroomScreenState();
}

class _CriterionClassroomScreenState extends State<CriterionClassroomScreen> {
  int indexContext = 0;

  Future _futureCriteria;
  Future _futureClassroom;

  @override
  void initState() {
    _futureCriteria = showMediumCriteria(http.Client());
    _futureClassroom = showClassrooms(http.Client());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(
      drawer: DrawerComponent(ra: widget.ra),
      body: Builder(
        builder: (BuildContext context) {
          return IndexedStack(
            index: indexContext,
            children: <Widget>[
              FutureBuilder<List<MediumCriterion>>(
                  future: _futureCriteria,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    return snapshot.hasData
                        ? CriteriaFragment(criteria: snapshot.data)
                        : Center(child: CircularProgressIndicator());
                  }),
              FutureBuilder<List<Classroom>>(
                  future: _futureClassroom,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    return snapshot.hasData
                        ? ClassroomsFragment(
                            classrooms: snapshot.data, ra: widget.ra)
                        : Center(child: CircularProgressIndicator());
                  })
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (indexContext == 0) {
            setState(() {
              indexContext = 1;
            });
          } else if (indexContext == 1) {
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
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {
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
