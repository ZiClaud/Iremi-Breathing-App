import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/settings.dart';
import 'package:iremibreathingapp/basics/user.dart';

import '../database/database.dart';
import '../database/forms/settingsFormWidget.dart';
import '../database/getters.dart';
import '../utils/defaultWidget.dart';
import '../utils/myUtils.dart';
import 'mainPage.dart';

class SettingsPageDB extends StatefulWidget {
  final MySettings? settings;
  final MyUser? user;

  SettingsPageDB({Key? key, required this.user, required this.settings})
      : super(key: key);

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
    return FutureBuilder(
        future: Getters.getSettingsDB(context),
        builder: (BuildContext context, AsyncSnapshot<MySettings?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              MySettings settings = snapshot.data!;
              return Scaffold(
                appBar: defaultAppBar("Settings"),
                body: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: SettingsFormWidget(
                          language: settings.language,
                          darkmode: settings.darkmode,
                          music: settings.music,
                          voice: settings.voice,
                          voiceType: settings.voiceType,
                          onChangedLanguage: (language) =>
                              setState(() => this.language = language),
                          onChangedDarkMode: (darkmode) =>
                              setState(() => this.darkmode = darkmode),
                          onChangedMusic: (music) =>
                              setState(() => this.music = music),
                          onChangedVoice: (voice) =>
                              setState(() => this.voice = voice),
                          onChangedVoiceType: (voiceType) =>
                              setState(() => this.voiceType = voiceType)),
                    ),
                    defaultOutlinedButton(
                      onPressed: () {
                        // TODO: Backup
                      },
                      child: defaultText("Backup"),
                    ),
                    defaultOutlinedButton(
                      onPressed: () {
                        // TODO: Restore
                      },
                      child: defaultText("Restore"),
                    ),
                    if (widget.user != null)
                      defaultOutlinedButton(
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
                    if (widget.settings == null)
                      defaultText(
                          "No settings found - Default settings are shown"),
                  ],
                ),
              );
            } else {
              return defaultLinearProgressIndicator();
            }
          } else {
            return defaultLinearProgressIndicator();
          }
        });
  }
}
