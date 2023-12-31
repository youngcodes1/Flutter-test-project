import 'package:flutter/material.dart';
import 'package:flutter_test_project/Providers/AuthProvider/auth_provider.dart';
import 'package:flutter_test_project/Views/Screens/AuthScreens/login.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Utils/Colors/colors.dart';
import '../../../common/widgets/custom_button/custom_button.dart';
import '../../../common/widgets/custom_textform/custom_textform.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirm.dispose();
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
              'New User?',
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
                            Icon(
                              Icons.person,
                              size: 35,
                            ),
                            Text(
                              'SIGNUP',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Baloo2'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.person),
                          controller: username,
                          labelText: 'Username',
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
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.lock),
                          controller: confirm,
                          isPassword: true,
                          labelText: 'Confirm password',
                          suffixIcon: TextButton(
                              onPressed: () {
                                confirm.clear();
                              },
                              child: const Icon(
                                Icons.cancel,
                                color: AppColors.myblue,
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'confirm password is required';
                            }
                            if (value != password.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          label: 'SignUp',
                          loading: authProvider.loading,
                          onPressed: authProvider.loading
                              ? () {}
                              : () async {
                                  if (_formkey.currentState!.validate()) {
                                    await authProvider.signupUser(
                                        username.text, password.text);
                                    _formkey.currentState?.reset();
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
                              'Already have an account?',
                              style: TextStyle(fontSize: 14),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.to(const LoginScreen());
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: AppColors.myblue, fontSize: 16),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
