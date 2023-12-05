import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:e_cantina_app/app_data/app_data.dart';
import 'package:e_cantina_app/screens/start_page.dart';
import 'package:e_cantina_app/screens/tela_esqueci_senha.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'firebase/firebase_config.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          useMaterial3: true,
        ),
        home: AnimatedSplashScreen(
          duration: 5000,
          splash: Container(
              color: Colors.transparent,
              child: Image.asset('assets/images/ativo_4@300x.png')),
          nextScreen: const Startpage(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          // ignore: prefer_const_constructors
          backgroundColor: Color(0xFFC72020),
        ));
  }
}
