import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/settings.dart';

import '../basics/settings.dart';
import '../database/getters.dart';
import '../utils/defaultWidget.dart';
import '../utils/theme.dart';

class SettingsPage extends StatefulWidget {
  MySettings settings = Getters.getSettings();

  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    MySettings settings = widget.settings;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          backgroundColor: myBluLight,
        ),
        body: ListView(
          children: [
            defaultShowTextFormField(
                "Language", settings.language, Icons.language),
            defaultShowTextFormField(
                "Music", "${settings.music}", Icons.music_note),
            defaultShowTextFormField(
                "Dark Mode", "${settings.darkmode}", Icons.dark_mode),
            defaultShowTextFormField(
                "Voice", "${settings.voice}", Icons.keyboard_voice_rounded),
            defaultShowTextFormField(
                "Voice Type", "${settings.voiceType}", Icons.record_voice_over),
          ],
        ));
  }
}
