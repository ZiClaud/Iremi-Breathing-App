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
}
