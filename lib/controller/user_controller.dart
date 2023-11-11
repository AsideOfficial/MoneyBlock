import 'package:get/get.dart';
import 'package:money_cycle/start/model/mc_user.dart';

class MCUserController extends GetxController {
  static MCUserController get to => Get.find();

  Rx<MCUser>? user;

  void login({required MCUser userData}) {
    user = userData.obs;
  }
}
