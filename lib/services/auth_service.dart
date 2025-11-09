import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
    return result.user;
  }

  // Register with email and password
  Future<User?> register(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    notifyListeners();
    return result.user;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
