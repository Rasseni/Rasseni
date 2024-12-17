// import 'dart:convert'; // For Base64 encoding/decoding
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../services/firebase_service.dart';
// import '../services/local_db.dart';

// class ProfileController extends ChangeNotifier {
//   final FirebaseService _firebaseService = FirebaseService();
//   final SqlDb _sqlDb = SqlDb();
//   String? _firstName;
//   String? _lastName;
//   File? _profileImage;

//   // Getters
//   String? get firstName => _firstName;
//   String? get lastName => _lastName;
//   File? get profileImage => _profileImage;

//   // Setters
//   void setFirstName(String name) async {
//     _firstName = name;


//     // await _sqlDb.insertUser({
//     //   'id': userId,
//     //   // Add other user details here if necessary
//     // }, imageBytes);
//     notifyListeners();
//   }

//   void setLastName(String name) async {
//     _lastName = name;
//     _saveToPreferences('last_name', name);
//     await _updateFirestoreProfile();
//     notifyListeners();
//   }

//   Future<void> _updateFirestoreProfile() async {
//     if (_firstName != null && _lastName != null) {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         try {
//           await FirebaseFirestore.instance
//               .collection('users')
//               .doc(user.uid)
//               .update({
//             'firstName': _firstName,
//             'lastName': _lastName,
//           });
//         } catch (e) {
//           debugPrint('Error updating Firestore profile: $e');
//         }
//       }
//     }
//   }

//   Future<void> _saveToPreferences(String key, String value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(key, value);
//   }

//   Future<void> loadFromPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     _firstName = prefs.getString('first_name');
//     _lastName = prefs.getString('last_name');
//     notifyListeners();
//   }

//   void clearProfile() async {
//     _firstName = null;
//     _lastName = null;
//     _profileImage = null;

//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();

//     notifyListeners();
//   }

//   ProfileController() {
//     debugPrint("ProfileController Constructor Called");
//     initialize();
//   }
//   // Initialization method
//   Future<void> initialize() async {
//     final prefs = await SharedPreferences.getInstance();

//     _firstName = prefs.getString('first_name');
//     _lastName = prefs.getString('last_name');

//     debugPrint(
//         "ProfileController Initialized: firstName=$_firstName, lastName=$_lastName");

//     // If the values are null, that indicates they're not being saved correctly
//     if (_firstName == null || _lastName == null) {
//       debugPrint("Error: First name or last name is null!");
//     }

//     notifyListeners();
//   }
// }
