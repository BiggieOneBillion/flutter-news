import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/onboarding_screen.dart';
import 'package:news_app/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
        GoRouter.of(context).go('/welcome');
      },
      childWidget: const Text(
        'RIOTECH NEWS',
        style: TextStyle(
            fontSize: 40, fontWeight: FontWeight.w800, color: Colors.black87),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      // nextScreen: const WelcomeScreen(),
    );
    ;
  }
}
