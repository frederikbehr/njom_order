import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nom_order/authentication/wrapper.dart';
import 'package:nom_order/controller/controller.dart';
import 'package:nom_order/firebase_options.dart';
import 'package:provider/provider.dart';
import 'authentication/auth_service.dart';
import 'authentication/user.dart';
import 'l10n/l10n.dart';
import 'l10n/locales.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<Controller> getControllerInstance() async{
  //Get locale
  Locale? locale = await LocaleChanger().getLocale();

  //The runtime data object
  return Controller(
    authService: AuthService(),
    locale: locale,
  );
}

void main() async {

  //WidgetsBinding
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(App(controllerInstance: await getControllerInstance()));
}

class App extends StatelessWidget {
  final Controller controllerInstance;
  const App({
    super.key,
    required this.controllerInstance,
  });

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserUid?>.value(
      initialData: null,
      catchError: (_, err) => null,
      value: controllerInstance.authService.user,
      child: MaterialApp(
        title: 'Nom Order',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "noto",
          primaryColor: Colors.grey,
        ),
        supportedLocales: L10n.all,
        locale: controllerInstance.locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Wrapper(controllerInstance: controllerInstance),
      ),
    );
  }
}
