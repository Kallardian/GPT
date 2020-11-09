import 'dart:convert' as convert;
import 'package:Gepeto/api/dtos.dart';
import 'package:http/http.dart' as http;

class Conn {
  static const baseUrl = 'http://192.168.0.14:3001/api/';
  static const userUrl = "users/";
  static const classroomUrl = "classrooms/";
  static const groupUrl = "groups/";
  static const criterionUrl = "medium-criteria/";
  static const gradeUrl = "medium-grades/";
  
  Future loginUser(User userLogin) async {

    var url = baseUrl + userUrl + "login";
    var response = await http.post(url, body: {
      'ra' : userLogin.ra,
      'password' : userLogin.password
    });

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      userLogin.access = jsonResponse;
    } else {
      userLogin.access = 0;
    }

    return userLogin.access;
  }

  Future getUserById(String ra) async {

    User user = new User();
    var url = baseUrl + userUrl + ra;
    Map<String, String> headers = new Map<String, String>();
    headers["Content-type"] = "application/json";
    headers["Accept"] = "application/json";
    var response = await http.get(url, headers: headers);
    var status = response.statusCode;

    print(response.body);

    if (status == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      user.ra = jsonResponse['ra'];
      user.fullName = jsonResponse['fullName'];
      user.password = jsonResponse['password'];
      user.access = jsonResponse['access'];
    }
    return response.body;
  }

  Future updateUser(User userUpdate) async {


    var url = baseUrl + userUrl;
    var response = await http.put(url, body: {
      'ra' : userUpdate.ra,
      'fullName' : userUpdate.fullName,
      'password' : userUpdate.password,
      'access' : userUpdate.access
    });

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      userUpdate.ra = jsonResponse['ra'];
      userUpdate.fullName = jsonResponse['fullName'];
      userUpdate.password = jsonResponse['password'];
      userUpdate.access = jsonResponse['access'];
    }

    return userUpdate;
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

    List classroomList = new List();
    var url = baseUrl + classroomUrl + "show";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      classroomList.addAll(jsonResponse);
    }

    return classroomList;
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

  Future postMediumGrade(MediumGrade mediumGradePost) async {

    var url = baseUrl + groupUrl;
    var response = await http.post(url, body: {
      'idMedium': mediumGradePost.idMedium,
      'ra': mediumGradePost.ra,
      'idGroup': mediumGradePost.idGroup,
      'grade': mediumGradePost.grade,
      'attempt': mediumGradePost.attempt
    });

    if (response.statusCode == 201) {
      var jsonResponse = convert.jsonDecode(response.body);
      mediumGradePost.idMediumGrade = jsonResponse['idMediumGrade'];
      mediumGradePost.ra = jsonResponse['ra'];
      mediumGradePost.idMedium = jsonResponse['idMedium'];
      mediumGradePost.idGroup = jsonResponse['idGroup'];
      mediumGradePost.grade = jsonResponse['grade'];
      mediumGradePost.attempt = jsonResponse['attempt'];
    }

    return mediumGradePost;
  }
}
