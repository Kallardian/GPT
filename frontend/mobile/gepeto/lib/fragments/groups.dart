import 'package:Gepeto/screens/gradeCriterion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/gradeCriterion.dart';
import 'package:Gepeto/api/dtos.dart';
import 'dart:convert' as convert;

//Groups Screen
class GroupsFragment extends StatelessWidget {
  final List<Group> groups;
  final String ra;

  GroupsFragment({Key key, this.groups, this.ra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: groups.length,
          itemBuilder: (context, index) {
            return GroupsMain(group: groups[index]);
          },
        )
    );
  }
}

class GroupsMain extends StatelessWidget {
  final Group group;
  final String ra;

  GroupsMain({Key key, this.group, this.ra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 10 / 16,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => GradeCriterionScreen(ra: ra, groupId: group.idGroup)));
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
                    convert.utf8.decode(convert.latin1.encode(group.groupTheme)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ShareTechMono',
                      fontSize: 32,
                    ),
                  ),
                )
              ),
              GroupsDescription(description: group.description)
            ],
          ),
        ),
      )
    );
  }
}

class GroupsDescription extends StatelessWidget{
  final String description;

  GroupsDescription({Key key, this.description}) : super(key: key);

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
              convert.utf8.decode(convert.latin1.encode(description)),
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
