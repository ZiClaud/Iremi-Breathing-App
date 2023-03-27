import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/myUtils.dart';

import '../database/forms/exerciseFormWidget.dart';
import '../utils/defaultWidget.dart';

class ExerciseAddPages extends StatefulWidget {

  const ExerciseAddPages({Key? key}) : super(key: key);

  @override
  State<ExerciseAddPages> createState() => _ExerciseAddPagesState();
}

class _ExerciseAddPagesState extends State<ExerciseAddPages>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final List<Widget> _pages;

  final formData = ExerciseFormData();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pages = [
      _ExerciseAddDetailsPage(
        formData: formData,
      ),
      _ExerciseAddStepsPage(
        formData: formData,
      ),
      /*
      ExerciseFormWidget(
        formData: formData,
        onAddStep: () {},
        onRemoveStep: (int) {},
      ),
      */
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add custom exercise"),
        bottom: defaultTopBar(_tabController),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next),
        onPressed: () => {
          defaultDatabaseErrorDialog(context, "Not connected to database, yet")
        },
      ),
    );
  }
}

class _ExerciseAddDetailsPage extends StatefulWidget {
  bool showComplex = false;
  final ExerciseFormData formData;

  _ExerciseAddDetailsPage({Key? key, required this.formData}) : super(key: key);

  @override
  State<_ExerciseAddDetailsPage> createState() =>
      _ExerciseAddDetailsPageState();
}

class _ExerciseAddDetailsPageState extends State<_ExerciseAddDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          defaultEditTextFormField2("Name", Icons.keyboard_double_arrow_up,
              onChanged: (value) {
            widget.formData.name = value;
          }),
          defaultEditTextFormField2("Description", Icons.description,
              onChanged: (value) {
            widget.formData.description = value;
          }),
          defaultEditTextFormField2("Notes", Icons.note,
              onChanged: (value) {
                widget.formData.notes = value;
              }),
          defaultEditTextFormField2Num("Times", Icons.incomplete_circle,
              onChanged: (value) {
                widget.formData.times = int.tryParse(value!) ?? 0;
              }),
          defaultEditTextFormField2Num("InhaleDuration", Icons.circle,
              onChanged: (value) {
                widget.formData.inhaleDuration = int.tryParse(value!) ?? 0;
              }),
          defaultEditTextFormField2Num("HoldMiddleDuration", Icons.change_circle,
              onChanged: (value) {
                widget.formData.holdMiddleDuration = int.tryParse(value!) ?? 0;
              }),
          defaultEditTextFormField2Num("ExhaleDuration", Icons.circle_outlined,
              onChanged: (value) {
                widget.formData.exhaleDuration = int.tryParse(value!) ?? 0;
              }),
          defaultEditTextFormField2Num(
              "HoldEndDuration", Icons.change_circle_outlined,
              onChanged: (value) {
                widget.formData.holdEndDuration = int.tryParse(value!) ?? 0;
              }),
          if (widget.showComplex)
            defaultEditTextFormField2Num("InhaleDuration (ms)", Icons.circle,
                onChanged: (value) {
                  widget.formData.inhaleDurationMs = int.tryParse(value!) ?? 0;
                }),
          // TODO: Make icon smaller
          if (widget.showComplex)
            defaultEditTextFormField2Num(
                "HoldMiddleDuration (ms)", Icons.change_circle,
                onChanged: (value) {
                  widget.formData.holdMiddleDurationMs = int.tryParse(value!) ?? 0;
                }),
          // TODO: Make icon smaller
          if (widget.showComplex)
            defaultEditTextFormField2Num(
                "ExhaleDuration (ms)", Icons.circle_outlined,
                onChanged: (value) {
                  widget.formData.exhaleDurationMs = int.tryParse(value!) ?? 0;
                }),
          // TODO: Make icon smaller
          if (widget.showComplex)
            defaultEditTextFormField2Num(
                "HoldEndDuration (ms)", Icons.change_circle_outlined,
                onChanged: (value) {
                  widget.formData.holdEndDurationMs = int.tryParse(value!) ?? 0;
                }),
          // TODO: Make icon smaller
          if (!widget.showComplex)
            OutlinedButton(
              onPressed: () {
                setState(() {
                  widget.showComplex = true;
                });
              },
              child: const Text('Show More'),
            ),
          if (widget.showComplex)
            OutlinedButton(
              onPressed: () {
                setState(() {
                  widget.showComplex = false;
                });
              },
              child: const Text('Show Less'),
            ),
        ],
      ),
    );
  }
}

class _ExerciseAddStepsPage extends StatefulWidget {
  final ExerciseFormData formData;

  const _ExerciseAddStepsPage({Key? key, required this.formData}) : super(key: key);

  @override
  State<_ExerciseAddStepsPage> createState() => _ExerciseAddStepsPageState();
}

class _ExerciseAddStepsPageState extends State<_ExerciseAddStepsPage> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    super.initState();
    _addTextFormField();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  void _addTextFormField() {
    final controller = TextEditingController();
    final focusNode = FocusNode();
    setState(() {
      _controllers.add(controller);
      _focusNodes.add(focusNode);
    });
    // After adding a new text field, set the focus to it.
    Future.delayed(
        Duration.zero, () => FocusScope.of(context).requestFocus(focusNode));
  }

  void _removeTextFormField(int index) {
    setState(() {
      _controllers.removeAt(index);
      _focusNodes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < _controllers.length; i++)
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controllers[i],
                      focusNode: _focusNodes[i],
                      decoration: InputDecoration(
                        labelText: 'Step ${i+1}',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeTextFormField(i),
                  ),
                ],
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addTextFormField,
              child: const Text('Add Step'),
            ),
          ],
        ),
      ),
    );
  }
}
