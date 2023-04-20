import 'package:flutter/material.dart';
import 'package:iremibreathingapp/database/drive_backup_and_restore.dart';
import 'package:iremibreathingapp/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../basics/badge.dart';
import '../basics/user.dart';
import '../database/database.dart';
import '../database/database_dialogs.dart';
import '../database/getters.dart';
import '../utils/default_widgets.dart';
import '../utils/my_utils.dart';
import 'dev_page.dart';
import 'home_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  MyUser? _user;

  bool _darkMode = false;
  bool _music = false;
  bool _voice = false;
  String _voiceType = getDefaultVoiceType2();
  String _language = getDefaultLanguage();
  bool _dev = false;

  final List<String> languages = getAvailableLanguages();
  final List<String> voiceTypes = getAvailableVoiceTypes2();

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _getUser();
  }

  Future<void> _getUser() async {
    MyUser? user = await Getters.getUserDB(context);
    if (user != null) {
      setState(() {
        _user = user;
      });
    }
  }

  void _loadSettings() async {
    SharedPreferences prefs = await getSharedPreferences();
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false;
      _music = prefs.getBool('music') ?? false;
      _voice = prefs.getBool('voice') ?? false;
      _voiceType = prefs.getString('voiceType') ?? voiceTypes[0];
      _language = prefs.getString('language') ?? languages[0];
      _dev = prefs.getBool('dev') ?? false;
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
    await prefs.setBool('dev', _dev);
    _loadSettings();
  }

  String _getValueAsString(value) {
    return (value is bool) ? (value == true ? "On" : "Off") : value.toString();
  }

  void _warningUser(BuildContext context, Function() onDelete) {
    _warning(context, onDelete, "Delete User?",
        "Are you sure you want to delete this user? This action cannot be undone.");
  }

  void _warningDatabase(BuildContext context, Function() onDelete) {
    _warning(context, onDelete, "Delete Database?",
        "Are you sure you want to delete the database? This action cannot be undone.");
  }

  //TODO: Put this in default_widgets.dart
  void _warning(
      BuildContext context, Function() onDelete, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
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
      await DBMyUser().deleteUser(_user!.id!);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } catch (e) {
      defaultDatabaseErrorDialog(context, e.toString());
    }
  }

  void _deleteDatabase() async {
    try {
      await MyDatabase.instance.deleteDB();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } catch (e) {
      defaultDatabaseErrorDialog(context, e.toString());
    }
  }

  void _becomeDev() {
    setState(() {
      _dev = !_dev;
      _saveSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          if (_dev)
            IconButton(
              icon: const Icon(Icons.code),
              onPressed: () {
                Achievement.secretAchievement(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DevPage(),
                  ),
                );
              },
            ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: defaultInputDecorator(
              "Dark Mode",
              _getValueAsString(_darkMode),
              (_darkMode) ? Icons.dark_mode : Icons.light_mode,
            ),
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
          if (isDev)
            ListTile(
              title: defaultInputDecorator(
                "Music",
                _getValueAsString(_music),
                (_music) ? Icons.music_note : Icons.music_off,
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
            title: defaultInputDecorator(
              "Voice (Beta)",
              _getValueAsString(_voice),
              (_voice) ? Icons.mic : Icons.mic_off,
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
          if (isDev)
            ListTile(
              title: defaultInputDecorator('Voice Type (Beta)',
                  _getValueAsString(_voiceType), Icons.person),
              trailing: Icon(Icons.arrow_forward_ios, color: myBluLightDark()),
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
          if (isDev)
            ListTile(
              title: defaultInputDecorator(
                  'Language', _getValueAsString(_language), Icons.language),
              trailing: Icon(Icons.arrow_forward_ios, color: myBluLightDark()),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () {
                  backupDatabaseToInternalStorage(context);
                },
                child: defaultButtonText("Backup"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () {
                  restoreDatabaseFromInternalStorage(context);
                },
                child: defaultButtonText("Restore"),
              ),
            ),
          if (_user != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () => _warningUser(context, _deleteUser),
                child: defaultButtonText("Delete User"),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () => _warningDatabase(context, _deleteDatabase),
              onLongPress: () => _becomeDev(),
              child: defaultButtonText("Delete Database"),
            ),
          ),
        ],
      ),
    );
  }
}
