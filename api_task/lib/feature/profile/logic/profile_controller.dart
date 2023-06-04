//packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
//files
import '../../../core/constant/keys.dart';
import '../../authentication/model/user.dart';
import '../../../core/constant/variables.dart';

class ProfileController extends GetxController {
  bool isLoading = false;
  bool isDarkTheme = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final _client = http.Client();
  User existingUser = User();

  getExistingUserBy(String id) async {
    try{
      var response = await _client.get(Uri.parse("$baseUrl$users/$id"),headers: headers);
      Map<String,dynamic> data = await jsonDecode(response.body);
      existingUser = User(email: data["email"], id: data["id"], phoneNum: data["phone_num"], name: data["name"], birthDate: data["birth_date"]);
    }catch(e){
      throw Exception(e);
    }
  }

  User getExistingUser() => existingUser;

   Future<void> updateUsersData(User model) async {
    try{
      final body = {'email': model.email,'name': model.name, 'phone_num': model.phoneNum,};
      await _client.patch(Uri.parse("$baseUrl$users/${model.id}"),
          headers: headers,
          body: jsonEncode(body)
      );
      GetStorage().write(AppKeys.emailKey, "${model.email}");
      GetStorage().write(AppKeys.nameKey, "${model.name}");
      GetStorage().write(AppKeys.phoneKey, "${model.phoneNum}");
    }catch(e){
      throw Exception(e);
    }

  }

}
