import 'package:flutter/material.dart';
import '../../../model/app_style.dart';

class StreakContoller extends ChangeNotifier {
  int _currentPage = 0;

  // List to store text styles and icon colors for each container
  final List<Map<String, dynamic>> _containerStyles = List.generate(
    31, // Number of containers
    (index) => {
      'textSize': 48.0,
      'textColor': AppStyles.whiteColor,
      'iconColor': AppStyles.whiteColor,
    },
  );

  int get currentPage => _currentPage;

  // Get the style for a specific container
  Map<String, dynamic> getContainerStyle(int index) => _containerStyles[index];

  // Update the page index
  void updatePage(int index) {
    _currentPage = index;
    notifyListeners();
  }

  // Update the style of a specific container
  void updateContainerStyle(int index,
      {double? textSize, Color? textColor, Color? iconColor}) {
    if (textSize != null) _containerStyles[index]['textSize'] = textSize;
    if (textColor != null) _containerStyles[index]['textColor'] = textColor;
    if (iconColor != null) _containerStyles[index]['iconColor'] = iconColor;
    notifyListeners();
  }
}
