import 'package:firebase_auth/firebase_auth.dart';
import 'package:fashion_app/main.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instanceFor(app: app);

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get AuthStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}