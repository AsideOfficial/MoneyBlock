import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Image.asset(
          'assets/icons/dialog.png',
          width: 260,
        );
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
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Image.asset(
                      'assets/icons/login_button.png',
                      width: 218,
                      height: 61,
                    ),
                    onPressed: () {
                      // showMyDialog(context);
                    },
                  ),
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
