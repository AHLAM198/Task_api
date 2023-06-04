//packages
import 'package:get/get.dart';
//files
import '../../feature/home/view/screen/home_screen.dart';
import '../../feature/authentication/view/screen/sign_screen.dart';
import '../../feature/profile/view/screen/personal_information.dart';
import '../../feature/profile/view/screen/profileScreen.dart';
import '../binding/binding.dart';

class AppRoutes {
  static final routes = [
    GetPage(
        name: Routes.signScreen,
       page: () => SignScreen(),
        binding: Binding()),
    GetPage(
        name: Routes.profileScreen,
        page: () => ProfileScreen(),
        binding: Binding()),
    GetPage(
        name: Routes.personalInformation,
        page: () => const PersonalInformationScreen(),
        binding: Binding()),
    GetPage(
        name: Routes.homeScreen,
        page: () => const HomeScreen(),
        binding: Binding()),
  ];
}

class Routes {
  static const signScreen = '/signup_screen';
  static const profileScreen = '/profile_screen';
  static const personalInformation = '/personal_information';
  static const homeScreen = '/home_screen';
}
