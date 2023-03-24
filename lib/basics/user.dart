class MyUser {
  final int? id;
  String username;
  String name;
  String sex;
  String goal;
//  List<Badge> badges; - TODO
//  ExerciseHistory exerciseHistory; - TODO

  MyUser({
    this.id,
    required this.username,
    required this.name,
    required this.sex,
    required this.goal,
  });

  MyUser copy({
    int? id,
    String? username,
    String? name,
    String? sex,
    String? goal,
  }) =>
      MyUser(
        id: id ?? this.id,
        username: username ?? this.username,
        name: name ?? this.name,
        sex: sex ?? this.sex,
        goal: goal ?? this.goal,
      );

  static MyUser fromJson(Map<String, Object?> json) => MyUser(
        id: json[UserFields.id] as int?,
        username: json[UserFields.username] as String,
        name: json[UserFields.name] as String,
        sex: json[UserFields.sex] as String,
        goal: json[UserFields.goal] as String,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.username: username,
        UserFields.name: name,
        UserFields.sex: sex,
        UserFields.goal: goal,
      };
}

class UserFields {
  static final List<String> values = [
    id, username, name, sex, goal
  ];

  static const String id = '_id';
  static const String username = 'username';
  static const String name = 'name';
  static const String sex = 'sex';
  static const String goal = 'goal';
}

