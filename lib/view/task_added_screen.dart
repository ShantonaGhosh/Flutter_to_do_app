import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/widget/custom_appbar.dart';
import 'package:flutter_to_do_app/widget/custom_button.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_to_do_app/model/to_do_list_model.dart';
import 'package:flutter_to_do_app/utils/app_config.dart';
import 'package:flutter_to_do_app/widget/custom_snackbar.dart';
import 'package:flutter_to_do_app/widget/custom_text_field.dart';
import 'package:image_filter_pro/named_color_filter.dart';
import 'package:image_filter_pro/photo_filter.dart';

import 'home_screen.dart';

class TaskAdded extends StatefulWidget {
  TaskAdded({super.key, required this.currentTask});
  ToDoListModel? currentTask;

  @override
  State<TaskAdded> createState() => _TaskAddedState();
}

class _TaskAddedState extends State<TaskAdded> {
  late TextEditingController _titleController;
  late TextEditingController _dueTimeController;
  late TextEditingController _dateController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _image = ''.obs;
  File? imageData;
  File _getFileFromUint8List(Uint8List uint8List) {
    final directory = Directory.systemTemp; // Use a suitable directory
    final file =
        File('${directory.path}/temp_image.png'); // Use a suitable filename
    file.writeAsBytesSync(uint8List);
    return file;
  }

  String? formatDate;
  @override
  void initState() {
    super.initState();
    if (widget.currentTask?.date != null) {
      formatDate = DateFormat('yyyy-MM-dd').format(widget.currentTask!.date!);
    } else {
      formatDate = ''; // or any default value
    }

    _titleController = TextEditingController(text: widget.currentTask?.title);
    _dueTimeController = TextEditingController(text: widget.currentTask?.time);
    _dateController = TextEditingController(text: formatDate.toString());

    if (widget.currentTask?.imageData != null) {
      imageData = _getFileFromUint8List(widget.currentTask!.imageData!);
      _image(imageData!.path);
    }
  }

  Future<void> _pickImage({required ImageSource source}) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      imageData = File(pickedImage.path);
      var updatedImage = await _applyFilter(imageData!);
      if (updatedImage != null) {
        _image(updatedImage.path);
        imageData = updatedImage;
      }
    } else {
      imageData = null;
    }
  }

  Future<File?> _applyFilter(File image) async {
    var updatedImage = await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => PhotoFilter(
          image: image,
          presets: const [
            NamedColorFilter(
              name: "No Filter",
              colorFilterMatrix: [
                1,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
              ],
            ),
            NamedColorFilter(
              name: "Sepia",
              colorFilterMatrix: [
                0.393,
                0.769,
                0.189,
                0,
                0,
                0.349,
                0.686,
                0.168,
                0,
                0,
                0.272,
                0.534,
                0.131,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
              ],
            ),
            NamedColorFilter(
              name: "Grayscale",
              colorFilterMatrix: [
                0.33,
                0.33,
                0.33,
                0,
                0,
                0.33,
                0.33,
                0.33,
                0,
                0,
                0.33,
                0.33,
                0.33,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
              ],
            ),
            // Add more filters as needed
          ],
          cancelIcon: Icons.cancel,
          applyIcon: Icons.check,
          backgroundColor: Colors.black,
          sliderColor: Colors.blue,
          sliderLabelStyle: TextStyle(color: Colors.white),
          bottomButtonsTextStyle: TextStyle(color: Colors.white),
          presetsLabelTextStyle: TextStyle(color: Colors.white),
          applyingTextStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
    return updatedImage as File?;
  }

  Future<dynamic> _imageChooseOption(BuildContext context) async {
    return Get.bottomSheet(
      Container(
        height: 140.0,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              onTap: () async {
                await _pickImage(source: ImageSource.camera);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
            ),
            ListTile(
              onTap: () async {
                await _pickImage(source: ImageSource.gallery);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dueTimeController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Task Added',
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppConfig.kSecondaryColor,
            )),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Obx(
                () => Container(
                  height: 142,
                  width: 142.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 0.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 2.0,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: _image.value.isEmpty
                      ? GestureDetector(
                          onTap: () async {
                            _imageChooseOption(context);
                          },
                          child: const Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 20,
                            color: Colors.grey,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(File(_image.value)),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _image('');
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextField(
                controller: _titleController,
                hintText: "Type here your task title",
                validatorText: 'Please type somethings here...',
                textInputAction: TextInputAction.next,
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextField(
                controller: _dueTimeController,
                hintText: "Type here your task time",
                textInputAction: TextInputAction.next,
                validatorText: 'Please select time...',
                suffixIcon: IconButton(
                    onPressed: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        final now = DateTime.now();
                        final pickedDateTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );

                        String formattedTime =
                            DateFormat('hh:mm').format(pickedDateTime);

                        _dueTimeController.text = formattedTime;
                      }
                    },
                    icon: const Icon(
                      Icons.access_time,
                      color: AppConfig.kPrimaryColor,
                    )),
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextField(
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());

                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 10),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    _dateController.text = formattedDate.toString();
                  }
                },
                controller: _dateController,
                hintText: 'Select Date',
                validatorText: 'Please select date...',
                suffixIcon: const Icon(
                  Icons.calendar_month_sharp,
                  color: AppConfig.kPrimaryColor,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              CustomButton(
                onTap: () async {
                  Box<ToDoListModel> taskBox = Hive.box<ToDoListModel>('task');
                  Uint8List? imageBytes;
                  if (imageData != null) {
                    imageBytes = await imageData!.readAsBytes();
                  }
                  DateTime? taskDate;
                  if (_dateController.text.isNotEmpty) {
                    taskDate =
                        DateFormat('yyyy-MM-dd').parse(_dateController.text);
                  }

                  var newTask = ToDoListModel(
                    title: _titleController.text.trim(),
                    time: _dueTimeController.text.trim(),
                    date: taskDate,
                    imageData: imageBytes,
                  );

                  if (_formKey.currentState?.validate() ?? false) {
                    customSnackBar(
                      bgClr: Colors.green,
                      msg: 'Task saved successfully',
                    );

                    if (widget.currentTask != null) {
                      // Update the current task
                      widget.currentTask!.title = newTask.title;
                      widget.currentTask!.time = newTask.time;
                      widget.currentTask!.date = newTask.date;
                      widget.currentTask!.imageData = newTask.imageData;

                      // Save changes
                      await widget.currentTask!.save();
                    } else {
                      // Add new task
                      await taskBox.add(newTask);
                    }

                    // Navigate to HomeScreen
                    Get.to(HomeScreen());
                  } else {
                    customSnackBar(
                      bgClr: Colors.red,
                      msg: 'Please fill all required fields',
                    );
                  }
                },
                title:
                    widget.currentTask == null ? 'Task Added' : 'Task Update',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
