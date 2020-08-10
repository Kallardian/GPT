import 'package:Gepeto/blocs/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Gepeto/screensContext/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ChangeNotifierProvider<ThemeChanger>(
        builder: (_) => ThemeChanger(ThemeData.light()),
        child: new MaterialAppWithTheme()
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GEPETO',
      theme: theme.getTheme(),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: EmptyNavBar(),

      body: Builder(
        builder: (BuildContext context) {
          return LoginFragment();
        },
      ),

      bottomNavigationBar: Builder(
        builder: (BuildContext context) {
          return BottomAppBar(
            color: Colors.indigoAccent,
            notchMargin: kFloatingActionButtonMargin,
            child: Container(
              height: 45,
              alignment: Alignment.bottomRight,
              child: FlatButton(
                padding: EdgeInsets.only(right: 20),
                onPressed: (){
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(Icons.list),
              ),
            ),
          );
        },
      ),
    );
  }
}

//NavigationSideBar
class EmptyNavBar extends StatelessWidget {
  EmptyNavBar({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'Por questões de segurança\nFaça o login antes de navegar\npelo App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.indigoAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Login Screen
class LoginFragment extends StatelessWidget {
  LoginFragment({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 150, bottom: 10),
            height: 100,
            child: Center(
              child: Text(
                'Preencha os campos para\nefetuar o Login',
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: Colors.indigo,
                  fontFamily: 'ShareTechMono',
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 70.0),
            margin: EdgeInsets.only(bottom: 10),
            child: Center(
              child: TextField(
                maxLength: 6,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' Entre com seu RA',
                ),
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
                    hintText: ' Digite sua senha',
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
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ContextScreen()
                      ));
                    },
                    child: Text(
                      'Login',
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

//Loading
class Loading extends StatelessWidget {
  Loading({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.indigo),
      ),
    );
  }
}
