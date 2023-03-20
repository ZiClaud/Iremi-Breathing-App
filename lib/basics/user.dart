class MyUser {
  final int? id;
  String username;
  String name;
  String? surname;
  String? sex;
  String goal;
  String badges;

//  String exerciseHistory;
//  ExerciseHistory exerciseHistory;

  MyUser(
      {this.id,
      required this.username,
      required this.name,
      required this.surname,
      required this.sex,
      required this.goal,
      required this.badges});

  MyUser copy({
    int? id,
    String? username,
    String? name,
    String? surname,
    String? sex,
    String? goal,
    String? badges,
  }) =>
      MyUser(
        id: id ?? this.id,
        username: username ?? this.username,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        sex: sex ?? this.sex,
        goal: goal ?? this.goal,
        badges: badges ?? this.badges,
      );

  static MyUser fromJson(Map<String, Object?> json) => MyUser(
        id: json[UserFields.id] as int?,
        username: json[UserFields.username] as String,
        name: json[UserFields.name] as String,
        surname: json[UserFields.surname] as String,
        sex: json[UserFields.sex] as String,
        goal: json[UserFields.goal] as String,
        badges: json[UserFields.badges] as String,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.username: username,
        UserFields.name: name,
        UserFields.surname: surname,
        UserFields.sex: sex,
        UserFields.goal: goal,
        UserFields.badges: badges,
      };
}

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id, username, name, surname, sex, goal, badges
  ];

  static final String id = '_id';
  static final String username = 'username';
  static final String name = 'name';
  static final String surname = 'surname';
  static final String sex = 'sex';
  static final String goal = 'goal';
  static final String badges = 'badges';
}