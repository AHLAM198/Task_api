//packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//files
import '../../../../common/header_widget.dart';
import '../../../../core/routes/route.dart';
import '../../../authentication/model/user.dart';
import '../../logic/profile_controller.dart';
import '../../widget/dark_mode_widget.dart';
import '../../widget/localization_widget.dart';
import '../../widget/logout_widget.dart';
import '../../widget/profile_header_widget.dart';
import '../../widget/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final userId = Get.arguments["userId"];
    final User user = Get.arguments["user"];

    return GetBuilder<ProfileController>(builder: (profileController) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            const HeaderWidget(
              action: [ThemeSwitcher()],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: 390,
              height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(height: 50),
                  ProfileHeaderWidget(user: user),
                  const SizedBox(height: 60),
                  ProfileWidget(
                      text: 'personalInformation',
                      onTap: () async =>
                          Get.offNamed(Routes.personalInformation, arguments: {
                            "userId": userId,
                            "user": user,
                          })),
                  const LocalizationWidget(),
                  const LogoutAlert(),
                ],
              ),
            ),
          ]),
        ),
      );
    });
  }
}
