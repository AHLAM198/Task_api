import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/constant/variables.dart';

import '../model/todo.dart';

class TodoController extends GetxController {
  final _client = http.Client();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  refreshData() {
    getTasksData();
    update();
  }

  clearController() {
    titleController.clear();
    descriptionController.clear();
  }

  //get tasks from API :
  Future<List<Todo>> getTasksData() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$tasks'),
        headers: headers,
      );
      List todoList = jsonDecode(response.body);
      return todoList.map((todo) => Todo.fromJson(todo)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  // post tasks to the API :
  postTasksData(Todo model) async {
    try {
      final body = {
        'title': model.title,
        'description': model.description,
        'date': model.date,
        "user_id": model.userId
      };
      await _client.post(Uri.parse('$baseUrl$tasks'),
          headers: headers, body: jsonEncode(body));
    } catch (e) {
      throw Exception(e);
    }
  }

  //update certain task by id:
  updateTasksData(Todo model) async {
    try {
      final body = {
        'title': model.title,
        'description': model.description,
        'date': model.date,
      };
      await _client.put(Uri.parse("$baseUrl$tasks/${model.id}"),
          headers: headers, body: jsonEncode(body));
    } catch (e) {
      throw Exception(e);
    }
  }

  //delete certain task by Id :
  deleteTask(String id) async {
    try {
      await _client.delete(Uri.parse('$baseUrl$tasks/$id'));
    } catch (e) {
      throw Exception(e);
    }
  }
}
