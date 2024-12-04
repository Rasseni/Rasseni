import 'dart:convert'; // For Base64 encoding/decoding
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  String? _firstName;
  String? _lastName;
  File? _profileImage;

  // Getters
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  File? get profileImage => _profileImage;

  // Setters
  void setFirstName(String name) async {
    _firstName = name;
    _saveToPreferences('first_name', name);
    await _updateFirestoreProfile();
    notifyListeners();
  }

  void setLastName(String name) async {
    _lastName = name;
    _saveToPreferences('last_name', name);
    await _updateFirestoreProfile();
    notifyListeners();
  }

  Future<void> _updateFirestoreProfile() async {
    if (_firstName != null && _lastName != null) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'firstName': _firstName,
            'lastName': _lastName,
          });
        } catch (e) {
          debugPrint('Error updating Firestore profile: $e');
        }
      }
    }
  }

  void setProfileImage(File image) async {
    _profileImage = image;
    await _saveImageToPreferences(image);
    notifyListeners();
  }

  // Save and load from SharedPreferences
  Future<void> _saveImageToPreferences(File image) async {
    final bytes = await image.readAsBytes();
    final base64String = base64Encode(bytes);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', base64String);
  }

  Future<void> loadProfileImageFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final base64String = prefs.getString('profile_image');

    if (base64String != null) {
      final bytes = base64Decode(base64String);
      _profileImage = File.fromRawPath(bytes);
    }
    notifyListeners();
  }

  Future<void> _saveToPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _firstName = prefs.getString('first_name');
    _lastName = prefs.getString('last_name');
    await loadProfileImageFromPreferences();
    notifyListeners();
  }

  void clearProfile() async {
    _firstName = null;
    _lastName = null;
    _profileImage = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
  }

  ProfileController() {
    debugPrint("ProfileController Constructor Called");
    initialize();
  }
  // Initialization method
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    _firstName = prefs.getString('first_name');
    _lastName = prefs.getString('last_name');
    await loadProfileImageFromPreferences();
    

    debugPrint(
        "ProfileController Initialized: firstName=$_firstName, lastName=$_lastName");

    // If the values are null, that indicates they're not being saved correctly
    if (_firstName == null || _lastName == null) {
      debugPrint("Error: First name or last name is null!");
    }

    await loadProfileImageFromPreferences();
    notifyListeners();
  }
}
