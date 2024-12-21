import 'package:flutter/material.dart';
import '../services/local_db.dart';

class UserDataController extends ChangeNotifier {
  SqlDb _sqlDb = SqlDb.instance;

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePic;

  Future<void> loadUserData() async {
    List<Map> data = await _sqlDb.read("users");
    if (data.isNotEmpty) {
      for (Map<dynamic, dynamic> user in data) {
        firstName = user['firstName'];
        lastName = user['lastName'];
        email = user['email'];
        profilePic = user['profilePic'];
      }
    } else {
      print("No user data found in local database.");
    }
    notifyListeners(); // This ensures UI updates
  }

  // void printUsersTable() async {
  //   List<Map> data = await _sqlDb.read("users");
  //   if (data.isEmpty) {
  //     print("Users table is empty.");
  //   } else {
  //     print("Users table content:");
  //     for (var user in data) {
  //       print(user);
  //     }
  //   }
  // }
  void printUsersTable() async {
    List<Map> data = await _sqlDb.read("courses");
    if (data.isEmpty) {
      print("Users table is empty.");
    } else {
      print("Users table content:");
      for (var user in data) {
        print(user);
      }
    }
  }

  void updateName(String firstName, String lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
    notifyListeners();
  }
}
