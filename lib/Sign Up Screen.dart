// ignore_for_file: camel_case_types, prefer_final_fields, non_constant_identifier_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'EmailVerification.dart';
import 'package:task_management_app/Login%20Screen.dart';
import 'User Authentication.dart';

class sign_up extends StatefulWidget {
  const sign_up({super.key});
  @override
  State<sign_up> createState() => sign_upState();
}

class sign_upState extends State<sign_up> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final UserAuthentication _userAuthentication = UserAuthentication();
  Future<User?> SignUp() async {
    return await _userAuthentication.SignUp(
      _emailController.text,
      _passwordController.text,
    );
  }

  final _formKey = GlobalKey<FormState>();
  final EmailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign up to get started! ",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "Fill in your information to access all features.",
                  style: TextStyle(fontSize: 15, color: Colors.black45),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email required*";
                    }
                    if (!EmailRegex.hasMatch(value)) {
                      return "Enter valid email";
                    } else {
                      return null; // This Statement purpose is to remove the warning.
                    }
                  },
                  decoration: InputDecoration(
                    label: Text("Email"),
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    floatingLabelStyle: TextStyle(color: Colors.lightBlue),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                  ),
                  cursorColor: Colors.black45,
                  cursorErrorColor: Colors.black45,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password required*";
                    } else if (value.length < 8) {
                      return "Password should not be less than 8 characters";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    label: Text("Password"),
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    floatingLabelStyle: TextStyle(color: Colors.lightBlue),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                  ),
                  cursorColor: Colors.black45,
                  cursorErrorColor: Colors.black45,
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      User? user = await SignUp();
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmailVerification(),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text("Get Started"),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                
                  Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => sign_in()),
                    );
                  },
                  child: Text(
                    "LogIn",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),]
          ),
        ),
      ),)
    );
  }
}
