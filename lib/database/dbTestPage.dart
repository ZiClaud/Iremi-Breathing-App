import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iremibreathingapp/basics/user.dart';
import 'package:iremibreathingapp/database/database.dart';

import '../utils/defaultWidget.dart';

class TestDBAddUserPage extends StatefulWidget {
  final MyUser? user;

  const TestDBAddUserPage({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  _TestDBAddUserPageState createState() => _TestDBAddUserPageState();
}

class _TestDBAddUserPageState extends State<TestDBAddUserPage> {
  final _formKey = GlobalKey<FormState>();
  late String username;
  late String name;
  late String? surname;
  late String? sex;
  late String goal;
  late String badges;

  @override
  void initState() {
    super.initState();

    username = widget.user?.username ?? '';
    name = widget.user?.name ?? '';
    surname = widget.user?.surname ?? '';
    sex = widget.user?.sex ?? '';
    goal = widget.user?.goal ?? '';
    badges = widget.user?.badges ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: UserFormWidget(
          username: username,
          name: name,
          surname: surname,
          sex: sex,
          goal: goal,
          onChangedUsername: (username) =>
              setState(() => this.username = username),
          onChangedName: (name) => setState(() => this.name = name),
          onChangedSurname: (surname) => setState(() => this.surname = surname),
          onChangedSex: (sex) => setState(() => this.sex = sex),
          onChangedGoal: (goal) => setState(() => this.goal = goal),
        ),
      );

  Widget buildButton() {
    final isFormValid = username.isNotEmpty && name.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateUser,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateUser() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.user != null;

      if (isUpdating) {
        await updateUser();
      } else {
        await addUser();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateUser() async {
    final user = widget.user!.copy(
      username: username,
      name: name,
      surname: surname,
      sex: sex,
      goal: goal,
      badges: badges,
    );

    await MyDatabase.instance.update(user);
  }

  Future addUser() async {
    final user = MyUser(
      username: username,
      name: name,
      surname: surname,
      sex: sex,
      goal: goal,
      badges: badges,
    );

    await MyDatabase.instance.create(user);
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'User SQLite';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.blueGrey.shade900,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        home: TestDBAddUserPage(),
      );
}

/*
        Form(
          key: _formKey,
          child: ListView(
            children: [
              defaultEditTextFormField("Username", Icons.person),
              defaultEditTextFormField(
                  "Name (optional)", Icons.nest_cam_wired_stand),
              defaultEditTextFormField("Surname (optional)", Icons.surfing),
              defaultEditTextFormField("Sex", Icons.male),
              defaultEditTextFormField("Goal", Icons.circle_outlined),
            ],
          ),
 */

class UserFormWidget extends StatelessWidget {
  final String? username;
  final String? name;
  final String? surname;
  final String? sex;
  final String? goal;
  final ValueChanged<String> onChangedUsername;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedSurname;
  final ValueChanged<String> onChangedSex;
  final ValueChanged<String> onChangedGoal;

  const UserFormWidget({
    Key? key,
    this.username = '',
    this.name = '',
    this.surname = '',
    this.sex = '',
    this.goal = '',
    required this.onChangedUsername,
    required this.onChangedName,
    required this.onChangedSurname,
    required this.onChangedSex,
    required this.onChangedGoal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  defaultEditTextFormField(
                      "Name (optional)", Icons.nest_cam_wired_stand),
                  defaultEditTextFormField("Surname (optional)", Icons.surfing),
                  defaultEditTextFormField("Sex", Icons.male),
                  defaultEditTextFormField("Goal", Icons.circle_outlined),
                  TextFormField(
                    decoration:
                        defaultInputDecoration("Username", Icons.person),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedUsername,
                  ),
                  TextFormField(
                    decoration: defaultInputDecoration(
                        "Name", Icons.nest_cam_wired_stand),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedName,
                  ),
                  TextFormField(
                    decoration: defaultInputDecoration(
                        "Surname (optional)", Icons.surfing),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedSurname,
                  ),
                  TextFormField(
                    decoration:
                        defaultInputDecoration("Sex (optional)", Icons.male),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedSex,
                  ),
                  TextFormField(
                    decoration: defaultInputDecoration(
                        "Goal (optional)", Icons.circle_outlined),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedGoal,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
