import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  late final String uid;
  String get getUid => uid;

  Future signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      uid = user!.uid;
      print(uid);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      uid = user!.uid;
      print(uid);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOutWithEmail() async {
    return firebaseAuth.signOut();
  }

  Future signUpWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential = await firebaseAuth.signInWithCredential(authCredential);

      User? user = userCredential.user;
      uid = user!.uid;
      print(uid);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOutWithGmail() async {
    return googleSignIn.signOut();
  }
}
