class User {
  final String ra;
  final String fullName;
  final String password;
  final int access;

  User({this.ra, this.fullName, this.password, this.access});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      ra: json['ra'],
      fullName: json['fullName'],
      password: json['password'],
      access: json['access']
    );
  }
}

class Classroom {
  final int idClassroom;
  final String nameClassroom;
  final int year;

  Classroom({this.idClassroom , this.nameClassroom , this.year});

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      idClassroom: json['idClassroom'],
      nameClassroom: json['nameClassroom'],
      year: json['year']
    );
  }
}

class Group {
  final int idGroup;
  final String groupTheme;
  final String description;
  final int idClassroom;
  final String ra;

  Group({this.idGroup , this.groupTheme , this.description , this.idClassroom , this.ra});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      idGroup: json['idGroup'],
      groupTheme: json['groupTheme'],
      description: json['description'],
      idClassroom: json['idClassroom'],
      ra: json['ra']
    );
  }
}

class MediumCriterion {
  final int idMedium;
  final int idBig;
  final String ra;
  final String nameMedium;
  final String description;
  final double totalValue;

  MediumCriterion({this.idMedium , this.idBig , this.ra , this.nameMedium , this.description , this.totalValue});

  factory MediumCriterion.fromJson(Map<String, dynamic> json) {
    return MediumCriterion(
      idMedium: json['idMedium'],
      idBig: json['idBig'],
      ra: json['ra'],
      nameMedium: json['nameMedium'],
      description: json['description'],
      totalValue: json['totalValue']
    );
  }
}

class MediumGrade {
  final int idMediumGrade;
  final String ra;
  final int idMedium;
  final int idGroup;
  final double grade;
  final int attempt;

  MediumGrade({this.idMediumGrade , this.ra , this.idMedium , this.idGroup , this.grade , this.attempt});

  factory MediumGrade.fromJson(Map<String, dynamic> json) {
    return MediumGrade(
      idMediumGrade: json['idMediumGrade'],
      ra: json['ra'],
      idMedium: json['idMedium'],
      idGroup: json['idGroup'],
      grade: json['grade'],
      attempt: json['attempt']
    );
  }
}
