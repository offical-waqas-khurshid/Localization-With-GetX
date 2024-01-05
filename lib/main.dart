import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization_with_getx/locale_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  await GetStorage.init();
  await SharedPreferences.getInstance();
  final LocaleController localeController = Get.put(LocaleController());
  await localeController.loadSavedLocale();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  final LocaleController localeController = Get.find<LocaleController>();
  Locale _getLocale(String localeString) {
    if (localeString.contains('_')) {
      List<String> parts = localeString.split('_');
      return Locale(parts[0], parts[1]);
    } else {
      return Locale(localeString);
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: _getLocale(localeController.selectedLocale.value),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'hello': 'Hello World',
      'hint_text': 'You have pushed the button this many times',
      'change_language': 'Choose Your Language',
      'increment': 'Increment'
    },
    'hi_IN': {
      'hello': 'नमस्ते दुनिया',
      'hint_text': 'आपने कई बार यह बटन दबाया है',
      'change_language': 'अपनी भाषा चुनिए',
      'increment': 'वृद्धि'
    },
    'ar_SA': {
      'hello': 'مرحبا بالعالم',
      'hint_text': 'لقد ضغطت على الزر عدة مرات',
      'change_language': 'اختر لغتك',
      'increment': 'زيادة راتب'
    }
  };
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': const Locale('hi', 'IN')},
    {'name': 'Arabic', 'locale': const Locale('ar', 'SA')},
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
    Get.find<LocaleController>().saveLocale(locale.toString());
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('change_language'.tr),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(locale[index]['name']),
                      ),
                      onTap: () {
                        updateLanguage(locale[index]['locale']);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'hint_text'.tr,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 55.0,
              width: 220.0,
              child: ElevatedButton(
                  onPressed: () {
                    buildLanguageDialog(context);
                  },
                  child: Text('change_language'.tr)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'increment'.tr,
        child: const Icon(Icons.add),
      ),
    );
  }
}