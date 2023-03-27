import 'package:flutter/material.dart';

import '../../pages/exerciseAddPages.dart';
/*
class ExerciseFormWidget extends StatelessWidget {
  final String? name;
  final String? description;
  final String? notes;
  final List<String>? steps;
  final int? times;
  late int? inhaleDuration;
  late int? holdMiddleDuration;
  late int? exhaleDuration;
  late int? holdEndDuration;
  late int? inhaleDurationMs;
  late int? holdMiddleDurationMs;
  late int? exhaleDurationMs;
  late int? holdEndDurationMs;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedNotes;
  final ValueChanged<String> onChangedSteps;
  final ValueChanged<String> onChangedTimes;
  final ValueChanged<String> onChangedID;
  final ValueChanged<String> onChangedHMD;
  final ValueChanged<String> onChangedED;
  final ValueChanged<String> onChangedHED;
  final ValueChanged<String> onChangedIDms;
  final ValueChanged<String> onChangedHMDms;
  final ValueChanged<String> onChangedEDms;
  final ValueChanged<String> onChangedHEDms;


  const ExerciseFormWidget({
    Key? key,
    this.name = '',
    this.description = '',
    this.notes = '',
    this.steps,
    this.times,
    this.inhaleDuration,
    this.holdMiddleDuration,
    this.exhaleDuration,
    this.holdEndDuration,
    this.inhaleDurationMs,
    this.holdMiddleDurationMs,
    this.exhaleDurationMs,
    this.holdEndDurationMs,
    required this.onChangedName,
    required this.onChangedDescription,
    required this.onChangedNotes,
    required this.onChangedSteps,
    required this.onChangedTimes,
    required this.onChangedID,
    required this.onChangedHMD,
    required this.onChangedED,
    required this.onChangedHED,
    required this.onChangedIDms,
    required this.onChangedHMDms,
    required this.onChangedEDms,
    required this.onChangedHEDms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  TextFormField(
                    initialValue: username,
                    decoration: const InputDecoration(
                      label: Text("Username"),
                      icon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedUsername,
                    validator: (username) =>
                        username != null && username.isEmpty
                            ? 'The username cannot be empty'
                            : null,
                  ),
                  TextFormField(
                    initialValue: name,
                    decoration: const InputDecoration(
                      label: Text("Name (optional)"),
                      icon: Icon(Icons.badge_outlined),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedName,
                  ),
                  TextFormField(
                    initialValue: sex,
                    decoration: const InputDecoration(
                      label: Text("Sex (optional)"),
                      icon: Icon(Icons.search),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedSex,
                  ),
                  TextFormField(
                    initialValue: goal,
                    decoration: const InputDecoration(
                      label: Text("Goal (optional)"),
                      icon: Icon(Icons.ads_click),
                    ),
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
*/

class ExerciseFormData {
  String? name;
  String? description;
  String? notes;
  int? times;
  int? inhaleDuration;
  int? holdMiddleDuration;
  int? exhaleDuration;
  int? holdEndDuration;
  int? inhaleDurationMs;
  int? holdMiddleDurationMs;
  int? exhaleDurationMs;
  int? holdEndDurationMs;
  bool showComplex = false;
  List<String> steps = [];
}

class ExerciseFormWidget extends StatefulWidget {
  final ExerciseFormData formData;
  final Function() onAddStep;
  final Function(int) onRemoveStep;

  const ExerciseFormWidget({
    Key? key,
    required this.formData,
    required this.onAddStep,
    required this.onRemoveStep,
  }) : super(key: key);

  @override
  _ExerciseFormWidgetState createState() => _ExerciseFormWidgetState();
}

class _ExerciseFormWidgetState extends State<ExerciseFormWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                TextFormField(
                  initialValue: widget.formData.name,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    icon: Icon(Icons.badge_outlined),
                  ),
                  onChanged: (value) => widget.formData.name = value,
                ),
                TextFormField(
                  initialValue: widget.formData.description,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    icon: Icon(Icons.description),
                  ),
                  onChanged: (value) => widget.formData.description = value,
                ),
                // Add other TextFormFields here
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: widget.onAddStep,
              child: const Text('Add Step'),
            ),
            for (var i = 0; i < widget.formData.steps.length; i++)
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: widget.formData.steps[i],
                      decoration: InputDecoration(
                        labelText: 'Step ${i + 1}',
                      ),
                      onChanged: (value) => widget.formData.steps[i] = value,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => widget.onRemoveStep(i),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
