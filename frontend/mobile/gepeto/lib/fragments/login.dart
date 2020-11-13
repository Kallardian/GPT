import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Gepeto/screens/validatorScreens.dart';

class LoginFragment extends StatelessWidget {
  final TextEditingController _controllerRA = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  final List<Color> colorList = [Colors.amber, Colors.indigo];

  LoginFragment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Center(
            child: Container(
              width: 100,
              height: 100,
              child: Image.asset("assets/image/logo.png"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 0, bottom: 10),
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
              child: TextFormField(
                controller: _controllerRA,
                maxLength: 6,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Entre com seu RA'),
                validator: (String value) {
                  return value.isEmpty ? 'Preencha o campo com seu RA.' : null;
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 70.0),
            child: Center(
              child: TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  maxLength: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Digite sua senha',
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 120.0),
            padding: EdgeInsets.only(bottom: 80),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.indigoAccent,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginValidator(
                              ra: _controllerRA.text,
                              password: _controllerPassword.text)));
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
                )),
          )
        ],
      ),
    );
  }
}
