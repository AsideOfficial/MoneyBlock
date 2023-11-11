import 'package:get/get.dart';
import 'package:money_cycle/start/start_screen.dart';

class AppPages {
  static final routes = [
    GetPage(name: "/start", page: () => const StartScreen()),
  ];
}
