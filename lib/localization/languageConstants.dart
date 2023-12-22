import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../countryCode.dart';
import '../languageCode.dart';
import 'appLocalization.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String ARABIC = 'ar';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode =
      _prefs.getString(LAGUAGE_CODE) ?? LanguageCode.ENGLISH.getKey;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, CountryCode.US.getKey);
    case ARABIC:
      return Locale(ARABIC, CountryCode.SA.getKey);
    default:
      return Locale(ENGLISH, CountryCode.US.getKey);
  }
}

String getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context)?.translate(key) ?? key;
}
