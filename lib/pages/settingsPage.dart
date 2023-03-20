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
/*            defaultShowTextFormField(
                "Language", settings.language, Icons.language), */
            defaultListTile(
              icon: Icons.language,
              label: "Language",
              val: settings.language,
              mySwitch: null,
            ),
            defaultListTile(
              icon: Icons.music_note,
              label: "Music",
              val: settings.music,
              mySwitch: Switch(
                value: settings.music,
                onChanged: (value) {
                  setState(() {
                    settings.music = value;
                  });
                },
              ),
            ),
            defaultListTile(
              icon: Icons.dark_mode,
              label: "Dark Mode",
              val: settings.darkmode,
              mySwitch: Switch(
                value: settings.darkmode,
                onChanged: (value) {
                  setState(() {
                    settings.darkmode = value;
                  });
                },
              ),
            ),
            defaultListTile(
              icon: Icons.keyboard_voice_rounded,
              label: "Voice",
              val: settings.voice,
              mySwitch: Switch(
                value: settings.voice,
                onChanged: (value) {
                  setState(() {
                    settings.voice = value;
                  });
                },
              ),
            ),
            defaultListTile(
              icon: Icons.record_voice_over,
              label: "Voice Type",
              val: settings.voiceType,
              mySwitch: null,
            ),
          ],
        ));
  }
}
