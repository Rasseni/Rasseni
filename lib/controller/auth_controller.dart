import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/local_db.dart';
import '../services/firebase_service.dart';
import '../view/authentication/signup_proccess/auth_profile.dart';
import '../view/shared/bottom_nav_bar.dart';

import 'user_data_controller.dart';

class AuthController extends ChangeNotifier {
  final _firebaseService = FirebaseService();

  final _userDataController = UserDataController();

  SqlDb _sqlDb = SqlDb.instance;

  String? _email;
  String? _password;
  String? _userIdFirstTime;
  String? _userId;

  bool _isPasswordHidden = true;

  // Getters
  String? get email => _email;
  String? get password => _password;
  String? get userId => _userId;

  bool get isPasswordHidden => _isPasswordHidden;

  // Setters

  void setUserId() {
    _userId = _userDataController.id;
  }

  void setEmail(String email) {
    _email = email;
    print(email);
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    print(password);
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }

  // Register user
  Future<void> registerUser(
    BuildContext context,
  ) async {
    print('Email: $_email, Password: $_password');
    try {
      final user = await _firebaseService.register(
        email: _email!,
        password: _password!,
      );
      if (user != null) {
        _userIdFirstTime = user.uid;
        await _firebaseService.saveUserData(
          email: _email,
        );
        _sqlDb.insertUser({
          'id': _userIdFirstTime,
          "email": email,
          "firstName": "Restart",
          "lastName": "App 😘",
          "profilePic": "",
        });

        showSnackBar(context, 'Registration successful!');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AuthProfile()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Authentication errors
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already in use by another account.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Signup with email and password is not enabled.';
          break;
        case 'weak-password':
          errorMessage =
              'The password is too weak. Please choose a stronger one.';
          break;
        default:
          errorMessage = 'An unknown error occurred. Please try again later.';
      }
      showSnackBar(context, errorMessage);
    } catch (e) {
      // Handle general errors
      showSnackBar(context, 'An error occurred: ${e.toString()}');
    }
  }

  Future<void> saveUserData(
      {required String firstName,
      required String lastName,
      required BuildContext context}) async {
    _firebaseService.saveUserData(
      firstName: firstName,
      lastName: lastName,
    );
    _sqlDb.updateUser(
      {
        "firstName": firstName,
        "lastName": lastName,
      },
    );
    await _userDataController.loadUserData();
    showSnackBar(context, 'Register successful!');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
      (route) => false, // Removes all previous routes
    );
  }

  // Login User
  Future<void> loginUser(BuildContext context) async {
    try {
      final user = await _firebaseService.loginUser(
        email: _email!,
        password: _password!,
      );
      if (user != null) {
        _userId = user.uid;
        // Fetch user data and save to SharedPreferences
        await fetchUserData();

        showSnackBar(context, 'Login successful!');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
          (route) => false, // Removes all previous routes
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Authentication errors
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-disabled':
          errorMessage = 'This user account has been disabled.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email address.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        default:
          errorMessage = 'Incorrect password. Please try again.';
      }
      showSnackBar(context, errorMessage);
    } catch (e) {
      // Handle general errors
      showSnackBar(context, 'An error occurred: ${e.toString()}');
    }
  }

  // Fetch data from Firestore
  Future<void> fetchUserData() async {
    try {
      final data = await _firebaseService.getUserProfile();
      final email = data['email'] as String?;
      final firstName = data['firstName'] as String?;
      final lastName = data['lastName'] as String?;

      // Update Local Storage
      _sqlDb.insertUser({
        'id': _userId,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
      });
      notifyListeners();

      // Update ProfileController
      // profileController.setFirstName(firstName ?? '');
      // profileController.setLastName(lastName ?? '');
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      throw e;
    }
  }

  Future<void> logoutUser() async {
    await _firebaseService.logoutUser();
    await _sqlDb.deleteMyDatabase();
    notifyListeners();
  }

  // Change User Name
  Future<void> updateUserName(String firstName, String lastName) async {
    try {
      await _firebaseService.updateUserName(
        firstName: firstName,
        lastName: lastName,
      );
      // Update Local Storage
      _sqlDb.updateUser(
        {
          "firstName": firstName,
          "lastName": lastName,
        },
      );
      _userDataController.updateName(firstName, lastName);
    } catch (e) {
      debugPrint('=================== Error updating user name: $e');
      throw e;
    }
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      _firebaseService.resetPassword(email: email);
      showSnackBar(context,
          'Password reset email sent to $email. Please check your inbox.');
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific exceptions
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email address.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address entered is invalid.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again later.';
      }
      showSnackBar(context, errorMessage);
    } catch (e) {
      // Handle any other errors
      showSnackBar(context, 'An unexpected error occurred: ${e.toString()}');
    }
  }

  // Helper for Snack Bar
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green,
      ),
    );
  }
}
