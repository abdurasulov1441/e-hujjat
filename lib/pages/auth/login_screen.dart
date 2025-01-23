import 'package:e_hujjat/app/router.dart';
import 'package:e_hujjat/common/helpers/request_helper.dart';
import 'package:e_hujjat/db/cache.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:e_hujjat/common/style/app_colors.dart';
import 'package:e_hujjat/common/style/app_style.dart';
import 'package:go_router/go_router.dart';

import 'package:postgres/postgres.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> login() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      final response = await requestHelper.post(
          '/api/auth/login',
          {
            'username': emailController.text.trim(),
            "password": passwordController.text.trim(),
          },
          log: true);
      if (response['accessToken'] != null && response['refreshToken'] != null) {
        cache.setString('user_token', response['accessToken']);
        cache.setString('refresh_token', response['refreshToken']);
        cache.setInt('user_role', response['user']['role_id']);
        cache.setString('photo', response['user']['photo']);
        cache.setString('first_name', response['user']['first_name']);
        cache.setString('surname', response['user']['surname']);
        cache.setString('last_name', response['user']['last_name']);
        switch (response['user']['role_id']) {
          case 1:
            router.go(Routes.kotibiyatPage);

            break;
          case 2:
            print('userrrrrrrrrrrrr');
            break;
          case 3:
            print('hodimmmmmmmmmmmmmmmm');
            break;
          default:
            print('defolt');
        }
      } else {
        String status = response['message'];
        ElegantNotification.success(
          width: 360,
          isDismissable: false,
          animationCurve: Curves.easeInOut,
          position: Alignment.topCenter,
          animation: AnimationType.fromTop,
          title: Text('Xatolik'),
          description: Text(status),
          onDismiss: () {},
          onNotificationPressed: () {},
          shadow: BoxShadow(
            color: Colors.green,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ).show(context);
      }
    } catch (error) {
      ElegantNotification.success(
        width: 360,
        isDismissable: false,
        animationCurve: Curves.easeInOut,
        position: Alignment.topCenter,
        animation: AnimationType.fromTop,
        title: Text('Xatolik'),
        description: Text(error.toString()),
        onDismiss: () {},
        onNotificationPressed: () {},
        shadow: BoxShadow(
          color: Colors.green,
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 4),
        ),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text('Xush kelibsiz!',
                      style: AppStyle.fontStyle
                          .copyWith(fontSize: 28, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text('Tizimga kirishingiz mumkin',
                      style: AppStyle.fontStyle),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 400,
                  height: 400,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hoverColor: AppColors.hoverColor,
                          filled: true,
                          fillColor: AppColors.foregroundColor,
                          hintText: 'Login',
                          hintStyle: AppStyle.fontStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Loginni kiriting';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: isHiddenPassword,
                        decoration: InputDecoration(
                          hoverColor: AppColors.hoverColor,
                          filled: true,
                          fillColor: AppColors.foregroundColor,
                          hintText: 'Parol',
                          hintStyle: AppStyle.fontStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isHiddenPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.iconColor,
                            ),
                            onPressed: togglePasswordView,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Parolni kiriting';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.iconColor,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Kirish',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
