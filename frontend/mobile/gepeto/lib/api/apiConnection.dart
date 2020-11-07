import 'dart:convert' as convert;
import 'package:Gepeto/api/dtos.dart';
import 'package:http/http.dart' as http;

class Conn {
  static const baseUrl = 'http://localhost:3001/api/';
  static const userUrl = "users/";
  static const classroomUrl = "classrooms/";
  static const groupUrl = "groups/";
  static const criterionUrl = "medium-criteria/";
  static const gradeUrl = "medium-grades/";

  Future loginUser(User user) async {

    var url = baseUrl + userUrl + "login";
    var response = await http.post(url, body: {
      'ra' : user.ra,
      'password' : user.password
    });

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      user.access = jsonResponse;
    } else {
      user.access = 0;
    }

    return user.access;
  }

  Future getUserById(String ra) async {

    User user = new User();
    var url = baseUrl + userUrl + ra;
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      user.ra = jsonResponse['ra'];
      user.fullName = jsonResponse['fullName'];
      user.password = jsonResponse['password'];
      user.access = jsonResponse['access'];
    }

    return user;
  }

  Future updateUser(User user) async {

    var url = baseUrl + userUrl;
    var response = await http.put(url, body: {
      "ra" : user.ra,
      "fullName" : user.fullName,
      "password" : user.password,
      "access" : user.access
    });

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      user.ra = jsonResponse['ra'];
      user.fullName = jsonResponse['fullName'];
      user.password = jsonResponse['password'];
      user.access = jsonResponse['access'];
    }

    return user;
  }


}
