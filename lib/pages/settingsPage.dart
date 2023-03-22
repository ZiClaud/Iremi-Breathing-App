import 'package:flutter/material.dart';
import 'package:iremibreathingapp/database/getters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/defaultWidget.dart';
import '../utils/theme.dart';

// TODO: find out why it doesn't auto-refresh

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String _language;
  bool _music = false;
  bool _darkMode = false;
  bool _voice = false;
  late String _voiceType;

  final List<String> languages = Getters.getAvailableLanguages();
  final List<String> voiceTypes = Getters.getAvailableVoiceTypes();

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
      _language = prefs.getString('language') ?? 'English';
      _voiceType = prefs.getString('voiceType') ?? 'Male';
    });
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('music', _music);
    await prefs.setBool('darkMode', _darkMode);
    await prefs.setBool('voice', _voice);
    await prefs.setString('language', _language);
    await prefs.setString('voiceType', _voiceType);
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
            backgroundColor: myBluLight,
          ),
          body: ListView(
            children: [
              defaultListTile(
                icon: Icons.language,
                title: 'Language',
                subtitle: _language,
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  String? newLanguage = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Choose a Language'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (String language in languages)
                                RadioListTile<String>(
                                  title: Text(language),
                                  value: language,
                                  groupValue: _language,
                                  onChanged: (String? value) {
                                    Navigator.of(context).pop(value);
                                  },
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  if (newLanguage != null) {
                    setState(() {
                      _language = newLanguage;
                      _saveSettings();
                    });
                  }
                },
              ),
                  defaultListTile(
                    icon: Icons.music_note,
                title: "Music",
                subtitle: _music,
                trailing: Switch(
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
                title: "Dark Mode",
                subtitle: _darkMode,
                trailing: Switch(
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
                title: "Voice",
                subtitle: _voice,
                trailing: Switch(
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
                icon: Icons.person,
                title: 'Voice Type',
                subtitle: _voiceType,
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  String? newVoiceType = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Choose a Voice Type'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (String voiceType in voiceTypes)
                                RadioListTile<String>(
                                  title: Text(voiceType),
                                  value: voiceType,
                                  groupValue: _voiceType,
                                  onChanged: (String? value) {
                                    Navigator.of(context).pop(value);
                                  },
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  if (newVoiceType != null) {
                    setState(() {
                      _voiceType = newVoiceType;
                      _saveSettings();
                    });
                  }
                },
              ),
            ],
              ));
  }
}
