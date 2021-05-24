import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<User?> createUser(String email, String password) async {
    var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  Future<User?> signIn(String email, String password) async {
    var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }
}
