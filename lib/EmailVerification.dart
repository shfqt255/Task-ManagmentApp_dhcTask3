import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_management_app/TodoList.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});
  @override
  State<EmailVerification> createState() => EmailVerificationState();
}

class EmailVerificationState extends State<EmailVerification> {
  User? user = FirebaseAuth.instance.currentUser;
  Future<void> verifyEmail() async {
    await user?.reload();
     user = FirebaseAuth.instance.currentUser;
    if (user != null && user!.emailVerified) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ToDoList()),
      );
    } else if (!user!.emailVerified) {
      Fluttertoast.showToast(
        msg: "Email is not Verified! Please Verify Your email",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify Email"),
      backgroundColor: Colors.lightBlue,
      foregroundColor: Colors.white,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Column(
            children: [
                        Text("Verify Your email and come back!"),
                        SizedBox(height: 20,),
                         TextButton(
                onPressed: () => verifyEmail(),
                    
                      child: Text(
                        "NEXT",
                        style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold),
                      ),),
                    ],
                  ),
        ),)
        );
  }
}
