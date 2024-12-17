import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register
  Future<User?> register({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // Send email verification
  Future<void> emailVerification() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw Exception('User not logged in');
    }
  }

  // Save or Update User Data
  Future<void> saveUserData({
    String? email,
    String? firstName,
    String? lastName,
  }) async {
    try {
      String userId = _auth.currentUser!.uid;

      final data = <String, dynamic>{};
      if (email != null && email.isNotEmpty) data['email'] = email;
      if (firstName != null && firstName.isNotEmpty)
        data['firstName'] = firstName;
      if (lastName != null && lastName.isNotEmpty) data['lastName'] = lastName;

      await _firestore
          .collection('users')
          .doc(userId)
          .set(data, SetOptions(merge: true));
      print("Data saved successfully");
    } catch (e) {
      throw Exception('Error saving user data: $e');
    }
  }

  // Get user data from Firestore
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      String userId = user.uid;
      final doc = await _firestore.collection('users').doc(userId).get();

      if (doc.exists) {
        return doc.data() ?? {};
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Error fetching user profile: $e');
    }
  }

  // Update User Name
  Future<void> updateUserName({
    required String firstName,
    required String lastName,
  }) async {
    try {
      String userId = _auth.currentUser!.uid;

      await _firestore.collection('users').doc(userId).update({
        'firstName': firstName,
        'lastName': lastName,
      });
      print('User name updated successfully');
    } catch (e) {
      throw Exception('Error updating user name: $e');
    }
  }

  // Login
  Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Logout
  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  // Forget Password
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent');
    } catch (e) {
      throw Exception('Error sending password reset email: $e');
    }
  }
}
