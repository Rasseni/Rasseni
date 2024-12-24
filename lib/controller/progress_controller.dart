import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProgressController extends ChangeNotifier {
  Map<String, List<bool>> courseProgress = {};
  Map<String, int> currentSteps = {};
  Map<String, int> courseLessonCounts =
      {}; // Store lesson counts for each course

  ProgressController() {
    loadProgress(); // Load progress when the controller is created
  }

  void initializeSteps(String courseId, int lessonCount) {
    courseLessonCounts[courseId] = lessonCount; // Store the lesson count
    if (!courseProgress.containsKey(courseId) ||
        courseProgress[courseId]!.length != lessonCount) {
      courseProgress[courseId] = List.filled(lessonCount, false);
      currentSteps[courseId] = 0;

      // Notify listeners after the current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  double getCourseProgress(String courseId, int totalLessons) {
    if (!courseProgress.containsKey(courseId)) return 0.0;
    int completedLessons =
        courseProgress[courseId]!.where((step) => step).length;
    return (completedLessons / totalLessons) * 100;
  }

  bool isLessonAccessible(String courseId, int index) {
    if (!courseProgress.containsKey(courseId)) return false;
    if (index == 0) return true;
    if (index < courseProgress[courseId]!.length) {
      return courseProgress[courseId]![index - 1];
    }
    return false;
  }

  void markLessonComplete(String courseId, int index) {
    if (courseProgress.containsKey(courseId) &&
        index < courseProgress[courseId]!.length) {
      courseProgress[courseId]![index] = true;
      notifyListeners();
    }
  }

  void resetProgress(String courseId) {
    if (courseProgress.containsKey(courseId)) {
      courseProgress[courseId] =
          List.filled(courseProgress[courseId]!.length, false);
      currentSteps[courseId] = 0;
      notifyListeners();
    }
  }

  Future<void> saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final progressData =
        courseProgress.map((key, value) => MapEntry(key, jsonEncode(value)));
    final stepsData = currentSteps.map(
        (key, value) => MapEntry(key, value.toString())); // Store as String
    final lessonCountsData =
        courseLessonCounts.map((key, value) => MapEntry(key, value.toString()));

    await prefs.setString('courseProgress', jsonEncode(progressData));
    await prefs.setString('currentSteps', jsonEncode(stepsData));
    await prefs.setString('courseLessonCounts', jsonEncode(lessonCountsData));
  }

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();

    final progressData = prefs.getString('courseProgress');
    final stepsData = prefs.getString('currentSteps');
    final lessonCountsData = prefs.getString('courseLessonCounts');

    if (progressData != null) {
      final decodedData = jsonDecode(progressData) as Map<String, dynamic>;
      courseProgress = decodedData.map(
          (key, value) => MapEntry(key, List<bool>.from(jsonDecode(value))));
    }

    if (stepsData != null) {
      final decodedSteps = jsonDecode(stepsData) as Map<String, dynamic>;
      currentSteps = decodedSteps.map((key, value) =>
          MapEntry(key, int.parse(value as String))); // Parse as int
    }

    if (lessonCountsData != null) {
      final decodedCounts =
          jsonDecode(lessonCountsData) as Map<String, dynamic>;
      courseLessonCounts = decodedCounts
          .map((key, value) => MapEntry(key, int.parse(value as String)));
    }
    notifyListeners();
  }

  void onContinueTap(String courseId) {
    print(
        "==================================== $courseId ======================");
    print(
        "======================== current steps:  $currentSteps ======================");
    print(
        "======================== course progress:  $courseProgress ======================");
    print(
        "======================== courseLessonCounts:  $courseLessonCounts ======================");

    if (!courseLessonCounts.containsKey(courseId)) {
      print("Course ID $courseId lesson count not found. Cannot continue.");
      return; // Important: Stop execution if lesson count is missing
    }

    initializeSteps(courseId, courseLessonCounts[courseId]!);

    if (!currentSteps.containsKey(courseId) ||
        !courseProgress.containsKey(courseId)) {
      print(
          "Course ID $courseId not found in currentSteps or courseProgress. Initializing...");
    }

    int currentStep = currentSteps[courseId] ?? 0; // Provide a default value

    if (currentStep >= 0 && currentStep < courseProgress[courseId]!.length) {
      if (courseProgress[courseId]![currentStep]) {
        print("Current step $currentStep already marked as complete.");
      } else {
        courseProgress[courseId]![currentStep] = true;
        print("Marked step $currentStep as complete.");
      }

      saveProgress();

      if (courseProgress[courseId]![currentStep]) {
        if (currentStep + 1 < courseProgress[courseId]!.length) {
          currentSteps[courseId] = currentStep + 1;
          print("Moved to the next step: ${currentSteps[courseId]}");
        }
      }
      notifyListeners();
    } else {
      print(
          "Invalid step range - currentStep: $currentStep for courseId $courseId");
    }
  }
}
