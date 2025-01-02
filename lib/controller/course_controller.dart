// // course_provider.dart
// import 'package:flutter/material.dart';

// import '../model/courses_model.dart';
// import '../services/course_local.dart';
// import 'online_data_controller.dart';
// import 'progress_controller.dart';

// class CourseController extends ChangeNotifier {
//   final CourseApiRepository _apiRepository = CourseApiRepository();
//   final CourseLocalRepository _localRepository = CourseLocalRepository();

//   List<CoursesModel> _availableCourses = [];
//   List<CoursesModel> _userCourses = [];

//   List<CoursesModel> get availableCourses => _availableCourses;
//   List<CoursesModel> get userCourses => _userCourses;

//   // Fetch available courses from the API
//   Future<void> fetchAvailableCourses() async {
//     try {
//       _availableCourses = await _apiRepository.fetchCoursesFromApi();
//       notifyListeners();
//     } catch (e) {
//       // Handle error (show toast, etc.)
//       print(
//           '================================= Error fetching available courses: $e');
//     }
//   }

//   // Fetch user-added courses from local DB
//   Future<void> fetchUserCourses() async {
//     _userCourses = await _localRepository.fetchUserAddedCourses();
//     notifyListeners();
//   }

//   // Add a course to both the list and the local DB
//   Future<void> addCourse(CoursesModel course) async {
//     await _localRepository.saveCourseToLocalDB(course);
//     _userCourses.add(course); // Update in-memory list
//     _availableCourses
//         .removeWhere((c) => c.id == course.id); // Remove from available courses
//     notifyListeners();
//   }

//   // Delete a course from both the list and the local DB
//   Future<void> deleteCourse(String courseId) async {
//     await _localRepository.deleteCourse(courseId);
//     _userCourses.removeWhere(
//         (course) => course.id == courseId); // Remove from in-memory list
//     notifyListeners();
//   }

//   List<CoursesModel> getSortedCourses(
//     CourseController courseController,
//     ProgressController progressController,
//   ) {
//     return courseController.userCourses.toList()
//       ..sort((a, b) {
//         final progressA =
//             progressController.getCourseProgress(a.id, a.content.length);
//         final progressB =
//             progressController.getCourseProgress(b.id, b.content.length);
//         return progressB.compareTo(progressA);
//       });
//   }
// }
import 'package:flutter/material.dart';

import '../model/courses_model.dart';
import '../services/course_local.dart';
import 'online_data_controller.dart';
import 'progress_controller.dart';

class CourseController extends ChangeNotifier {
  final CourseApiRepository _apiRepository = CourseApiRepository();
  final CourseLocalRepository _localRepository = CourseLocalRepository();

  List<CoursesModel> _availableCourses = [];
  List<CoursesModel> _userCourses = [];

  List<CoursesModel> get availableCourses => _availableCourses;
  List<CoursesModel> get userCourses => _userCourses;

  // Fetch available courses from the API
  Future<void> fetchAvailableCourses() async {
    try {
      _availableCourses = await _apiRepository.fetchCoursesFromApi();
      notifyListeners();
    } catch (e) {
      // Handle error (show toast, etc.)
      print(
          '================================= Error fetching available courses: $e');
    }
  }

  // Fetch user-added courses from local DB
  Future<void> fetchUserCourses() async {
    _userCourses = await _localRepository.fetchUserAddedCourses();
    notifyListeners();
  }

  // Add a course to both the list and the local DB
  Future<void> addCourse(CoursesModel course, BuildContext context) async {
    if (_userCourses.any((c) => c.id == course.id)) {
      // Show a message that the course is already added
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Course already added'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    await _localRepository.saveCourseToLocalDB(course);
    _userCourses.add(course); // Update in-memory list
    _availableCourses
        .removeWhere((c) => c.id == course.id); // Remove from available courses
    notifyListeners();
  }

  // Delete a course from both the list and the local DB
  Future<void> deleteCourse(String courseId) async {
    await _localRepository.deleteCourse(courseId);
    _userCourses.removeWhere(
        (course) => course.id == courseId); // Remove from in-memory list
    notifyListeners();
  }

  // Sort courses
  List<CoursesModel> getSortedCourses(
    CourseController courseController,
    ProgressController progressController,
  ) {
    return courseController.userCourses.toList()
      ..sort((a, b) {
        final progressA =
            progressController.getCourseProgress(a.id, a.content.length);
        final progressB =
            progressController.getCourseProgress(b.id, b.content.length);
        return progressB.compareTo(progressA);
      });
  }
}
