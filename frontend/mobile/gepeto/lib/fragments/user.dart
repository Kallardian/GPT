import 'package:Gepeto/blocs/theme.dart';
import 'package:Gepeto/components/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserFragment extends StatefulWidget {
  final String ra;

  UserFragment({this.ra});

  @override
  _UserFragmentState createState() => _UserFragmentState();
}

class _UserFragmentState extends State<UserFragment> {

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(

      drawer: DrawerComponent(ra: widget.ra),

      body: Builder(
        builder: (BuildContext context) {
          return AccountFragment();
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.indigo,
        child: Icon(Icons.assignment)
      ),

      bottomNavigationBar: Builder(
        builder: (BuildContext context) {
          return BottomAppBar(
            color: Colors.indigoAccent,
            notchMargin: kFloatingActionButtonMargin,
            child: Container(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 180),
                    child: FlatButton(
                      child: Icon(Icons.arrow_back),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: (){
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(Icons.list),

                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class AccountFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.only(top: 60),
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 70.0),
            child: Center(
              child: TextField(
                  obscureText: true,
                  maxLength: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Digite sua senha',
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 70.0),
            child: Center(
              child: TextField(
                  obscureText: true,
                  maxLength: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Digite sua nova senha',
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 70.0),
            child: Center(
              child: TextField(
                  obscureText: true,
                  maxLength: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Confirme sua senha',
                  )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 120.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.indigoAccent,
                  child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Salvar',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ShareTechMono',
                      ),
                    ),
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}