import 'package:auth/auth/view/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_field.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/primary_button.dart';
import '../widgets/shake_widget.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _shakeKey = GlobalKey<ShakeWidgetState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(('تم تسجيل الدخول بنجاح')),
        ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(('لم يتم العثور على مستخدم لهذا البريد الإلكتروني')),
          ));
          print('لم يتم العثور على مستخدم لهذا البريد الإلكتروني');
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(('كلمة المرور خاطئة أعد المحاولة')),
          ));
          print('كلمة المرور خاطئة أعد المحاولة');
        }
      } catch (e) {
        print('حدث خطأ أثناء إنشاء الحساب: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/signIn.gif',
                  height: 300,
                ),
              ),
              AuthField(
                controller: _emailController,
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'يرجى إدخال البريد الإلكتروني';
                  }
                  return null;
                },
                hintText: 'أدخل البريد الالكتروني',
              ),
              const SizedBox(height: 30),
              AuthField(
                controller: _passwordController,
                validator: (input) {
                  if (input!.length < 6) {
                    return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
                  }
                  return null;
                },
                hintText: 'أدخل كلمة السر',
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CustomTextButton(
                  onPressed: () {},
                  text: 'هل نسيت كلمة السر؟',
                ),
              ),
              const SizedBox(height: 20),
              ShakeWidget(
                key: _shakeKey,
                shakeOffset: 10.0,
                shakeDuration: const Duration(milliseconds: 500),
                child: PrimaryButton(
                  onTap: () {
                    login();
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                    } else {
                      _shakeKey.currentState?.shake();
                    }
                  },
                  text: 'تسجيل الدخول',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('ليس لديك حساب ؟'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpView(),
                        ),
                      );
                    },
                    child: const Text('إنشاء حساب'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
