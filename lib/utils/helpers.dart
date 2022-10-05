import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/ModelProvider.dart';

bool moduleAvailable(ModuleProgress progress) {
  return progress.availableAt.compareTo(TemporalDateTime.now()) < 1;
}

bool moduleCompleted(ModuleProgress progress) {
  return progress.completedAt != null;
}

int moduleCompareTo(ModuleProgress a, ModuleProgress b) {
  if (a.module?.index != null && b.module?.index != null) {
    return a.module!.index! - b.module!.index!;
  }
  return a.availableAt.compareTo(b.availableAt);
}

bool isEnrollmentCourseDone(Enrollment enrollment) {
  bool done = true;
  if (enrollment.completedAt != null) return true;
  if (enrollment.moduleSchedule == null) return true;
  enrollment.moduleSchedule!.forEach((element) {
    done = done && element.completedAt != null;
  });
  return done;
}

bool isProfileComplete(Profile profile) {
  return profile.firstName != null &&
      profile.lastName != null &&
      profile.birthDate != null &&
      profile.length != null &&
      profile.targetWeight != null;
}
