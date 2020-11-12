import 'package:Gepeto/api/dtos.dart';
import 'package:Gepeto/screens/criterionClassroom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Grade Screen
class GradeFragment extends StatefulWidget {
  final List<MediumCriterion> criteria;

  GradeFragment({Key key, this.criteria}) : super(key: key);

  @override
  _GradeFragmentState createState() => _GradeFragmentState();
}

class _GradeFragmentState extends State<GradeFragment> {
  List<ExpansionCriteria> _gradeCriteria;
  final TextEditingController _controllerGrade = TextEditingController();

  @override
  void initState() {
    widget.criteria.forEach((element) {
      _gradeCriteria.add(ExpansionCriteria(header: element.nameMedium));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
          children: <Widget>[
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded){
                setState(() {
                  _gradeCriteria[index].isExpanded = !_gradeCriteria[index].isExpanded;
                });
              },
              children: _gradeCriteria.map((ExpansionCriteria gradeCriteria){
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded){
                    return Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        gradeCriteria.header.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'ShareTechMono',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.indigo,
                        ),
                      ),
                    );
                  },
                  isExpanded: gradeCriteria.isExpanded,
                  body: Container(
                    padding: EdgeInsets.only(bottom: 30, left: 40, right: 40),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _controllerGrade,
                          decoration: InputDecoration(
                              icon: Icon(Icons.assessment),
                              hintText: 'Notas de 0 a 10.',
                              labelText: gradeCriteria.body
                          ),
                          validator: (String value){
                            var num = double.parse(value);
                            return (num < 0 && num > 10) ? 'Notas de 0 a 10!'.toUpperCase() : null;
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            Center(
              child: FlatButton(
                color: Colors.indigoAccent,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Text("Enviar"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CriterionClassroomScreen()));
                },
              ),
            )
          ],
        )
    );
  }
}

class ExpansionCriteria{
  ExpansionCriteria({this.isExpanded = false, this.header, this.body});

  bool isExpanded;
  final String header;
  final String body;
}
