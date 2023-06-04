import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/text_field_widget.dart';
import '../../../../core/constant/validation.dart';
import '../../../../core/constant/variables.dart';
import '../../logic/controller/auth_controller.dart';

class SignForm extends StatelessWidget {
  SignForm({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context).size;
    final sizeBetweenFields = mediaQuery.height * 0.03;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Create Account", style: theme.bodyLarge),
        SizedBox(
          height: sizeBetweenFields,
        ),
        TextFieldWidget(
          controller: authController.emailController,
          validator: (value) {
            if (value.toString().isEmpty) {
              return emptyField;
            } else if (!RegExp(Validation.validationEmail).hasMatch(value)) {
              return wrongField;
            } else {
              return null;
            }
          },
          obscureText: false,
          prefixIcon: const Icon(
            Icons.mail,
          ),
          label: 'Email',
          hintText: "example@yahoo.com",
        ),
        SizedBox(
          height: sizeBetweenFields,
        ),
        TextFieldWidget(
            controller: authController.nameController,
            obscureText: false,
            validator: (value) {
              if (value.toString().isEmpty) {
                return emptyField;
              } else if (!RegExp(Validation.validationName).hasMatch(value)) {
                return wrongField;
              } else if (value.toString().length < 2) {
                return 'Minimum characters allowed : 2';
              } else {
                return null;
              }
            },
            prefixIcon: const Icon(
              Icons.person_3,
            ),
            label: "Name",
            hintText: "ex: Joe Dame"),
        SizedBox(
          height: sizeBetweenFields,
        ),
        TextFieldWidget(
          controller: authController.phoneController,
          obscureText: false,
          validator: (value) {
            if (value.toString().isEmpty) {
              return emptyField.tr;
            } else if (!RegExp(Validation.validationNumber).hasMatch(value)) {
              return wrongField.tr;
            } else if (value.length != 10) {
              return 'Phone number should be 10 digits'.tr;
            } else {
              return null;
            }
          },
          prefixIcon: const Icon(
            Icons.call,
          ),
          label: 'Phone Number',
          hintText: "ex: 12345678",
        ),
        SizedBox(
          height: sizeBetweenFields,
        ),
        GetBuilder<AuthController>(builder: (_) {
          return SizedBox(
            width: 480,
            height: 40,
            child: OutlinedButton(
                onPressed: () => authController.datePicker(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.chevron_left,
                        color: Colors.lightBlue,
                      ),
                      Text(
                        authController.isDate
                            ? authController.changeTextDate
                            : "Birthdate",
                        style: theme.bodyLarge,
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.lightBlue,
                      ),
                    ],
                  ),
                )),
          );
        }),
        SizedBox(
          height: sizeBetweenFields,
        ),
      ],
    );
  }
}
