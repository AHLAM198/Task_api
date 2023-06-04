//packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//files
import '../../logic/todoController.dart';
import '../../model/todo.dart';
import '../../../../core/constant/variables.dart';

class EditOrAddTask extends StatelessWidget {
  EditOrAddTask(
      {Key? key,
      this.toDoModel,
      required this.title,
      required this.isAddItem,
      this.id})
      : super(key: key);
  final Todo? toDoModel;
  final bool isAddItem;
  final String title;
  final String? id;
  final controller = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    controller.titleController.text = isAddItem ? "" : toDoModel!.title;
    controller.descriptionController.text =
        isAddItem ? "" : toDoModel!.description;
    final itemsKey = GlobalKey<FormState>();
    final theme = Theme.of(context).textTheme;
    return AlertDialog(
      title: Text(
        title,
        style: theme.bodyMedium,
      ),
      content: SizedBox(
        height: 200,
        child: Form(
          key: itemsKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.titleController,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return emptyField;
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: controller.descriptionController,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return emptyField;
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            isAddItem ? "Add Item" : "Save changes",
            style: theme.headlineLarge,
          ),
          onPressed: () async {
            if (itemsKey.currentState!.validate()) {
              Get.back();
              var data = Todo(
                title: controller.titleController.text,
                description: controller.descriptionController.text,
                date: DateTime.now().toString(),
                id: isAddItem ? null : toDoModel?.id,
                userId: isAddItem ? id : null,
              );
              isAddItem
                  ? await controller.postTasksData(data)
                  : await controller.updateTasksData(data);
              controller.refreshData();
              controller.clearController();
            }
          },
        ),
      ],
    );
  }
}
