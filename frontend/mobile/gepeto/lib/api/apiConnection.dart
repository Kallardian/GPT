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

  Future showMediumCriteria() async {

    List mediumCriterionList = new List();
    var url = baseUrl + criterionUrl;
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      mediumCriterionList.addAll(jsonResponse);
    }

    return mediumCriterionList;
  }

  Future showClassrooms() async {

    List classrooomList = new List();
    var url = baseUrl + classroomUrl + "show";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      classrooomList.addAll(jsonResponse);
    }

    return classrooomList;
  }

  Future showGroups(int idGroup) async {

    List groupList = new List();
    var url = baseUrl + groupUrl + idGroup.toString();
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      groupList.addAll(jsonResponse);
    }

    return groupList;
  }

  Future postMediumGrade(MediumGrade mediumGrade) async {

    var url = baseUrl + groupUrl;
    var response = await http.post(url, body: {
      "idMedium": mediumGrade.idMedium,
      "ra": mediumGrade.ra,
      "idGroup": mediumGrade.idGroup,
      "grade": mediumGrade.grade,
      "attempt": mediumGrade.attempt
    });

    if (response.statusCode == 201) {
      var jsonResponse = convert.jsonDecode(response.body);
      mediumGrade.idMediumGrade = jsonResponse['idMediumGrade'];
      mediumGrade.ra = jsonResponse['ra'];
      mediumGrade.idMedium = jsonResponse['idMedium'];
      mediumGrade.idGroup = jsonResponse['idGroup'];
      mediumGrade.grade = jsonResponse['grade'];
      mediumGrade.attempt = jsonResponse['attempt'];
    }

    return mediumGrade;
  }
}
