import 'package:auth/auth/view/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/shake_widget.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _shakeKey = GlobalKey<ShakeWidgetState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void createNewUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      try {
        /// هذا السطر يقوم باخذ الايميل والباسورد من الحقول وارسالهم الى قاعدة البيانات تبع المستخدم في الفايربيس
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        print('تم إنشاء حساب بنجاح: ${userCredential.user?.email}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(('تم انشاء الحساب بنجاح')),
        ));
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(('الحساب موجود مسبقاً ')),
          ));
        } else if (ex.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(('كلمة المرور ضعيفة للغاية')),
          ));
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
                  'assets/signUp.gif',
                  height: 300,
                ),
              ),
              AuthField(
                controller: _nameController,
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'يرجى إدخال الاسم';
                  }
                  return null;
                },
                hintText: 'أدخل أسمك',
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 20),
              ShakeWidget(
                key: _shakeKey,
                shakeOffset: 10.0,
                shakeDuration: const Duration(milliseconds: 500),
                child: PrimaryButton(
                  onTap: () {
                    createNewUser();
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                    } else {
                      _shakeKey.currentState?.shake();
                    }
                  },
                  text: 'إنشاء حساب',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('هل لديك حساب ؟'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInView(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text('سجل دخول'),
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
