import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/model/to_do_list_model.dart';
import 'package:flutter_to_do_app/utils/app_config.dart';
import 'package:flutter_to_do_app/view/task_added_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import 'custom_dialog.dart';

class CustomTaskWidget extends StatefulWidget {
  CustomTaskWidget({
    Key? key,
    required this.taskModel,
    required this.index,
  });

  final ToDoListModel taskModel;
  int index;

  @override
  _CustomTaskWidgetState createState() => _CustomTaskWidgetState();
}

class _CustomTaskWidgetState extends State<CustomTaskWidget> {
  String? formatDate;

  @override
  void initState() {
    super.initState();
    if (widget.taskModel.date != null) {
      // Convert the date to a formatted string
      formatDate = DateFormat('yyyy-MM-dd').format(widget.taskModel.date!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppConfig.kPrimaryColor.withOpacity(.3),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: () {
                  // Handle task completion toggle
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  decoration: BoxDecoration(
                    color: AppConfig.kPrimaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: .8),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 3),
                    child: Column(
                      children: [
                        Container(
                          height: 50.0,
                          width: 50.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppConfig.kPrimaryColor,
                                  width: 1.0,
                                ),
                                image: DecorationImage(
                                  image: widget.taskModel.imageData != null
                                      ? MemoryImage(widget.taskModel.imageData!)
                                      : AssetImage('assets/images/logo.png')
                                  as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          widget.taskModel.title.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(formatDate.toString()),
                  Text(widget.taskModel.time.toString()),
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(
                      TaskAdded(
                        currentTask: widget.taskModel,
                      ),
                    );
                  },
                  child: Icon(
                    Icons.edit,
                    color: Color(0xff7A7F7E),
                  ),
                ),
                SizedBox(
                  width: 22.0,
                ),
                InkWell(
                  onTap: () {
                    customDialog(
                        title: 'Are You sure?',
                        content: 'Want to delete this Task ',
                        leftOnTap: () {
                          Get.back();
                        },
                        rightOnTap: (() {
                          Get.back();
                          widget.taskModel.delete();
                        }));
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}


