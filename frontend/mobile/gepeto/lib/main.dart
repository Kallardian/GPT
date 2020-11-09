import 'package:Gepeto/blocs/theme.dart';
import 'package:Gepeto/components/drawerEmpty.dart';
import 'package:Gepeto/fragments/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

      drawer: DrawerEmpty(),

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
