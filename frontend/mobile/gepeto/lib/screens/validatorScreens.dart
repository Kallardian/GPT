import 'dart:convert';

import 'package:Gepeto/api/apiConnection.dart';
import 'package:Gepeto/main.dart';
import 'package:Gepeto/screens/criterionClassroom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

Future<int> loginUser(String ra, String password) async {
  const String url = 'http://192.168.3.7:3001/api/users/login';
  final http.Response response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"ra": ra, "password": password}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to Login');
  }
}

class LoginValidator extends StatelessWidget {
  final String ra;
  final String password;

  LoginValidator({this.ra, this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: loginUser(ra, password),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        return snapshot.hasData
            ? (snapshot.data == 3 || snapshot.data == 4)
                ? OkAlertDialog(access: snapshot.data, ra: ra)
                : SomethingWentWrongAlertDialog()
            : Center(child: CircularProgressIndicator());
      },
    ));
  }
}

class OkAlertDialog extends StatelessWidget {
  final String ra;
  final int access;

  OkAlertDialog({this.access, this.ra});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoAlertDialog(
        title: Text(convert.utf8.decode(convert.latin1.encode(
            "Login realizado como " +
                ((access == 3)
                    ? "Professor de Projetos"
                    : "Professor Avaliador")))),
        actions: [
          CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CriterionClassroomScreen(ra: ra)));
              },
              child: Text("OK"))
        ],
      ),
    );
  }
}

class SomethingWentWrongAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoAlertDialog(
        title: Text(convert.utf8.decode(
            convert.latin1.encode("DADOS INCORRETOS OU USIÁRIO INATIVO"))),
        content: Text(convert.utf8.decode(convert.latin1
            .encode("Tente novamente ou entre em contato com a coordenação."))),
        actions: [
          CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
              child: Text("OK"))
        ],
      ),
    );
  }
}
