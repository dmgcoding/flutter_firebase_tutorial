import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/globals/colors.dart';
import 'package:flutter_firebase_auth/globals/common.dart';
import 'package:flutter_firebase_auth/ui/screens/home.dart';
import 'package:flutter_firebase_auth/ui/screens/phone_auth.dart';
import 'package:flutter_firebase_auth/ui/screens/register.dart';
import 'package:flutter_firebase_auth/ui/widgets/login_card.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void _signinAnnonymously() async {
    try {
      final credentials = await FirebaseAuth.instance.signInAnonymously();
      final user = credentials.user;
      if (user != null) {
        if (mounted) {
          showSnackBar(context, "Successfully logged in", null);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (cxt) => Home(user)),
              (route) => false);
        }
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "some error occured", null);
    }
  }

  void _googleSignin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? gAuth =
          await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken,
        idToken: gAuth?.idToken,
      );
      final firebaseCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = firebaseCredential.user;
      if (user == null) {
        if (mounted) {
          showSnackBar(context, "some error occured", null);
        }
      } else {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (cxt) => Home(user)),
              (route) => false);
        }
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "some error occured", null);
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
                      'Hello Again!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGrey1),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Welcome back. You've been missed!",
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
            const Padding(
              padding: EdgeInsets.only(top: 0, bottom: 16, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Recover password",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGrey1),
                  ),
                ],
              ),
            ),
            InkWell(
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
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: _signinAnnonymously,
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
                    'Sign in annonymously',
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const LoginCard(
                    onTap: null,
                    imgPath: 'assets/images/email.png',
                  ),
                  LoginCard(
                    onTap: _googleSignin,
                    imgPath: 'assets/images/google.png',
                  ),
                  LoginCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (cxt) => const PhoneAuth()));
                    },
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      'Not a member? Register now',
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
