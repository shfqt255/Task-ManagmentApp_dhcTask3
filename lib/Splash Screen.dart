import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipOval(
                child: Image.asset(
                  "assets/Splash.jpeg",
                  width: 270,
                  height: 260,

                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              "Welcome!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("Task Management App", style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
