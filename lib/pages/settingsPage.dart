import 'package:flutter/material.dart';
import 'package:iremibreathingapp/database/getters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../basics/user.dart';
import '../database/database.dart';
import '../utils/defaultWidget.dart';
import '../utils/myUtils.dart';
import '../utils/theme.dart';
import 'mainPage.dart';

// TODO: find out why it doesn't auto-refresh

class SettingsPage extends StatefulWidget {
  final MyUser? user;

  SettingsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _music = false;
  bool _voice = false;
  late String _voiceType;
  late String _language;

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
      _darkMode = prefs.getBool('darkMode') ?? false;
      _music = prefs.getBool('music') ?? false;
      _voice = prefs.getBool('voice') ?? false;
      _voiceType = prefs.getString('voiceType') ?? 'Male';
      _language = prefs.getString('language') ?? 'English';
    });
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _darkMode);
    await prefs.setBool('music', _music);
    await prefs.setBool('voice', _voice);
    await prefs.setString('voiceType', _voiceType);
    await prefs.setString('language', _language);
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
          ),
          body: ListView(
            children: [
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
//                    IremiTheme().toggleTheme();
                  });
                },
              ),
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
              OutlinedButton(
                onPressed: () {
                  // TODO: Backup
                },
                child: defaultText("Backup"),
              ),
              OutlinedButton(
                onPressed: () {
                  // TODO: Restore
                },
                child: defaultText("Restore"),
              ),
              if (widget.user != null)
                OutlinedButton(
                  onPressed: () async {
                    //  TODO: Put warning
                    try {
                      await MyDatabase.instance.deleteUser(widget.user!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()));
                    } catch (e) {
                      defaultDatabaseErrorDialog(context, e);
                    }
                  },
                  child: defaultText("Delete user"),
                ),
            ],
        ));
  }
}
