import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../services/local_db.dart';
import 'user_data_controller.dart';

class ProfileImageController extends ChangeNotifier {
  final SqlDb _sqlDb = SqlDb.instance;

  final _userDataController = UserDataController();

  File? profileImage;

  File? get imagePiced => profileImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print("================= first done");
      notifyListeners();

      // Get the app's documents directory
      final directory = await getApplicationDocumentsDirectory();
      print("=================  Get the app's documents directory done");

      // Construct the path to save the image
      final savedImagePath = '${directory.path}/${pickedFile.name}';
      print("=================  construct the path to save the image done");

      // Save the image to the documents directory
      final savedImage = await File(pickedFile.path).copy(savedImagePath);
      print(
          "=================  Save the image to the documents directory done");

      // Update the SQLite database with the image path
      await _sqlDb.updateUser({'profilePic': savedImage.path});
      print(
          "=================  Update the SQLite database with the image path done");
      _userDataController.loadUserData();
      notifyListeners();
    }
  }

  void clearImage() {
    profileImage = null;
    notifyListeners();
  }
}
