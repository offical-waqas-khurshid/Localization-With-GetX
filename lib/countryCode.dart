enum CountryCode { US, SA }

extension CountryCodeExtension on CountryCode {
  String get getKey {
    return ["US", "SA"][index];
  }
}
