import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:e_cantina_app/app_data/app_data.dart';
import 'package:e_cantina_app/config/app_config.dart';
import 'package:e_cantina_app/screens/start_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

void main() {
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
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          useMaterial3: true,
        ),
        home: AnimatedSplashScreen(
          duration: 2500,
          splash: Container(
              color: AppConfig.appBarBackgroundColor,
              child: Image.asset('assets/images/logo_e_Cantina.jpeg')),
          nextScreen: const Startpage(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          // ignore: prefer_const_constructors
          backgroundColor: Color(0xFFC72020),
        ));
  }
}
