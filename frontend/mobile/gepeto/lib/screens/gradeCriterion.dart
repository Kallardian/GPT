import 'package:Gepeto/api/dtos.dart';
import 'package:Gepeto/blocs/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Gepeto/fragments/criteria.dart';
import 'package:Gepeto/fragments/grades.dart';
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

class GradeCriterionScreen extends StatefulWidget {
  final String ra;
  final int groupId;

  GradeCriterionScreen({this.ra, this.groupId});

  @override
  _GradeCriterionScreenState createState() => _GradeCriterionScreenState();
}

class _GradeCriterionScreenState extends State<GradeCriterionScreen> {
  int indexContext = 0;

  Future _futureCriteria;

  @override
  void initState() {
    _futureCriteria = showMediumCriteria(http.Client());
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
                      ? GradeFragment(criteria: snapshot.data,)
                      : Center(child: CircularProgressIndicator());
                }),

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
                      child: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {
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
