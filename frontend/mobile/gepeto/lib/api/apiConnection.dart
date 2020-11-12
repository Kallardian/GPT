import 'dart:convert';
import 'dart:core';

import 'package:Gepeto/api/dtos.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Conn {
  static const baseUrl = 'http://192.168.0.14:3001/api/';
  static const userUrl = "users/";
  static const classroomUrl = "classrooms/";
  static const groupUrl = "groups/";
  static const criterionUrl = "medium-criteria/";
  static const mediumGradeUrl = "medium-grades/";
  static const finalGradeUrl = "final-grades/";

  Future<int> loginUser(String ra, String password) async {
    final http.Response response = await http.post(
      baseUrl + userUrl + 'login',
      headers: <String, String> {
        'Content-Type' : 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic> {
        "ra" : ra,
        "password" : password
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to Login');
    }
  }

  Future<User> getUserById(String ra) async {
    final response = await http.get(baseUrl + userUrl + ra);

    if (response.statusCode == 200) {
      return User.fromJson(convert.jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future updateUserPassword(String ra, String password) async {
    final http.Response response = await http.post(
      'http://192.168.0.14:3001/api/users/password',
      headers: <String, String> {
        'Content-Type' : 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic> {
        "ra" : ra,
        "password" : password
      }),
    );

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future postListOfMediumGrades(List<FinalGrade> listOfMediumGrades) async {

    var url = baseUrl + mediumGradeUrl + "list";
    var response = await http.post(
      url,
      headers: <String, String> {
        'Content-Type' : 'application/json; charset=UTF-8',
      },
      body: jsonEncode(listOfMediumGrades),
    );

    return response.statusCode;
  }
}
