class MySettings {
  final int? id;
  String language;
  bool darkmode;
  bool music;
  bool voice;
  String voiceType;

  MySettings(
      {this.id,
      required this.language,
      required this.darkmode,
      required this.music,
      required this.voice,
      required this.voiceType});

  MySettings copy({
    int? id,
    String? language,
    bool? darkmode,
    bool? music,
    bool? voice,
    String? voiceType,
  }) =>
      MySettings(
        id: id ?? this.id,
        language: language ?? this.language,
        darkmode: darkmode ?? this.darkmode,
        music: music ?? this.music,
        voice: voice ?? this.voice,
        voiceType: voiceType ?? this.voiceType,
      );

  static MySettings fromJson(Map<String, Object?> json) => MySettings(
    id: json[SettingsFields.id] as int?,
    language: json[SettingsFields.language] as String,
    darkmode: json[SettingsFields.darkmode] == 1,
    music: json[SettingsFields.music] == 1,
    voice: json[SettingsFields.voice] == 1,
    voiceType: json[SettingsFields.voiceType] as String,
  );

  Map<String, Object?> toJson() => {
    SettingsFields.id: id,
    SettingsFields.language: language,
    SettingsFields.darkmode: darkmode ? 1 : 0,
    SettingsFields.music: music ? 1 : 0,
    SettingsFields.voice: voice ? 1 : 0,
    SettingsFields.voiceType: voiceType,
  };
}

class SettingsFields {
  static final List<String> values = [
    id,
    language,
    darkmode,
    music,
    voice,
    voiceType
  ];

  static final String id = '_id';
  static final String language = 'language';
  static final String darkmode = 'darkmode';
  static final String music = 'music';
  static final String voice = 'voice';
  static final String voiceType = 'voiceType';
}