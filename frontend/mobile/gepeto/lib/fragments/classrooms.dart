import 'package:Gepeto/api/dtos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/groupCriterion.dart';
import 'dart:convert' as convert;

//Classrooms Screen
class ClassroomsFragment extends StatelessWidget {
  final List<Classroom> classrooms;
  final String ra;

  ClassroomsFragment({Key key, this.classrooms, this.ra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
      itemCount: classrooms.length,
      itemBuilder: (context, index) {
        return ClassroomsContainer(classroom: classrooms[index], ra: ra,);
      }
    );
  }
}

class ClassroomsContainer extends StatelessWidget {
  final Classroom classroom;
  final String ra;

  ClassroomsContainer({Key key, this.classroom, this.ra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupCriterionScreen(ra: ra, idClassroom: classroom.idClassroom.toString())));
        },
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
                    margin: EdgeInsets.only(top: 40),
                    child: Text(
                        convert.utf8.decode(convert.latin1.encode(classroom.nameClassroom)),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ShareTechMono',
                        fontSize: 48,
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    ) ;
  }
}



