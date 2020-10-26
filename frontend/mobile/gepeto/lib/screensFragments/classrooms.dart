import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens.dart';

//Classrooms Screen
class ClassroomsFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
      children: <Widget>[
        for (int i = 0; i < 6; i++) ClassroomsContainer()
      ],
    );
  }
}

class ClassroomsContainer extends StatelessWidget {
  ClassroomsContainer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: GestureDetector(
        onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen()));},
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
                      'INF3XM',
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
                  title: Text('07 Grupos', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                  subtitle: Text('33 Alunos', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
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



