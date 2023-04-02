import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/exercise.dart';
import 'package:iremibreathingapp/pages/exercise_add_pages.dart';
import 'package:iremibreathingapp/pages/user_page.dart';

import '../database/getters.dart';
import '../utils/my_utils.dart';
import 'exercise_info_pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<MyExercise> exercises = Getters.getDefaultExercises();

  @override
  void initState() {
    super.initState();
    _loadCustomExercises();
  }

  Future<void> _loadCustomExercises() async {
    List<MyExercise?> customExercises =
        await Getters.getCustomExercisesDB(context);
    setState(() {
      exercises.addAll(customExercises.whereType<MyExercise>());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Welcome to Iremi"),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add_circle,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExerciseAddPages(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.account_circle,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserPage()));
              },
            ),
          ]),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          MyExercise exercise = exercises[index];
          return _showExerciseWidget(exercise);
        },
      ),
    );
  }

  Widget _showExerciseWidget(MyExercise exercise) {
    return ListTile(
      title: _showExerciseModel(exercise),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseInfoPages(exercise: exercise),
          ),
        );
      },
    );
  }

  Widget _showExerciseModel(MyExercise exercise) {
    /// Graphics
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(exercise.name),
        Text(getTimeString(exercise)),
      ],
    );
  }
}
