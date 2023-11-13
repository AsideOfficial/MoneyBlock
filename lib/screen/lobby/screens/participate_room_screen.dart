import 'package:flutter/material.dart';
import 'package:money_cycle/screen/lobby/screens/qr_scanner.dart';

class ParticipateRoomScreen extends StatelessWidget {
  const ParticipateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: QRScanner(),
    );
  }
}
