import 'package:get/get.dart';
import 'package:money_cycle/start/model/model.dart';

class MCUserController extends GetxController {
  static MCUserController get to => Get.find();

  Rx<MCUser>? user;

  void login({
    required String name,
    required String phoneNumber,
    required String birthday,
    required String gender,
    required String? parentInfo,
    required String? location,
  }) {
    user = MCUser(
      name: name,
      phoneNumber: phoneNumber,
      birthday: birthday,
      gender: gender,
      parentInfo: parentInfo,
      location: location,
    ).obs;
  }
}
