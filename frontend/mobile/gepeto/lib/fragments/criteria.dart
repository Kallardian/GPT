import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Gepeto/api/dtos.dart';
import 'dart:convert' as convert;


//Criteria Screen
class CriteriaFragment extends StatelessWidget {
  final List<MediumCriterion> criteria;
  
  CriteriaFragment({Key key, this.criteria}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: criteria.length,
      itemBuilder: (context, index) {
        return CriteriaPage(criterion: criteria[index]);
      });
  }
}

class CriteriaPage extends StatelessWidget {
  final MediumCriterion criterion;
  
  CriteriaPage({Key key, this.criterion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              color: Colors.indigo,
            ),
            height: 60,
            child: Center(
                child: Text(
                  convert.utf8.decode(convert.latin1.encode(criterion.nameMedium)),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ShareTechMono',
                    fontSize: 20,
                  ),
                )
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              color: Colors.indigoAccent,
            ),
            padding: EdgeInsets.all(20),
            height: 240,
            child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                    criterion.totalValue.toString()+ ": " + convert.utf8.decode(convert.latin1.encode(criterion.description)
                ),
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 21,
                    fontFamily: 'ShareTechMono'
                  ),
                  textAlign: TextAlign.left,
                )
            ),
          ),
        ],
      ),
    );
  }
}
