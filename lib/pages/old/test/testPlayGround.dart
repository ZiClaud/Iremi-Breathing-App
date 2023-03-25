import 'package:flutter/material.dart';

class TestPlayGround extends StatefulWidget {
  const TestPlayGround({Key? key}) : super(key: key);

  @override
  State<TestPlayGround> createState() => _TestPlayGroundState();
}

class _TestPlayGroundState extends State<TestPlayGround> {
  bool _music = false;

  String _getValueAsString(value) {
    return (value is bool) ? (value == true ? "On" : "Off") : value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing"),
      ),
      body: ListTile(
        title: InputDecorator(
          decoration: InputDecoration(
            labelText: "Music",
            icon: Icon(Icons.music_note),
          ),
          child: Text(_getValueAsString(_music)),
        ),
        trailing: Switch(
          value: _music,
          onChanged: (value) {
            setState(() {
              _music = value;
            });
          },
        ),
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';

class TestPlayGround extends StatefulWidget {
  const TestPlayGround({Key? key}) : super(key: key);

  @override
  State<TestPlayGround> createState() => _TestPlayGroundState();
}

class _TestPlayGroundState extends State<TestPlayGround> {
  bool _music = false;

  String _getValueAsString(value) {
    return (value is bool) ? (value == true ? "On" : "Off") : value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing"),
      ),
      body: ListTile(
        title: defaultShowTextFormField(
          "Music",
          _getValueAsString(_music),
          Icons.music_note,
        ),
        trailing: Switch(
          value: _music,
          onChanged: (value) {
            setState(() {
              _music = value;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build2(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing"),
      ),
      body: ListTile(
        title: Text(
          "Music: ${_getValueAsString(_music)}",
        ),
        trailing: Switch(
          value: _music,
          onChanged: (value) {
            setState(() {
              _music = value;
            });
          },
        ),
      ),
    );
  }
}

TextFormField defaultShowTextFormField(
    String label, String text, IconData icon, {TextEditingController? controller}) {
  return TextFormField(
    enabled: false,
    initialValue: text,
    decoration: InputDecoration(label: Text(label), icon: Icon(icon)),
    keyboardType: TextInputType.multiline,
    maxLines: null,
    controller: controller,
  );
}
*/
