import 'package:flutter/material.dart';
import 'package:money_cycle/screen/lobby/screens/input_code_screen.dart';
import 'package:money_cycle/screen/lobby/screens/qr_scanner.dart';

class ParticipateRoomScreen extends StatefulWidget {
  const ParticipateRoomScreen({super.key});

  @override
  State<ParticipateRoomScreen> createState() => _ParticipateRoomScreenState();
}

class _ParticipateRoomScreenState extends State<ParticipateRoomScreen> {
  bool isQRMode = true;

  @override
  Widget build(BuildContext context) {
    if (isQRMode) {
      return Scaffold(
        body: QRScanner(
          onTap: () {
            setState(() => isQRMode = !isQRMode);
          },
        ),
      );
    }
    return Scaffold(
      body: InputCodeScreen(
        onTap: () {
          setState(() => isQRMode = !isQRMode);
        },
      ),
    );
  }
}
