import 'package:get/get.dart';

import 'localization/translation_keys.dart';


class Languages extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      TranslationKeys.SUS_NAME: 'Hello World',
      TranslationKeys.hello: 'Hello'
    },
    'en_AR': {
      TranslationKeys.hello : 'مرحبا بالعالم',
      'name': 'Waqas khurshid'
    },
  };

}