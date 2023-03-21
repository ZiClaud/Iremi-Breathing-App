class MyUser {
  final int? id;
  String username;
  String name;
  String? surname;
  String? sex;
  String goal;

//  List<Badge> badges;
//  ExerciseHistory exerciseHistory;

  MyUser({
    this.id,
    required this.username,
    required this.name,
    required this.surname,
    required this.sex,
    required this.goal,
  });

  MyUser copy({
    int? id,
    String? username,
    String? name,
    String? surname,
    String? sex,
    String? goal,
  }) =>
      MyUser(
        id: id ?? this.id,
        username: username ?? this.username,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        sex: sex ?? this.sex,
        goal: goal ?? this.goal,
      );

  static MyUser fromJson(Map<String, Object?> json) => MyUser(
        id: json[UserFields.id] as int?,
        username: json[UserFields.username] as String,
        name: json[UserFields.name] as String,
        surname: json[UserFields.surname] as String,
        sex: json[UserFields.sex] as String,
        goal: json[UserFields.goal] as String,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.username: username,
        UserFields.name: name,
        UserFields.surname: surname,
        UserFields.sex: sex,
        UserFields.goal: goal,
      };
}

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id, username, name, surname, sex, goal
  ];

  static final String id = '_id';
  static final String username = 'username';
  static final String name = 'name';
  static final String surname = 'surname';
  static final String sex = 'sex';
  static final String goal = 'goal';
}

MyUser getDefaultUser() {
  return MyUser(
    username: "N/A",
    name: "N/A",
    surname: "N/A",
    sex: "N/A",
    goal: "N/A",
  );
}

Future<MyUser> getUserOrDefault(Future<MyUser?> futureUser) async {
  MyUser? user = await futureUser;
  return user ?? getDefaultUser();
}
