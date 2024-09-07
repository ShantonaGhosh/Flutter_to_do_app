 import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/view/home_screen.dart';
import 'package:flutter_to_do_app/view/splash_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';

import 'model/to_do_list_model.dart';
late Size screenSize;
Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) async {
    if (value) {
      await Permission.notification.request();
    }
  });
  await Hive.initFlutter();
  Hive.registerAdapter<ToDoListModel>(ToDoListModelAdapter());
  await Hive.openBox<ToDoListModel>('task');
  await Hive.openBox('login');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter To Do App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

