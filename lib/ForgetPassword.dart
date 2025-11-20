// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'User Authentication.dart';

class forgetPassword extends StatefulWidget {
  @override
  forgetPassword({super.key});
  State<forgetPassword> createState() => forgetPasswordState();
}

class forgetPasswordState extends State<forgetPassword> {
  final TextEditingController _emailCtlr = TextEditingController();
  final EmailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  final _formKey = GlobalKey<FormState>();
  UserAuthentication _auth = UserAuthentication();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  "Enter your registered email",
                  style: TextStyle(color: Colors.black45),
                  textAlign: .center,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailCtlr,
                  validator: (value) {
                    if (!EmailRegex.hasMatch(value!)) {
                      return "Required field*";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text("Email"),
                    labelStyle: TextStyle(color: Colors.black45),
                    floatingLabelStyle: TextStyle(color: Colors.lightBlue),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                  ),
                  cursorColor: Colors.lightBlue,
                  cursorErrorColor: Colors.lightBlue,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    _auth.resetPassword(_emailCtlr.text);
                    Fluttertoast.showToast(msg: "Link is sent to your email");
                  },
                  child: Text("Send"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
