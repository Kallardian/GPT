class User {
  String ra;
  String fullName;
  String password;
  int access;
}

class Classroom {
  int idClassroom;
  String nameClassroom;
  int year;
}

class Group {
  int idGroup;
  String groupTheme;
  String description;
  int idClassroom;
  String ra;
}

class MediumCriterion {
  int idMedium;
  int idBig;
  String ra;
  String nameMedium;
  String description;
  double totalValue;
}

class MediumGrade {
  int idMediumGrade;
  String ra;
  int idMedium;
  int idGroup;
  double grade;
  int attempt;
}
