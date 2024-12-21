import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressController with ChangeNotifier {
  int currentStep = 0;
  List<bool> completedSteps = [];

  double get progress =>
      completedSteps.where((e) => e).length / completedSteps.length * 100;

  bool isLessonAccessible(int index) {
    print(
        "Checking if lesson $index is accessible. completedSteps: $completedSteps");
    if (index == 0) return true; // The first lesson is always accessible
    if (index - 1 < completedSteps.length) {
      return completedSteps[
          index - 1]; // Check if the previous lesson is completed
    }
    return false;
  }

  void initializeSteps(int lessonCount) {
    if (completedSteps.isEmpty || completedSteps.length != lessonCount) {
      completedSteps = List.filled(lessonCount, false);
      print("Initialized completedSteps: $completedSteps");
    }
  }

  void onContinueTap(String courseId) {
    // Increment step and mark as completed
    updateCurrentStep(currentStep + 1);
    completeStep();

    // Save the updated progress
    saveProgress(courseId);
  }

  void updateCurrentStep(int newStep) {
    if (newStep >= 0 && newStep < completedSteps.length) {
      currentStep = newStep;
      print("Current step updated: $currentStep");
      notifyListeners();
    } else {
      print("updateCurrentStep: Invalid newStep: $newStep");
    }
  }

  void completeStep() {
    if (currentStep >= 0 && currentStep < completedSteps.length) {
      completedSteps[currentStep] = true;
      print("completeStep: Updated completedSteps: $completedSteps");
      notifyListeners();
    } else {
      print("completeStep: Invalid currentStep: $currentStep");
    }
  }

  void nextStep() {
    if (currentStep < completedSteps.length - 1) {
      currentStep++;
      print("Current Step: $progress");
      notifyListeners();
    }
  }

  void prevStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  Future<void> saveProgress(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final stepsToSave = completedSteps.map((e) => e.toString()).toList();
    print(
        "Saving progress for courseId: $courseId with completedSteps: $completedSteps");
    await prefs.setStringList('completedSteps_$courseId', stepsToSave);
    print("saveProgress: Steps saved successfully: $stepsToSave");
  }

  Future<void> loadProgress(String courseId, int lessonCount) async {
    final prefs = await SharedPreferences.getInstance();
    currentStep = prefs.getInt('currentStep_$courseId') ?? 0;
    completedSteps = (prefs
            .getStringList('completedSteps_$courseId')
            ?.map((e) => e == 'true')
            .toList() ??
        List.filled(lessonCount, false));
    // print("loadProgress: Loaded completedSteps: $completedSteps");
    notifyListeners();
  }
}
