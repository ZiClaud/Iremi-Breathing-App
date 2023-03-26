import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/myUtils.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pages = [
      _ExerciseAddDetailsPage(),
      _ExerciseAddStepsPage(),
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
        onPressed: () =>
        {
          defaultDatabaseErrorDialog(context, "Not connected to database, yet")
        },
      ),
    );
  }
}

class _ExerciseAddDetailsPage extends StatefulWidget {
  bool showComplex = false;

  _ExerciseAddDetailsPage({Key? key}) : super(key: key);

  @override
  State<_ExerciseAddDetailsPage> createState() => _ExerciseAddDetailsPageState();
}

class _ExerciseAddDetailsPageState extends State<_ExerciseAddDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          defaultEditTextFormField("Name", Icons.keyboard_double_arrow_up),
          defaultEditTextFormField("Description", Icons.description),
          defaultEditTextFormField("Notes", Icons.note),
          defaultEditTextFormField("Times", Icons.incomplete_circle),
          defaultEditTextFormField("InhaleDuration", Icons.circle),
          defaultEditTextFormField("HoldMiddleDuration", Icons.change_circle),
          defaultEditTextFormField("ExhaleDuration", Icons.circle_outlined),
          defaultEditTextFormField(
              "HoldEndDuration", Icons.change_circle_outlined),
          if (widget.showComplex)
            defaultEditTextFormField("InhaleDuration (ms)", Icons.circle),
          // TODO: Make icon smaller
          if (widget.showComplex)
            defaultEditTextFormField(
                "HoldMiddleDuration (ms)", Icons.change_circle),
          // TODO: Make icon smaller
          if (widget.showComplex)
            defaultEditTextFormField(
                "ExhaleDuration (ms)", Icons.circle_outlined),
          // TODO: Make icon smaller
          if (widget.showComplex)
            defaultEditTextFormField(
                "HoldEndDuration (ms)", Icons.change_circle_outlined),
          // TODO: Make icon smaller
          if (!widget.showComplex)
            OutlinedButton(
              onPressed: () {
                setState(() {
                  widget.showComplex = true;
                });
              },
              child: Text('Show More'),
            ),
          if (widget.showComplex)
            OutlinedButton(
              onPressed: () {
                setState(() {
                  widget.showComplex = false;
                });
              },
              child: Text('Show Less'),
            ),
        ],
      ),
    );
  }
}

class _ExerciseAddStepsPage extends StatefulWidget {
  const _ExerciseAddStepsPage({Key? key}) : super(key: key);

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
