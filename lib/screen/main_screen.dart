import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_cycle/screen/lobby/screens/lobby_screen.dart';
import 'package:money_cycle/start/start_screen.dart';

class MainScreen extends StatelessWidget {
  static const routeName = "/";
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const LobbyScreen();
          } else {
            return const StartScreen();
          }
        }),
      ),
    );
  }
}
