import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/globals/colors.dart';
import 'package:flutter_firebase_auth/globals/common.dart';
import 'package:flutter_firebase_auth/ui/screens/login.dart';
import 'package:flutter_firebase_auth/ui/widgets/login_card.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _pwdCtrl = TextEditingController();

  void _signupWithEmailPassword() async {
    try {
      final credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailCtrl.text, password: _pwdCtrl.text);
      final user = credentials.user;
      if (user == null) {
        if (mounted) {
          showSnackBar(
              context, "Some error occured in creating user. Try again.", null);
        }
      } else {
        if (mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (cxt) => const Login()));
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        showSnackBar(context, "Password is too weak", null);
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(
            context, "The account already exists for that email.", null);
      } else {
        showSnackBar(context, e.code, null);
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Some error occured", null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(top: 100, bottom: 30, left: 20, right: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hello!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGrey1),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Welcome to the app!",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGrey1),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _emailCtrl,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter email',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _pwdCtrl,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Password',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: _signupWithEmailPassword,
              child: Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                margin: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.red,
                ),
                child: const Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              margin: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 15, right: 15),
              child: const Center(
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      'Or continue with',
                      style: TextStyle(
                        color: AppColors.darkGrey1,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LoginCard(
                    onTap: null,
                    imgPath: 'assets/images/email.png',
                  ),
                  LoginCard(
                    onTap: null,
                    imgPath: 'assets/images/google.png',
                  ),
                  LoginCard(
                    onTap: null,
                    imgPath: 'assets/images/phone.png',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      'Already a member? Login now',
                      style: TextStyle(
                        color: AppColors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
