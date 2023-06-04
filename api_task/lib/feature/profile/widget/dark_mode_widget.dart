import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/controller/theme_controller.dart';
import '../logic/profile_controller.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (initialController) {
      return IconButton(
          icon: Icon(
            Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            size: 30,
            color: Get.isDarkMode ? whiteColor : blackColor,
          ),
          onPressed: () {
            ThemeController().changesTheme();
            initialController.isDarkTheme = ThemeController().getThemeDataFromBox();
            Get.snackbar(Get.isDarkMode ?  "Light mode" : "Dark mode", 'Switched successfully',);
          });
    });
  }
}
