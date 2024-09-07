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
import 'my_text_style.dart';

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
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppConfig.kPrimaryColor.withOpacity(.3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50.0,
                    width: 100.0,
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
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

                  const SizedBox(
                      width: 10), // Add spacing between image and text
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.taskModel.title.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
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
              const SizedBox(height: 5),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      'Date & time : ${formatDate ?? ''} ${widget.taskModel.time.toString()}'),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
