import 'package:e_hujjat/app/router.dart';
import 'package:e_hujjat/common/db/cache.dart';
import 'package:e_hujjat/common/helpers/request_helper.dart';
import 'package:e_hujjat/common/socket_service.dart';
import 'package:e_hujjat/common/style/app_colors.dart';
import 'package:e_hujjat/common/style/app_style.dart';
import 'package:e_hujjat/common/utils/toats/error.dart';
import 'package:e_hujjat/common/utils/toats/succes.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

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

  final socketIOService = SocketIOService();
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
        cache.setInt('user_id', response['user']['id']);
        String status = response['message'];
        socketIOService.connect(response['user']['id']);
        showSuccessToast(context, 'Muvofaqiyatli', status);

        cache.setInt('user_id', response['user']['id']);
        socketIOService.connect(response['user']['id']);
        await windowManager.hide();
        await windowManager.setSkipTaskbar(true);

        router.go(Routes.home);
      } else {
        String status = response['message'];
        showSuccessToast(context, 'Xatolik', status);
      }
    } catch (error) {
      showErrorToast(context, 'Xatolik', error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final userToken = cache.getInt('user_id');
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
                  child: Text(
                    'Xush kelibsiz!',
                    style: AppStyle.fontStyle.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Tizimga kirishingiz mumkin',
                    style: AppStyle.fontStyle.copyWith(
                      fontSize: 16,
                      color: AppColors.textColor,
                    ),
                  ),
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
                          hoverColor: AppColors.uiText,
                          filled: true,
                          fillColor: AppColors.ui,
                          hintText: 'Login',
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
                          hoverColor: AppColors.uiText,
                          filled: true,
                          fillColor: AppColors.ui,
                          hintText: 'Parol',
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
