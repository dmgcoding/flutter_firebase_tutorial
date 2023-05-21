import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/globals/colors.dart';
import 'package:flutter_firebase_auth/ui/screens/login.dart';
import 'package:flutter_firebase_auth/ui/screens/phone_auth.dart';

class Home extends StatefulWidget {
  final User? user;
  const Home(this.user, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.darkGrey2, width: 2),
                image: const DecorationImage(
                  image: AssetImage('assets/images/profile_default.jpg'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Text(
                'User id: ${widget.user!.uid}',
                style: const TextStyle(
                  color: AppColors.darkGrey2,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Text(
                'User email: ${widget.user!.email}',
                style: const TextStyle(
                  color: AppColors.darkGrey2,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (cxt) => const Login()));
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: AppColors.red,
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
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
