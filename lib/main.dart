import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nom_order/data/runtime_manager.dart';
import 'package:nom_order/pages/home/home_page.dart';
import 'package:provider/provider.dart';
import 'authentication/auth_service.dart';
import 'authentication/user.dart';
import 'l10n/l10n.dart';
import 'l10n/locales.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<RuntimeManager> getRuntimeManager() async{
  //Get locale
  Locale? locale = await LocaleChanger().getLocale();

  //The runtime data object
  return RuntimeManager(
    authService: AuthService(),
    locale: locale,
  );
}

void main() async {

  //WidgetsBinding
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App(runtimeManager: await getRuntimeManager()));
}

class App extends StatelessWidget {
  final RuntimeManager runtimeManager;
  const App({
    super.key,
    required this.runtimeManager,
  });

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserUid?>.value(
      initialData: null,
      catchError: (_, err) => null,
      value: runtimeManager.authService.user,
      child: MaterialApp(
        title: 'Nom Order',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        supportedLocales: L10n.all,
        locale: runtimeManager.locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: const HomePage(),
      ),
    );
  }
}
