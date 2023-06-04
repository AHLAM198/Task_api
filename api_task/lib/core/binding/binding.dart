//packages
import 'package:get/get.dart';
//files
import '../../feature/home/logic/todoController.dart';
import '../../feature/authentication/logic/controller/auth_controller.dart';
import '../../feature/profile/logic/profile_controller.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(TodoController());
    Get.lazyPut(() => ProfileController());
  }
}
