import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/getters.dart';
import '../utils/defaultWidget.dart';
import '../utils/theme.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _music = false;
  bool _darkMode = false;
  bool _voice = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _music = prefs.getBool('music') ?? false;
      _darkMode = prefs.getBool('darkMode') ?? false;
      _voice = prefs.getBool('voice') ?? false;
    });
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('music', _music);
    await prefs.setBool('darkMode', _darkMode);
    await prefs.setBool('voice', _voice);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Getters.getSettingsDB(context),
        builder: (BuildContext context, AsyncSnapshot<MySettings?> settings) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Settings"),
                backgroundColor: myBluLight,
              ),
              body: ListView(
                children: [
                  defaultListTile(
                    icon: Icons.language,
                    label: "Language",
                    val: settings.data?.language,
                    mySwitch: null,
                  ),
                  defaultListTile(
                    icon: Icons.music_note,
                    label: "Music",
                    val: _music,
                    mySwitch: Switch(
                      value: _music,
                      onChanged: (value) {
                        setState(() {
                          _music = value;
                          _saveSettings();
                        });
                      },
                    ),
                  ),
                  defaultListTile(
                    icon: Icons.dark_mode,
                    label: "Dark Mode",
                    val: _darkMode,
                    mySwitch: Switch(
                      value: _darkMode,
                      onChanged: (value) {
                        setState(() {
                          _darkMode = value;
                          _saveSettings();
                        });
                      },
                    ),
                  ),
                  defaultListTile(
                    icon: Icons.keyboard_voice_rounded,
                    label: "Voice",
                    val: _voice,
                    mySwitch: Switch(
                      value: _voice,
                      onChanged: (value) {
                        setState(() {
                          _voice = value;
                          _saveSettings();
                        });
                      },
                    ),
                  ),
                  defaultListTile(
                    icon: Icons.record_voice_over,
                    label: "Voice Type",
                    val: settings.data?.voiceType,
                    mySwitch: null,
                  ),
                  // TODO: Delete user bt
                  // TODO: Backup db bt
                  // TODO: Restore db bt
                ],
              ));
        });
  }
}
