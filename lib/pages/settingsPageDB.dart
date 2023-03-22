import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/settings.dart';

import '../database/forms/settingsFormWidget.dart';
import '../database/getters.dart';
import '../utils/defaultWidget.dart';

class SettingsPageDB extends StatefulWidget {
  final MySettings? settings;

  SettingsPageDB({Key? key, this.settings}) : super(key: key);

  @override
  State<SettingsPageDB> createState() => _SettingsPageDBState();
}

class _SettingsPageDBState extends State<SettingsPageDB> {
  final _formKey = GlobalKey<FormState>();
  late String language;
  late bool darkmode;
  late bool music;
  late bool voice;
  late String voiceType;

  @override
  void initState() {
    super.initState();

    language =
        widget.settings?.language ?? Getters.getDefaultSettings().language;
    darkmode =
        widget.settings?.darkmode ?? Getters.getDefaultSettings().darkmode;
    music = widget.settings?.music ?? Getters.getDefaultSettings().music;
    voice = widget.settings?.voice ?? Getters.getDefaultSettings().voice;
    voiceType =
        widget.settings?.voiceType ?? Getters.getDefaultSettings().voiceType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar("Settings"),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: SettingsFormWidget(
                language: language,
                darkmode: darkmode,
                music: music,
                voice: voice,
                voiceType: voiceType,
                onChangedLanguage: (language) =>
                    setState(() => this.language = language),
                onChangedDarkMode: (darkmode) =>
                    setState(() => this.darkmode = darkmode),
                onChangedMusic: (music) => setState(() => this.music = music),
                onChangedVoice: (voice) => setState(() => this.voice = voice),
                onChangedVoiceType: (voiceType) =>
                    setState(() => this.voiceType = voiceType)),
          ),
          if (widget.settings == null)
            defaultText("No settings found - Default settings are shown"),
        ],
      ),
      /*
      floatingActionButton: defaultFloatingActionButton(
        icon: Icons.navigate_next,
        onPressed: () => {
          addOrUpdateUser(),
        },
      ),
      */
    );
  }

/*
  Widget buildButton() {
    final isFormValid = username.isNotEmpty && name.isNotEmpty;

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: FloatingActionButton(onPressed: () {
          if (isFormValid) {
            addOrUpdateUser();
          }
        }));
  }

  void addOrUpdateUser() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.user != null;

      try {
        if (isUpdating) {
          await _updateUser();
        } else {
          await _addUser();
        }
      } catch (e) {
        defaultDatabaseErrorDialog(context, e);
      }

      Navigator.of(context).pop();
    }
  }

  Future _updateUser() async {
    final user = widget.user!.copy(
      username: username,
      name: name,
      surname: surname,
      sex: sex,
      goal: goal,
    );

    try {
      await MyDatabase.instance.update(user);
      Navigator.of(context).pop();
    } catch (e) {
      defaultDatabaseErrorDialog(context, e);
    }
  }

  Future _addUser() async {
    final user = MyUser(
      username: username,
      name: name,
      surname: surname,
      sex: sex,
      goal: goal,
    );

    try {
      await MyDatabase.instance.create(user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } catch (e) {
      defaultDatabaseErrorDialog(context, e);
    }
  }
  */
}
