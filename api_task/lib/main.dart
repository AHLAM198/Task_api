import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'core/localization/controller/localization_controller.dart';
import 'core/routes/route.dart';
import 'core/theme/controller/theme_controller.dart';
import 'core/theme/theme.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocalizationController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'api flutter',
      themeMode: ThemeController().themeDataGet,
      theme: ThemesContainer.lightTheme,
      darkTheme: ThemesContainer.darkTheme,
      locale: controller.initialLang,
      initialRoute: Routes.signScreen,
      getPages: AppRoutes.routes,
    );
  }
}
