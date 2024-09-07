import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/utils/app_config.dart';
import 'package:flutter_to_do_app/view/task_added_screen.dart';
import 'package:flutter_to_do_app/widget/custom_appbar.dart';
import 'package:flutter_to_do_app/widget/custom_drawer.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_to_do_app/model/to_do_list_model.dart';
import 'package:flutter_to_do_app/widget/custom_task_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isVisible = true;
  var box = Hive.box<ToDoListModel>('task');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppConfig.kSecondaryColor,
      appBar: CustomAppBar(
        title: 'My Task',
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          icon: const Icon(
            Icons.menu,
            color: AppConfig.kSecondaryColor,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
        child: FloatingActionButton(
          onPressed: () {
            Get.to(TaskAdded(
              currentTask: null,
            ));
          },
          backgroundColor: AppConfig.kPrimaryColor,
          child: const Icon(
            CupertinoIcons.add_circled_solid,
            color: AppConfig.kSecondaryColor,
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
        child: ValueListenableBuilder<Box<ToDoListModel>>(
          valueListenable: Hive.box<ToDoListModel>('task').listenable(),
          builder: ((context, box, _) {
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: ((context, index) {
                ToDoListModel currentTask = box.getAt(index)!;
                return CustomTaskWidget(
                  taskModel: currentTask,
                  index: index,
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
