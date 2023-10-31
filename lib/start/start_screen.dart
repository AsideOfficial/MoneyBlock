import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_block/start/components/login_button.dart';
import 'package:money_block/start/components/login_options_dialog.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const LoginOptionsDialogs();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/main_illustration.png',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/logos/money_cycle_logo.png',
              width: 359,
              height: 203,
            ),
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LoginButton(onPressed: () {
                    showMyDialog(context);
                  }),
                  const SizedBox(height: 22.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
