//packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
//files
import '../../../../common/header_widget.dart';
import '../../view/widget/edit-or-add-task.dart';
import '../../../profile/logic/profile_controller.dart';
import '../../../../core/constant/variables.dart';
import '../../../../core/routes/route.dart';
import '../../../authentication/model/user.dart';
import '../../logic/todoController.dart';
import '../widget/list_items.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = ProfileController();
    final String userId = Get.arguments['id'];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.dialog(EditOrAddTask(
          id: userId,
          title: "Add new item",
          isAddItem: true,
        )),
        child: const Icon(Icons.add),
      ),
      body: WillPopScope(
        child: Column(
          children: [
            HeaderWidget(title: "Home", action: [
              InkWell(
                onTap: () async {
                  await profileController.getExistingUserBy(userId);
                  User user = profileController.getExistingUser();
                  Get.toNamed(Routes.profileScreen, arguments: {
                    "userId": userId,
                    "user": user,
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(profileImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              )
            ]),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: GetBuilder<TodoController>(builder: (controller) {
                  return FutureBuilder(
                      future: controller.getTasksData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data?[index];
                              var date =
                                  DateFormat('yyyy-MM-dd').parse(data!.date);
                              return ListItem(
                                taskData: data,
                                controller: controller,
                                date: date,
                                userId: userId,
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: Text("THERE IS NO ITEMS"),
                          );
                        }
                      });
                }),
              ),
            ),
          ],
          // )
        ),
        onWillPop: () async {
          Get.snackbar("", "Cannot go back");
          return false;
        },
      ),
    );
  }
}
