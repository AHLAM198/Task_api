import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {


  final _client = http.Client();
   String userId = "";
   bool isUserExist = false;

  //GET request
  getIdData({required String url, required String email}) async {
    var response = await _client.get(Uri.parse(url));
    List data = jsonDecode(response.body);
      List id = data.where((element) => (element['email'].toString().toLowerCase()) == (email.trim().toLowerCase())).toList();
      userId = id[0]["id"];
    }

    getUsersData({required String url,required String email})async{
      var response = await _client.get(Uri.parse(url));
      List users = jsonDecode(response.body);
      users.forEach((element) {
        if(element["email"].toString().toLowerCase() == email.toLowerCase().trim()){
          isUserExist = true;
          return;
        }
      });
    }

    getIsUserExist() => isUserExist;

    setIsUserExistToFalse() {isUserExist = false;}

  getId () => userId;

    //POST request
  postData({
    required String url,
    required Map<String, dynamic> body,
    required Map<String, String> headers,
  }) async {
    try {
      await _client.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

}
