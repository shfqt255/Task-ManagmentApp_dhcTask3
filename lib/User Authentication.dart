import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserAuthentication {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> SignUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      user?.sendEmailVerification();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? "An Error occurred");
    }
    return null;
  }

  Future<User?> SignIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? "An Error occurred");
    }
    return null;
  }

  Future<void> resetPassword(String email) async {
    try {
         await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? "");
    }
 
  }

  Future<void> Logout() async {
        try {
       _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? "");
    }
   
  }
}
