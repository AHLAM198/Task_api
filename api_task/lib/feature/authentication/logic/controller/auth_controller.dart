import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../service/auth_service.dart';
import '../../../../core/constant/variables.dart';
import '../../../../core/constant/keys.dart';
import '../../model/user.dart';

class AuthController extends GetxController {

  final apiService = AuthService();
  GetStorage authStorage = GetStorage();

  var selectedDate = DateTime.now().obs;
  String changeTextDate = DateTime.now().obs.toString();

  bool isDate = false;
  late DateTime newDate;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  clearController() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    changeTextDate = "birthdate";
  }

   getIdBy(String email) async {
    await apiService.getIdData(url: '$baseUrl$users', email: email);
  }

  getId() => apiService.getId();

  getUsers (String email) async {
    await apiService.getUsersData(url: "$baseUrl$users", email: email.trim());
  }

  getIsUserExist () => apiService.getIsUserExist();

  isUserExistDefault() => apiService.setIsUserExistToFalse();

  registerUser(User model) async {
    await apiService.postData(
      url: '$baseUrl$users',
      body: {
        'email': (model.email.toString().toLowerCase().trim()),
        'name': model.name,
        'phone_num': model.phoneNum,
        'birth_date': model.birthDate,
      },
      headers: headers,
    );

    GetStorage().write(AppKeys.emailKey, model.email.toString().toLowerCase());
    GetStorage().write(AppKeys.nameKey, model.name);
    GetStorage().write(AppKeys.phoneKey, model.phoneNum.toString());
    GetStorage().write(AppKeys.birthdateKey, model.birthDate);
  }

  //date picker
  datePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now().subtract(const Duration(days: 8000)),
        firstDate: DateTime(1980),
        lastDate: DateTime.now().subtract(const Duration(days: 7150)),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      changeTextDate = DateFormat.yMMMd().format(selectedDate.value).toString();

      newDate = selectedDate.value;

      isDate = true;
      update();
    }
  }
}
