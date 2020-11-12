import 'dart:convert';
import 'dart:core';

import 'package:Gepeto/api/dtos.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Conn {
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

  Future<User> getUserById(String ra) async {
    final response = await http.get('http://192.168.3.7:3001/api/users/123321');

    if (response.statusCode == 200) {
      return User.fromJson(convert.jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future updateUserPassword(String ra, String password) async {
    final http.Response response = await http.post(
      'http://192.168.3.7:3001/api/users/password',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{"ra": ra, "password": password}),
    );

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future postListOfMediumGrades(List<FinalGrade> listOfMediumGrades) async {
    var url = "http://192.168.3.7:3001/api/medium-grades/list";
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(listOfMediumGrades),
    );

    return response.statusCode;
  }
}
