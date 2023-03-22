import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iremibreathingapp/basics/user.dart';
import 'package:iremibreathingapp/database/database.dart';
import 'package:iremibreathingapp/utils/theme.dart';

import '../../utils/myUtils.dart';
import '../forms/userFormWidget.dart';

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

  @override
  void initState() {
    super.initState();

    username = widget.user?.username ?? '';
    name = widget.user?.name ?? '';
    surname = widget.user?.surname ?? '';
    sex = widget.user?.sex ?? '';
    goal = widget.user?.goal ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text("DEV - Database"),
        backgroundColor: myBluLight,
        actions: [buildButton()],
      ),
      body: Form(
        key: _formKey,
        child: UserFormWidget(
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
      ));

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

      try {
        if (isUpdating) {
          await updateUser();
        } else {
          await addUser();
        }
      } catch (e) {
        defaultDatabaseErrorDialog(context, e);
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
    );

    try {
      await MyDatabase.instance.update(user);
    } catch (e) {
      defaultDatabaseErrorDialog(context, e);
    }
  }

  Future addUser() async {
    final user = MyUser(
      username: username,
      name: name,
      surname: surname,
      sex: sex,
      goal: goal,
    );

    try {
      await MyDatabase.instance.create(user);
    } catch (e) {
      defaultDatabaseErrorDialog(context, e);
    }
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
