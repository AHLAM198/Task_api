//packages :
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
//files :
import '../../../authentication/logic/controller/auth_controller.dart';
import '../../../authentication/model/user.dart';
import '../../../../core/routes/route.dart';
//widgets :
import '../widget/sign_form.dart';

class SignScreen extends StatelessWidget {
  SignScreen({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(
                top: mediaQuery.height * 0.15,
                right: mediaQuery.width * 0.09,
                left: mediaQuery.width * 0.09),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SignForm(),
                ElevatedButton(
                    onPressed: () async {
                      await authController
                          .getUsers(authController.emailController.text.trim());
                      bool isUserExist = authController.getIsUserExist();
                      if (formKey.currentState!.validate()) {
                        var data = User(
                          name: authController.nameController.text,
                          email:
                              authController.emailController.text.trimRight(),
                          phoneNum: int.parse(
                            authController.phoneController.text,
                          ),
                          birthDate: DateFormat("yyyy-MM-dd")
                              .format(authController.newDate),
                        );
                        //Post user data
                        if (!isUserExist) {
                          await authController.registerUser(data);
                        }
                        await authController.getIdBy(authController
                            .emailController.text
                            .toLowerCase()
                            .trim());
                        String id = authController.getId();
                        //Navigate to Home Screen after signing up
                        Get.toNamed(Routes.homeScreen, arguments: {"id": id});
                        //Clear controllers values
                        authController.clearController();
                        authController.isUserExistDefault();
                      }
                    },
                    child: const Text("Sign Up"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
