import 'dart:ffi';

import 'package:Gepeto/api/apiConnection.dart';
import 'package:Gepeto/api/dtos.dart';
import 'package:Gepeto/screens/criterionClassroom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:vibration/vibration.dart';

import '../main.dart';

//Grade Screen

class GradeFragment extends StatefulWidget {
  final List<MediumCriterion> criteria;
  final String ra;
  final int groupId;

  GradeFragment({Key key, this.criteria, this.ra, this.groupId}) : super(key: key);

  @override
  _GradeFragmentState createState() => _GradeFragmentState();
}

class _GradeFragmentState extends State<GradeFragment> {
  Future _futureAttempt;

  @override
  void initState() {
    _futureAttempt = Conn().getBiggestAttempt(widget.groupId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureAttempt,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return snapshot.hasData
              ? ListView.builder(
                padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
                itemCount: widget.criteria.length,
                itemBuilder: (context, index) {
                  return GradesContainer(
                    criterion: widget.criteria[index],
                    ra: widget.ra,
                    groupId: widget.groupId,
                    attempt: snapshot.data + 1
                  );
                },
              )
              : Center(child: CircularProgressIndicator());
      }
    );
  }
}

class GradesContainer extends StatelessWidget {
  final MediumCriterion criterion;
  final String ra;
  final int groupId;
  final int attempt;

  GradesContainer({this.criterion, this.ra, this.groupId, this.attempt});

  final TextEditingController _controllerGrade = TextEditingController();
  final List<MediumGrade> gradesList = List<MediumGrade>();

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
                  margin: EdgeInsets.only(top: 15),
                  height: 40,
                  child: Text(
                    convert.utf8
                        .decode(convert.latin1
                        .encode(criterion.nameMedium)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ShareTechMono',
                      fontSize: 24,
                    ),
                  ),
                )
              ),
              Container(
                child: ListTile(

                  title: Text(
                    "Valor total:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontFamily: 'ShareTechMono',
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                    criterion.totalValue.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontFamily: 'ShareTechMono',
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
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
              content: CupertinoTextField(
                  controller: _controllerGrade,
                  cursorRadius: Radius.circular(4),
                  maxLength: 2,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.indigo
                    )
                  )
              ),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      MediumGrade grade = MediumGrade(
                        idMediumGrade: criterion.idMedium,
                        grade: double.parse(_controllerGrade.text),
                        idMedium: criterion.idMedium,
                        ra: ra,
                        idGroup: groupId,
                        attempt: attempt
                      );

                      Conn().postListOfMediumGrades(grade);

                      Navigator.of(context).pop();
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
