//packages
import 'package:api_task/feature/home/view/widget/edit-or-add-task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
//files
import '../../model/todo.dart';
import '../../logic/todoController.dart';
import '../../../../core/theme/app_colors.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {super.key,
      required this.taskData,
      required this.controller,
      required this.date,
      this.userId});

  final Todo? taskData;
  final DateTime date;
  final TodoController controller;
  final String? userId;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: mediaQuery.width * 0.02,
        horizontal: mediaQuery.width * 0.02,
      ),
      child: Padding(
        padding: EdgeInsets.all(mediaQuery.height * 0.002),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      taskData?.title ?? "",
                      style: theme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      taskData?.description ?? "",
                      style: theme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(date),
                      style: theme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
                taskData?.userId == userId
                    ? Column(
                        children: [
                          IconButton(
                            onPressed: () => Get.dialog(EditOrAddTask(
                              toDoModel: taskData,
                              title: "Edit Item",
                              isAddItem: false,
                              id: userId,
                            )),
                            icon: const Icon(
                              Icons.edit,
                              color: blueColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await controller.deleteTask('${taskData?.id}');
                              controller.refreshData();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: blueColor,
                            ),
                          )
                        ],
                      )
                    : const Text(""),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
