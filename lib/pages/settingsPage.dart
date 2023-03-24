import 'package:flutter/material.dart';
import 'package:iremibreathingapp/database/getters.dart';
import 'package:iremibreathingapp/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../basics/user.dart';
import '../database/database.dart';
import '../utils/defaultWidget.dart';
import '../utils/myUtils.dart';
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
    SharedPreferences prefs = await getSharedPreferences();
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false;
      _music = prefs.getBool('music') ?? false;
      _voice = prefs.getBool('voice') ?? false;
      _voiceType = prefs.getString('voiceType') ?? languages[0];
      _language = prefs.getString('language') ?? voiceTypes[0];
      myTheme.setMode(_darkMode);
    });
  }

  void _saveSettings() async {
    SharedPreferences prefs = await getSharedPreferences();
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
            ListTile(
              title: defaultShowTextFormField(
                  "Dark Mode", _getValueAsString(_darkMode), Icons.dark_mode),
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
            ListTile(
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
                    _saveSettings();
                  });
                },
              ),
            ),
            ListTile(
              title: defaultShowTextFormField(
                "Voice",
                _getValueAsString(_voice),
                Icons.keyboard_voice_rounded,
              ),
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
            ListTile(
              title: defaultShowTextFormField(
                'Voice Type',
                _getValueAsString(_voiceType),
                Icons.person,
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: myBluLightDark),
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
            ListTile(
              title: defaultShowTextFormField(
                'Language',
                _getValueAsString(_language),
                Icons.language,
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: myBluLightDark),
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
              child: defaultButtonText("Backup"),
            ),
            OutlinedButton(
              onPressed: () {
                // TODO: Restore
              },
              child: defaultButtonText("Restore"),
            ),
            if (widget.user != null ||  1==1)
              OutlinedButton(
                onPressed: () => _warning(context, _deleteUser),
                child: defaultButtonText("Delete User"),
              ),
            ],
        ));
  }

  String _getValueAsString(value) {
    return (value is bool) ? (value == true ? "On" : "Off") : value.toString();
  }

  void _warning(BuildContext context, Function() onDelete) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete User?"),
        content: const Text("Are you sure you want to delete this user? This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: defaultButtonText("Cancel"),
          ),
          ElevatedButton(
            onPressed: onDelete,
            child: defaultButtonText("Delete"),
          ),
        ],
      ),
    );
  }

  void _deleteUser() async {
    try {
      await MyDatabase.instance.deleteUser(widget.user!);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } catch (e) {
      defaultDatabaseErrorDialog(context, e);
    }
  }
}
