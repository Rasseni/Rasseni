// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProgressController with ChangeNotifier {
//   int currentStep = 0;
//   List<bool> completedSteps = [];

//   double get progress =>
//       completedSteps.where((e) => e).length / completedSteps.length * 100;

//   bool isLessonAccessible(int index) {
//     // print( "Checking if lesson $index is accessible. completedSteps: $completedSteps");
//     if (index == 0) return true; // The first lesson is always accessible
//     if (index < completedSteps.length) {
//       return completedSteps[
//           index - 1]; // Accessible if the previous lesson is completed
//     }
//     return false;
//   }

//   void initializeSteps(int lessonCount) {
//     if (completedSteps.isEmpty || completedSteps.length != lessonCount) {
//       completedSteps = List.filled(lessonCount, false);
//       currentStep = 0; // Reset currentStep to the start
//     }
//   }

//   void onContinueTap(String courseId) {
//     // Check if the current step is within bounds
//     if (currentStep >= 0 && currentStep < completedSteps.length) {
//       // Check if the current step is already marked as complete
//       if (completedSteps[currentStep]) {
//         print("Current step $currentStep already marked as complete.");
//       } else {
//         // Mark the current step as complete
//         completedSteps[currentStep] = true;
//         print("Marked step $currentStep as complete.");
//       }

//       // Save the progress
//       saveProgress(courseId);

//       // Move to the next step only if the current step is complete
//       if (completedSteps[currentStep]) {
//         // Increment currentStep, don't reset it
//         if (currentStep + 1 < completedSteps.length) {
//           currentStep++;
//           print("Moved to the next step: $currentStep");
//         }

//         // Unlock the next step if the current step is complete
//         if (currentStep < completedSteps.length) {
//           completedSteps[currentStep] = true;
//           print("Unlocked step $currentStep.");
//         }
//       }

//       // Notify listeners to update the UI
//       notifyListeners();
//     } else {
//       print("Invalid step range - currentStep: $currentStep");
//     }
//   }

//   void updateCurrentStep(int newStep) {
//     if (newStep >= 0 && newStep < completedSteps.length) {
//       currentStep = newStep;
//       print("Current step updated: $currentStep");
//       notifyListeners();
//     } else {
//       print("updateCurrentStep: Invalid newStep: $newStep");
//     }
//   }

//   void completeStep() {
//     print(
//         "completeStep: currentStep: $currentStep, completedSteps: $completedSteps");
//     if (currentStep >= 0 && currentStep < completedSteps.length) {
//       completedSteps[currentStep] = true;
//       print("completeStep: Updated completedSteps: $completedSteps");
//       notifyListeners();
//     } else {
//       print("completeStep: Invalid currentStep: $currentStep");
//     }
//   }

//   void nextStep() {
//     if (currentStep < completedSteps.length - 1) {
//       currentStep++;
//       print("Current Step: $currentStep, Progress: $progress%");
//       notifyListeners();
//     }
//   }

//   void prevStep() {
//     if (currentStep > 0) {
//       currentStep--;
//       print("Current Step: $currentStep, Progress: $progress%");
//       notifyListeners();
//     }
//   }

//   Future<void> saveProgress(String courseId) async {
//     final prefs = await SharedPreferences.getInstance();
//     final stepsToSave = completedSteps.map((e) => e.toString()).toList();
//     print(
//         "Saving progress for courseId: $courseId with completedSteps: $completedSteps");
//     await prefs.setStringList('completedSteps_$courseId', stepsToSave);
//     await prefs.setInt(
//         'currentStep_$courseId', currentStep); // Save currentStep
//     print("saveProgress: Steps saved successfully: $stepsToSave");
//   }

//   Future<void> loadProgress(String courseId, int lessonCount) async {
//     final prefs = await SharedPreferences.getInstance();
//     currentStep =
//         prefs.getInt('currentStep_$courseId') ?? 0; // Load currentStep
//     completedSteps = (prefs
//             .getStringList('completedSteps_$courseId')
//             ?.map((e) => e == 'true')
//             .toList() ??
//         List.filled(lessonCount, false)); // Load completedSteps
//     // print("loadProgress: Loaded completedSteps: $completedSteps");
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressController with ChangeNotifier {
  int currentStep = 0;
  List<bool> completedSteps = [];

  int get getCurrentStep => currentStep;

  void setCurrentStep(int step) {
    currentStep = step;
    notifyListeners();
  }

  double get progress => completedSteps.isEmpty
      ? 0.0
      : completedSteps.where((e) => e).length / completedSteps.length * 100;

  bool isLessonAccessible(int index) {
    print(
        "Checking if lesson $index is accessible. completedSteps: $completedSteps");
    if (index == 0) return true; // The first lesson is always accessible
    if (index < completedSteps.length) {
      return completedSteps[
          index - 1]; // Accessible if the previous lesson is completed
    }

    return false;
  }

  void initializeSteps(int lessonCount) {
    if (completedSteps.isEmpty || completedSteps.length != lessonCount) {
      completedSteps = List.filled(lessonCount, false);
      currentStep = 0;

      // Notify listeners after the current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void onContinueTap(String courseId) {
    if (currentStep >= 0 && currentStep < completedSteps.length) {
      if (!completedSteps[currentStep]) {
        completedSteps[currentStep] = true; // Mark current step as complete
        print("Marked step $currentStep as complete.");
      }

      saveProgress(courseId);

      nextStep();

      notifyListeners();
    } else {
      print("Invalid step range - currentStep: $currentStep");
    }
  }

  void updateCurrentStep(int newStep) {
    if (newStep >= 0 && newStep < completedSteps.length) {
      currentStep = newStep; // Update the step
      print("Current step updated: $currentStep");
      notifyListeners();
    } else {
      print("updateCurrentStep: Invalid newStep: $newStep");
    }
  }

  void completeStep() {
    if (currentStep >= 0 && currentStep < completedSteps.length) {
      completedSteps[currentStep] = true;
      print("Step $currentStep marked as complete.");
      notifyListeners();
    } else {
      print("completeStep: Invalid currentStep: $currentStep");
    }
  }

  void nextStep() {
    if (currentStep + 1 < completedSteps.length) {
      currentStep++; // Move to the next step
      // updateCurrentStep(currentStep);
      print("Moved to the next step: $currentStep");
    }
  }

  void prevStep() {
    if (currentStep > 0) {
      currentStep--;
      print("Moved to previous step: $currentStep");
      notifyListeners();
    }
  }

  Future<void> saveProgress(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final stepsToSave = completedSteps.map((e) => e.toString()).toList();
    await prefs.setStringList('completedSteps_$courseId', stepsToSave);
    await prefs.setInt('currentStep_$courseId', currentStep);
    print("Progress saved for courseId: $courseId");
  }

  Future<void> loadProgress(String courseId, int lessonCount) async {
    final prefs = await SharedPreferences.getInstance();
    int loadCurrentStep = prefs.getInt('currentStep_$courseId') ?? 0;
    completedSteps = (prefs
            .getStringList('completedSteps_$courseId')
            ?.map((e) => e == 'true')
            .toList() ??
        List.filled(lessonCount, false));
    setCurrentStep(loadCurrentStep);
    print("Progress loaded for courseId: $courseId");
    print("loadProgress: Loaded completedSteps: $completedSteps");
    notifyListeners();
  }
}
