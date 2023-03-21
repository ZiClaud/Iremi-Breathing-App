import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/settings.dart';

import '../database/getters.dart';
import '../utils/defaultWidget.dart';
import '../utils/theme.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Getters.getSettings(),
        builder: (BuildContext context, AsyncSnapshot<MySettings?> settings) {
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
                    val: settings.data?.language,
                    mySwitch: null,
                  ),
                  defaultListTile(
                    icon: Icons.music_note,
                    label: "Music",
                    val: settings.data?.music,
                    mySwitch: Switch(
                      value: settings.data?.music ?? false,
                      onChanged: (value) {
                        setState(() {
                          settings.data?.music = value;
                        });
                      },
                    ),
                  ),
                  defaultListTile(
                    icon: Icons.dark_mode,
                    label: "Dark Mode",
                    val: settings.data?.darkmode,
                    mySwitch: Switch(
                      value: settings.data?.darkmode ?? false,
                      onChanged: (value) {
                        setState(() {
                          settings.data?.darkmode = value;
                        });
                      },
                    ),
                  ),
                  defaultListTile(
                    icon: Icons.keyboard_voice_rounded,
                    label: "Voice",
                    val: settings.data?.voice,
                    mySwitch: Switch(
                      value: settings.data?.voice ?? false,
                      onChanged: (value) {
                        setState(() {
                          settings.data?.voice = value;
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
                ],
              ));
        });
  }
}
