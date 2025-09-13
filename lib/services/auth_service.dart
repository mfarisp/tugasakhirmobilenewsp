import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mendapatkan user saat ini (null jika belum login)
  User? get currentUser => _auth.currentUser;

  // Register user baru dengan email, password, dan nama
  Future<User?> register(String email, String password, String name) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Simpan data tambahan user ke Firestore
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'email': email,
        'name': name,
        'role': 'user', // default role user, bisa ubah sesuai kebutuhan
      });

      return cred.user;
    } catch (e) {
      rethrow;
    }
  }

  // Login dengan email dan password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } catch (e) {
      rethrow;
    }
  }

  // Logout user saat ini
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Ambil role user dari Firestore berdasarkan userId
  Future<String?> getUserRole(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['role'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
