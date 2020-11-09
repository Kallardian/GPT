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
  static const gradeUrl = "medium-grades/";
  
  // Future loginUser(User userLogin) async {
  //
  //   var url = baseUrl + userUrl + "login";
  //   var response = await http.post(url, body: {
  //     'ra' : userLogin.ra,
  //     'password' : userLogin.password
  //   });
  //
  //   if (response.statusCode == 200) {
  //     var jsonResponse = convert.jsonDecode(response.body);
  //     userLogin.access = jsonResponse;
  //   } else {
  //     userLogin.access = 0;
  //   }
  //
  //   return userLogin.access;
  // }

  Future<User> getUserById(String ra) async {
    final response = await http.get(baseUrl + userUrl + ra);

    if (response.statusCode == 200) {
      return User.fromJson(convert.jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  // Future updateUser(User userUpdate) async {
  //
  //
  //   var url = baseUrl + userUrl;
  //   var response = await http.put(url, body: {
  //     'ra' : userUpdate.ra,
  //     'fullName' : userUpdate.fullName,
  //     'password' : userUpdate.password,
  //     'access' : userUpdate.access
  //   });
  //
  //   if (response.statusCode == 200) {
  //     var jsonResponse = convert.jsonDecode(response.body);
  //     userUpdate.ra = jsonResponse['ra'];
  //     userUpdate.fullName = jsonResponse['fullName'];
  //     userUpdate.password = jsonResponse['password'];
  //     userUpdate.access = jsonResponse['access'];
  //   }
  //
  //   return userUpdate;
  // }

  // Future postMediumGrade(MediumGrade mediumGradePost) async {
  //
  //   var url = baseUrl + groupUrl;
  //   var response = await http.post(url, body: {
  //     'idMedium': mediumGradePost.idMedium,
  //     'ra': mediumGradePost.ra,
  //     'idGroup': mediumGradePost.idGroup,
  //     'grade': mediumGradePost.grade,
  //     'attempt': mediumGradePost.attempt
  //   });
  //
  //   if (response.statusCode == 201) {
  //     var jsonResponse = convert.jsonDecode(response.body);
  //     mediumGradePost.idMediumGrade = jsonResponse['idMediumGrade'];
  //     mediumGradePost.ra = jsonResponse['ra'];
  //     mediumGradePost.idMedium = jsonResponse['idMedium'];
  //     mediumGradePost.idGroup = jsonResponse['idGroup'];
  //     mediumGradePost.grade = jsonResponse['grade'];
  //     mediumGradePost.attempt = jsonResponse['attempt'];
  //   }
  //
  //   return mediumGradePost;
  // }
}
