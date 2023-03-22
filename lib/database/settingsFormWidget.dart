import 'package:flutter/material.dart';
import 'package:iremibreathingapp/database/getters.dart';
import 'package:iremibreathingapp/utils/myUtils.dart';

import '../../utils/defaultWidget.dart';

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
                    label: "Language",
                    val: language ?? Getters.getDefaultSettings().language,
                    mySwitch: null,
                    //onChanged: onChangedLanguage, - todo, somewhere
                  ),
                  defaultListTile(
                    icon: Icons.music_note,
                    label: "Music",
                    val: music,
                    mySwitch: Switch(
                      value: music ?? Getters.getDefaultSettings().music,
                      onChanged: onChangedMusic,
                    ),
                  ),
                  defaultListTile(
                    icon: Icons.dark_mode,
                    label: "Dark Mode",
                    val: darkmode ?? Getters.getDefaultSettings().darkmode,
                    mySwitch: Switch(
                      value: darkmode ?? Getters.getDefaultSettings().darkmode,
                      onChanged: onChangedDarkMode,
                    ),
                  ),
                  defaultListTile(
                    icon: Icons.keyboard_voice_rounded,
                    label: "Voice",
                    val: voice ?? Getters.getDefaultSettings().voice,
                    mySwitch: Switch(
                      value: voice ?? Getters.getDefaultSettings().voice,
                      onChanged: onChangedVoice,
                    ),
                  ),
                  defaultListTile(
                    icon: Icons.record_voice_over,
                    label: "Voice Type",
                    val: voiceType ?? Getters.getDefaultSettings().voiceType,
                    mySwitch: null,
//                    onChanged: onChangedVoiceType,
                  ),
                  // TODO: Delete user bt
                  // TODO: Backup db bt
                  // TODO: Restore db bt
                ],
                /*
                [
                  TextFormField(
                    initialValue: language,
                    decoration:
                        defaultInputDecoration("Language", Icons.language),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedLanguage,
                    validator: (username) =>
                        username != null && username.isEmpty
                            ? 'The username cannot be empty'
                            : null,
                  ),
                  TextFormField(
                    initialValue: name,
                    decoration: defaultInputDecoration(
                        "Name", Icons.nest_cam_wired_stand),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedName,
                    validator: (name) => name != null && name.isEmpty
                        ? 'The name cannot be empty'
                        : null,
                  ),
                  TextFormField(
                    initialValue: surname,
                    decoration: defaultInputDecoration(
                        "Surname (optional)", Icons.surfing),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedSurname,
                  ),
                  TextFormField(
                    initialValue: sex,
                    decoration:
                        defaultInputDecoration("Sex (optional)", Icons.male),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedSex,
                  ),
                  TextFormField(
                    initialValue: goal,
                    decoration: defaultInputDecoration(
                        "Goal (optional)", Icons.circle_outlined),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedGoal,
                  ),
                ],
                */
              ),
            ],
          ),
        ),
      );
}
