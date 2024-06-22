import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepo {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Something went wrong!';
    } catch (e) {
      throw e;
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String username, // Tambahkan parameter username
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Simpan username ke Firestore
      await _firestore.collection('users').doc(_auth.currentUser?.uid).set({
        'username': username,
        'email': email,
      });
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Something went wrong!';
    } catch (e) {
      throw e;
    }
  }
}
