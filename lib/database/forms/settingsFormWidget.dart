/*
import 'package:flutter/material.dart';
import 'package:iremibreathingapp/database/getters.dart';

import '../../../utils/defaultWidget.dart';

class SettingsFormWidget extends StatelessWidget {
  final String? language;
  final bool? darkmode;
  final bool? music;
  final bool? voice;
  final String? voiceType;
  final ValueChanged<String> onChangedLanguage;
  final ValueChanged<bool> onChangedDarkMode;
  final ValueChanged<bool> onChangedMusic;
  final ValueChanged<bool> onChangedVoice;
  final ValueChanged<String> onChangedVoiceType;

  const SettingsFormWidget({
    Key? key,
    this.language = '',
    this.darkmode = false,
    this.music = true,
    this.voice = true,
    this.voiceType = '',
    required this.onChangedLanguage,
    required this.onChangedDarkMode,
    required this.onChangedMusic,
    required this.onChangedVoice,
    required this.onChangedVoiceType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
/*            defaultShowTextFormField(
                "Language", settings.language, Icons.language), */
                  defaultListTile(
                    icon: Icons.language,
                    title: "Language",
                    subtitle: language ?? Getters.getDefaultSettings().language,
                    mySwitch: null,
                    //onChanged: onChangedLanguage, - todo, somewhere
                  ),
                  defaultListTile(
                    icon: Icons.dark_mode,
                    title: "Dark Mode",
                    subtitle: darkmode ?? Getters.getDefaultSettings().darkmode,
                    mySwitch: Switch(
                      value: darkmode ?? Getters.getDefaultSettings().darkmode,
                      onChanged: onChangedDarkMode,
                    ),
                  ),
                  defaultListTile(
                    icon: Icons.music_note,
                    title: "Music",
                    subtitle: music,
                    mySwitch: Switch(
                      value: music ?? Getters.getDefaultSettings().music,
                      onChanged: onChangedMusic,
                    ),
                  ),
                  defaultListTile(
                    icon: Icons.keyboard_voice_rounded,
                    title: "Voice",
                    subtitle: voice ?? Getters.getDefaultSettings().voice,
                    mySwitch: Switch(
                      value: voice ?? Getters.getDefaultSettings().voice,
                      onChanged: onChangedVoice,
                    ),
                  ),
                  defaultListTile(
                    icon: Icons.record_voice_over,
                    title: "Voice Type",
                    subtitle:
                        voiceType ?? Getters.getDefaultSettings().voiceType,
                    mySwitch: null,
//                    onChanged: onChangedVoiceType,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
*/
