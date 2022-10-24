import 'package:firebase_auth/firebase_auth.dart';

class FireauthService {
  
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// ================================================================= Sign In
  static Future<UserCredential> signIn({required String email, required String password}) async {
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }

  /// ================================================================= Sign Up
  static Future<UserCredential> signUp({required String email, required String password}) async {
    UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }

  /// ================================================================= Sign Out
  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
