import 'package:blukers/models/app_user/components/worker_resume_form_tracker.dart';

import '../../reference_form.dart';
import '../../work_experience.dart';

class WorkerResumeDetails {
  // Tracking Completion of Worker Profile
  WorkerResumeFormTracker tracker;

  // Industries and Jobs
  List<String>? industryIds;
  List<String>? jobIds;

  // Basic Information
  String? firstName;
  String? middleName;
  String? lastName;
  int? birthdate;

  // Upload Profile Picture
  String? profilePhotoUrl;

  // Skills
  List<String>? skillIds;

  // Certifications
  List<String>? certificationsIds;

  // Work Experience
  List<WorkExperience>? workExperiences;

  // Personal References
  List<ReferenceForm>? references;

  // Upload Documents
  String? pdfResumeUrl;

  // LinkedIn URL
  String? linkedInUrl;

  WorkerResumeDetails({
    required this.tracker,
    this.industryIds,
    this.jobIds,
    this.firstName,
    this.middleName,
    this.lastName,
    this.birthdate,
    this.profilePhotoUrl,
    this.skillIds,
    this.certificationsIds,
    this.workExperiences,
    this.references,
    this.pdfResumeUrl,
    this.linkedInUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'tracker': tracker.toMap(),
      'industryIds': industryIds,
      'jobIds': jobIds,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'birthdate': birthdate,
      'profilePhotoUrl': profilePhotoUrl,
      'skillIds': skillIds,
      'certificationsIds': certificationsIds,
      'workExperiences': workExperiences?.map((e) => e.toMap()).toList(),
      'references': references?.map((e) => e.toMap()).toList(),
      'pdfResumeUrl': pdfResumeUrl,
      'linkedInUrl': linkedInUrl,
    };
  }

  factory WorkerResumeDetails.fromMap(Map<String, dynamic> map) {
    return WorkerResumeDetails(
      tracker: WorkerResumeFormTracker.fromMap(map['tracker']),
      industryIds: List<String>.from(map['industryIds'] ?? []),
      jobIds: List<String>.from(map['jobIds'] ?? []),
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      birthdate: map['birthdate'],
      profilePhotoUrl: map['profilePhotoUrl'],
      skillIds: List<String>.from(map['skillIds'] ?? []),
      certificationsIds: List<String>.from(map['certificationsIds'] ?? []),
      workExperiences: (map['workExperiences'] as List<dynamic>?)
          ?.map((e) => WorkExperience.fromMap(e))
          .toList(),
      references: (map['references'] as List<dynamic>?)
          ?.map((e) => ReferenceForm.fromMap(e))
          .toList(),
      pdfResumeUrl: map['pdfResumeUrl'],
      linkedInUrl: map['linkedInUrl'],
    );
  }

  @override
  String toString() {
    return 'WorkerResumeDetails(\n'
        '  tracker: $tracker,\n'
        '  industryIds: $industryIds,\n'
        '  jobIds: $jobIds,\n'
        '  firstName: $firstName,\n'
        '  middleName: $middleName,\n'
        '  lastName: $lastName,\n'
        '  birthdate: $birthdate,\n'
        '  profilePhotoUrl: $profilePhotoUrl,\n'
        '  skillIds: $skillIds,\n'
        '  certificationsIds: $certificationsIds,\n'
        '  workExperiences: $workExperiences,\n'
        '  references: $references,\n'
        '  pdfResumeUrl: $pdfResumeUrl,\n'
        '  linkedInUrl: $linkedInUrl,\n'
        ')';
  }
}
