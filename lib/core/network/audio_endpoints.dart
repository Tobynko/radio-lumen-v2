class AudioEndpoints {
  AudioEndpoints._();

  static const String live128 = 'https://audio.lumen.sk/live128.mp3';
  static const String live64 = 'https://audio.lumen.sk/live64.mp3';
  static const String live32 = 'https://audio.lumen.sk/live32.mp3';

  static String getUrl(int quality) {
    switch (quality) {
      case 128:
        return live128;
      case 64:
        return live64;
      case 32:
        return live32;
      default:
        return live128;
    }
  }
}
