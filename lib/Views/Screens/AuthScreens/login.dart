import 'package:flutter/material.dart';
import 'package:flutter_test_project/Utils/Colors/colors.dart';

import 'package:flutter_test_project/Views/Screens/AuthScreens/signup.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Providers/AuthProvider/auth_provider.dart';
import '../../../common/widgets/custom_button/custom_button.dart';
import '../../../common/widgets/custom_textform/custom_textform.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColors.myblue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            height: 100,
            child: const Center(
                child: Text(
              'Welcome Back',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Baloo2'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.login_rounded,
                              size: 35,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.person),
                          controller: username,
                          labelText: 'username',
                          suffixIcon: TextButton(
                              onPressed: () {
                                username.clear();
                              },
                              child: const Icon(
                                Icons.cancel,
                                color: AppColors.myblue,
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'username is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.lock),
                          controller: password,
                          labelText: 'password',
                          isPassword: true,
                          suffixIcon: TextButton(
                              onPressed: () {
                                password.clear();
                              },
                              child: const Icon(
                                Icons.cancel,
                                color: AppColors.myblue,
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          label: 'Login',
                          loading: authProvider.loading,
                          onPressed:
                              // () {
                              //   Get.to(const BottomNav());
                              // },
                              authProvider.loading
                                  ? () {}
                                  : () async {
                                      if (_formkey.currentState!.validate()) {
                                        await authProvider.loginUser(
                                            username.text, password.text);
                                      }
                                    },
                          color: AppColors.myblue,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Dont have an account?',
                              style: TextStyle(fontSize: 14),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.to(const SignupScreen());
                                },
                                child: const Text(
                                  'SignUp',
                                  style: TextStyle(
                                      color: AppColors.myblue, fontSize: 16),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
