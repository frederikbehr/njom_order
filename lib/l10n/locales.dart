import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleUnit {
  final String languageTitle;
  final String language;
  final Locale locale;
  const LocaleUnit({required this.languageTitle, required this.language, required this.locale});
}

class LocaleChanger {
  late final List<LocaleUnit> all;

  LocaleChanger() {
    _setAll();
  }

  void _setAll() {
    all = [
      const LocaleUnit(language: "English (American)", languageTitle: "English", locale: Locale("en")),
      const LocaleUnit(language: "Danish", languageTitle: "Dansk", locale: Locale("da")),
    ];
  }

  Future setLocale(String locale) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      sharedPreferences.setString("locale", locale);
    } catch(e) {
      debugPrint(e.toString());
    }
  }

  Future<Locale?> getLocale() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      final String? code = sharedPreferences.getString("locale");
      if (code == null) return null;
      final int index = all.indexWhere((i) => i.locale.languageCode == code);
      if (index == -1) return null;
      return all[index].locale;
    } catch(e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<String> getLocaleLanguage(BuildContext context) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      String? code = sharedPreferences.getString("locale");
      if (code == null) {
        Locale systemLocale = Localizations.localeOf(context);
        code = systemLocale.languageCode;
      }
      final int index = all.indexWhere((i) => i.locale.languageCode == code);
      if (index == -1) return "English";
      return all[index].language;
    } catch(e) {
      debugPrint(e.toString());
      return "English";
    }
  }

  LocaleUnit? getLocaleUnit(String code) {
    final int index = all.indexWhere((i) => i.locale.languageCode == code);
    if (index == -1) return null;
    return all[index];
  }


}