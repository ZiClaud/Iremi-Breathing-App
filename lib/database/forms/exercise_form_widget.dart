import 'package:flutter/material.dart';

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
