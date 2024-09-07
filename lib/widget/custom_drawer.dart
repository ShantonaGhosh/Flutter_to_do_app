import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../view/auth/login_screen.dart';
import 'custom_list_button.dart';
import 'custom_snackbar.dart';
import 'my_text_style.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    super.key,
    this.children,
  });
  List<Widget>? children = const <Widget>[];
  final GlobalKey<ScaffoldState> _drawerScaffoldKey =
      GlobalKey<ScaffoldState>();

  var loginData = Hive.box('login');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: _drawerScaffoldKey,
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: const BoxDecoration(),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  fit: BoxFit.fitWidth,
                ),
              ),
          
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: children ??
                      [
                        CustomListButton(
                          onTap: () {
                            Get.back();
                          },
                          title: "Home",
                          icon: Icons.home_outlined,
                        ),
                        CustomListButton(
                          onTap: () async {
                            await loginData.clear();
                            customSnackBar(
                                bgClr: Colors.green, msg: 'Successfully Log Out');
                            Get.offAll(LogInScreen());
                          },
                          title: "Log Out",
                          icon: Icons.login_outlined,
                        ),
                      ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
