import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleController extends GetxController {
  RxString selectedLocale = ''.obs;

  Future<void> saveLocale(String locale) async {
    selectedLocale.value = locale;
    /// Save the locale to SharedPreferences or GetStorage
    await GetStorage().write('locale', locale);
  }

  Future<void> loadSavedLocale() async {
    /// Load the saved locale from SharedPreferences or GetStorage
    selectedLocale.value = GetStorage().read('locale') ?? 'en_US';
  }
}
