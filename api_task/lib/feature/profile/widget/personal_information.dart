import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../common/text_field_widget.dart';
import '../../../core/constant/keys.dart';
import '../../authentication/logic/controller/auth_controller.dart';
import '../../authentication/model/user.dart';
import '../logic/profile_controller.dart';

class PersonalInformationWidget extends StatefulWidget {
  const PersonalInformationWidget(
      {Key? key,
      required this.profileController,
      required this.userId,
      required this.user})
      : super(key: key);
  final ProfileController profileController;
  final String userId;
  final User user;

  @override
  State<PersonalInformationWidget> createState() =>
      _PersonalInformationWidgetState();
}

class _PersonalInformationWidgetState extends State<PersonalInformationWidget> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    widget.profileController.emailController.text =
        widget.user.email ?? GetStorage().read(AppKeys.emailKey);
    widget.profileController.nameController.text =
        widget.user.name ?? GetStorage().read(AppKeys.phoneKey);
    widget.profileController.phoneController.text =
        widget.user.phoneNum.toString();
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const SizedBox(height: 50),
          Text(
            'personal Information',
            style: theme.bodyLarge,
          ),
          const SizedBox(height: 50),
          TextFieldWidget(
            controller: widget.profileController.nameController,
            obscureText: false,
            prefixIcon: const Icon(
              Icons.person,
            ),
            label: 'fullName'.tr,
          ),
          TextFieldWidget(
            controller: widget.profileController.emailController,
            obscureText: false,
            prefixIcon: const Icon(
              Icons.email,
            ),
            label: 'email'.tr,
          ),
          TextFieldWidget(
            controller: widget.profileController.phoneController,
            obscureText: false,
            prefixIcon: const Icon(
              Icons.phone_android,
            ),
            label: 'phoneNum',
          ),
          ElevatedButton(
              onPressed: () async {
                var data = User(
                  id: widget.userId,
                  email: widget.profileController.emailController.text,
                  phoneNum:
                      int.parse(widget.profileController.phoneController.text),
                  name: widget.profileController.nameController.text,
                );
                await widget.profileController
                    .updateUsersData(data)
                    .then((value) => Alert(
                          context: context,
                          content: const Center(
                              child: Text("Data has been changed")),
                          title: "Success",
                          buttons: [
                            DialogButton(
                                onPressed: () => Get.back(),
                                child: const Text(
                                  "ok",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ).show());
              },
              child: const Text('edit')),
        ]);
  }
}
