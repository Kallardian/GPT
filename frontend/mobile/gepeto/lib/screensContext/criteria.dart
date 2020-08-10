import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Widget> criteria = [for(int i = 0; i < 4; i++) CriteriaPage(index: i + 1)];

//Criteria Screen
class CriteriaFragment extends StatelessWidget {
  CriteriaFragment({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemBuilder: (context, position) => criteria[position],
       itemCount: criteria.length,
    );
  }
}

class CriteriaPage extends StatelessWidget {
  CriteriaPage({Key key, this.index}) : super(key: key);
  final int index;
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
                  'Critério ' + index.toString(),
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
            child: Center(
                child: Text(
                  'Descrição do critério ' + index.toString() + ': aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                )
            ),
          ),
        ],
      ),
    );
  }
}
