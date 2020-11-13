import 'package:Gepeto/api/dtos.dart';
import 'package:Gepeto/screens/criterionClassroom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:vibration/vibration.dart';

import '../main.dart';

//Grade Screen

class GradeFragment extends StatelessWidget {
  final List<MediumCriterion> criteria;
  final String ra;

  GradeFragment({Key key, this.criteria, this.ra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
        itemCount: criteria.length,
        itemBuilder: (context, index) {
          return GradesContainer(criterion: criteria[index], ra: ra,);
        }
    );
  }
}

class GradesContainer extends StatelessWidget {
  final TextEditingController _controllerGrade = TextEditingController();
  final MediumCriterion criterion;
  final String ra;

  GradesContainer({this.criterion, this.ra});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    convert.utf8
                        .decode(convert.latin1
                        .encode(criterion.nameMedium)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ShareTechMono',
                      fontSize: 16,
                    ),
                  ),
                )
              ),
              Center(
                child: ListTile(
                  title: Text("Valor total:"),
                  subtitle: Text(criterion.totalValue.toString()),
                ),
              )
            ],
          ),
        ),
        onDoubleTap: () {
          Vibration();
          showDialog(
            context: context,
            child: CupertinoAlertDialog(
              title: Text(convert.utf8
                  .decode(convert.latin1
                  .encode(criterion.nameMedium))),
              content: TextField(
                  controller: _controllerGrade,
                  maxLength: 2,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Nota',
                  )
              ),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MainScreen())
                      );
                    },
                    child: Text("Salvar"))
              ],
            ),
          );
        },
      ),
    );
  }
}
