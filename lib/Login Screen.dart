// ignore_for_file: camel_case_types, prefer_final_fields, non_constant_identifier_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/ForgetPassword.dart';
import 'package:task_management_app/TodoList.dart';
import 'User Authentication.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});
  @override
  State<sign_in> createState() => sign_inState();
}

class sign_inState extends State<sign_in> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final UserAuthentication _userAuthentication = UserAuthentication();
  Future<User?> SignIn() async {
    return await _userAuthentication.SignIn(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => forgetPassword(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password? ',
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      User? user = await SignIn();
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ToDoList()),
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
                  child: Text("Log In"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
