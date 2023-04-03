import 'package:flutter/material.dart';
import 'package:iremibreathingapp/database/drive_backup_and_restore.dart';
import 'package:iremibreathingapp/database/getters.dart';
import 'package:iremibreathingapp/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../basics/badge.dart';
import '../basics/user.dart';
import '../database/database.dart';
import '../utils/default_widgets.dart';
import '../utils/my_utils.dart';
import 'dev_page.dart';
import 'home_page.dart';
import 'main_page.dart';

class SettingsPage extends StatefulWidget {
  final MyUser? user;

  const SettingsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _music = false;
  bool _voice = false;
  String _voiceType = Getters.getFirstVoiceType();
  String _language = Getters.getFirstLanguage();
  bool _dev = false;

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
      await DBMyUser().deleteUser(widget.user!.id!);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      defaultDatabaseErrorDialog(context, e.toString());
    }
  }

  void _deleteDatabase() async {
    try {
      await MyDatabase.instance.deleteDB();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
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
                _secretAchievement(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DevPage(),
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
          if (isDev)
            ListTile(
              title: defaultInputDecorator(
                "Voice",
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
              title: defaultInputDecorator(
                  'Voice Type', _getValueAsString(_voiceType), Icons.person),
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
          if (isDev)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () {
                  backupDatabaseToGoogleDrive(context);
                  _backupAchievement(context);
                },
                child: defaultButtonText("Backup"),
              ),
            ),
          if (isDev)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () {
                  restoreDatabaseFromGoogleDrive(context);
                },
                child: defaultButtonText("Restore"),
              ),
            ),
          if (widget.user != null)
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

  void _backupAchievement(BuildContext context) {
    Achievement.addAchievement(PossibleBadges.backupMaster, context);
  }

  void _secretAchievement(BuildContext context) {
    Achievement.addAchievement(PossibleBadges.secret, context);
  }
}
