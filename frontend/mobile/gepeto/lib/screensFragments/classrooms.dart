import 'package:Gepeto/api/dtos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens.dart';
import 'dart:convert' as convert;

//Classrooms Screen
class ClassroomsFragment extends StatelessWidget {
  final List<Classroom> classrooms;

  ClassroomsFragment({Key key, this.classrooms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
      itemCount: classrooms.length,
      itemBuilder: (context, index) {
        return ClassroomsContainer(classroom: classrooms[index]);
      }
    );
  }
}

class ClassroomsContainer extends StatelessWidget {
  final Classroom classroom;

  ClassroomsContainer({Key key, this.classroom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen(idClassroom: classroom.idClassroom.toString())));
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
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                        convert.utf8.decode(convert.latin1.encode(classroom.nameClassroom)),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ShareTechMono',
                        fontSize: 32,
                      ),
                    ),
                  )
              ),
              Container(
                margin: EdgeInsets.only(left: 40, top: 9.5),
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              )
            ],
          ),
        ),
      ),
    ) ;
  }
}



