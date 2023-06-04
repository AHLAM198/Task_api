import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/dialoge_widget.dart';
import '../../../core/routes/route.dart';
import '../logic/profile_controller.dart';

class LogoutAlert extends StatelessWidget {
  const LogoutAlert({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: 'Confirmation!',
      content: "Do you want to logout ?",
      textButton: 'logout',
      onPressed: () => Get.toNamed(Routes.signScreen),
      child: const Text("logout"),
    );
  }
}
