import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import '../screens.dart';

//Groups Screen
class GroupsFragment extends StatelessWidget {
  GroupsFragment({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            for (int i = 0; i < 7; i++) GroupsMain()
          ],
        )
    );
  }
}

class GroupsMain extends StatefulWidget {
  GroupsMain({Key key}) : super(key: key);

  @override
  _GroupsMainState createState() => _GroupsMainState();
}

class _GroupsMainState extends State<GroupsMain> {
  int changeWidget = 0;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 10 / 16,
      child: GestureDetector(
        onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => ThirdScreen()));},
        onLongPress: () {
          setState(() {
            Vibration.vibrate(duration: 200);
            changeWidget += 1;
            if (changeWidget > 1) {
              changeWidget = 0;
            }
          });
        },
        child: Container(
          margin: EdgeInsets.only(top: 60.0, bottom: 40.0, left: 40, right: 40),
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            children: <Widget>[
              Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      'GRUPO XX',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ShareTechMono',
                        fontSize: 32,
                      ),
                    ),
                  )
              ),
              IndexedStack(
                index: changeWidget,
                children: <Widget>[
                  GroupsStudents(),
                  GroupsDescription(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupsStudents extends StatelessWidget {
  GroupsStudents({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for(int i = 0; i < 6; i++) GroupsTile(),
      ],
    );
  }
}

class GroupsDescription extends StatelessWidget{
  GroupsDescription({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        margin: EdgeInsets.only(top: 10.0, left: 25),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        height: 370,
        width: 240,
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                'Descrição:\n',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo
                ),
              ),
            ),
            Text(
              'Percebemos, cada vez mais, que a competitividade nas transações comerciais desafia a capacidade de equalização dos níveis de motivação departamental. Por isso criamos o uma solução digital integrada.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'ShareTechMono',
                  color: Colors.black
              ),
            ),
          ],
        )
    );
  }
}

class GroupsTile extends StatelessWidget {
  GroupsTile({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
        child: ListTile(
          leading: Icon(Icons.account_circle, color: Colors.indigo,),
          title: Text('XXXXX_XXXXXXXX_XXXXX', style: TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.bold)),
          subtitle: Text('RM: 000000', style: TextStyle(color: Colors.indigoAccent)),
          dense: true,
        )
    );
  }
}