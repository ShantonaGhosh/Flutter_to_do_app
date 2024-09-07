import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/widget/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:flutter_to_do_app/widget/custom_button.dart';
import 'package:flutter_to_do_app/widget/custom_text_field.dart';
import 'package:flutter_to_do_app/view/home_screen.dart';

class LogInScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _isObscure = true.obs;
  var loginData = Hive.box('login');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Flexible(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: size.width * 0.40,
                        child: Image.asset(
                          'assets/images/logo.png',
                          // color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        lebelText: "User email",
                        hintText: "Type here your email",
                        validatorText: "Enter a valid email",
                        prefixIcon: const Icon(Icons.email_outlined),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          String pattern = r'^[^@]+@[^@]+\.[^@]+$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Obx(
                            () => CustomTextField(
                          controller: _passwordController,
                              lebelText: "Password",
                          hintText: "Type here your password",
                          validatorText: "Enter a valid password",
                          obscureText: _isObscure.value,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _isObscure(!_isObscure.value);
                            },
                            child: Icon(
                              _isObscure.value == false
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      CustomButton(
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_formKey.currentState!.validate()) {
                            loginData.clear();
                            loginData.put('userEmail', _emailController.text);
                            loginData.put('userPass', _passwordController.text);
                            customSnackBar(bgClr: Colors.green, msg: 'Login Successfully');
                            Get.to(HomeScreen());
                          }
                        },
                        title: "LOGIN",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
