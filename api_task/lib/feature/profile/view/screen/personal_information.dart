//packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//files
import '../../../../common/header_widget.dart';
import '../../../../core/routes/route.dart';
import '../../logic/profile_controller.dart';
import '../../widget/personal_information.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = Get.arguments["userId"];
    final user = Get.arguments["user"];

    return GetBuilder<ProfileController>(builder: (profileController) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            HeaderWidget(
                leading: IconButton(
                    onPressed: () => Get.offNamed(Routes.profileScreen,
                        arguments: {"userId": userId, "user": user}),
                    icon: const Icon(Icons.arrow_back_ios_new))),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: 390,
                height: 450,
                child: PersonalInformationWidget(
                  userId: userId,
                  user: user,
                  profileController: profileController,
                )),
          ]),
        ),
      );
    });
  }
}
