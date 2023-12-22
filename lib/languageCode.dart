enum LanguageCode { ENGLISH, ARABIC }

extension LanguageCodeExtension on LanguageCode {
  String get getKey {
    return ["en", "ar"][index];
  }
}
