class WorkerResumeFormTracker {
  // Tracking Completion of Worker Profile

  bool isIndustriesAndJobsCompleted;
  bool isBasicInformationCompleted;
  bool isProfilePictureUploaded;
  bool isSkillsCompleted;
  bool isCertificationsCompleted;
  bool isWorkExperienceCompleted;
  bool isPersonalReferencesCompleted;
  bool isDocumentsUploaded;
  bool isLinkedInUrlProvided;

  WorkerResumeFormTracker({
    this.isIndustriesAndJobsCompleted = false,
    this.isBasicInformationCompleted = false,
    this.isProfilePictureUploaded = false,
    this.isSkillsCompleted = false,
    this.isCertificationsCompleted = false,
    this.isWorkExperienceCompleted = false,
    this.isPersonalReferencesCompleted = false,
    this.isDocumentsUploaded = false,
    this.isLinkedInUrlProvided = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'isIndustriesAndJobsCompleted': isIndustriesAndJobsCompleted,
      'isBasicInformationCompleted': isBasicInformationCompleted,
      'isProfilePictureUploaded': isProfilePictureUploaded,
      'isSkillsCompleted': isSkillsCompleted,
      'isCertificationsCompleted': isCertificationsCompleted,
      'isWorkExperienceCompleted': isWorkExperienceCompleted,
      'isPersonalReferencesCompleted': isPersonalReferencesCompleted,
      'isDocumentsUploaded': isDocumentsUploaded,
      'isLinkedInUrlProvided': isLinkedInUrlProvided,
    };
  }

  factory WorkerResumeFormTracker.fromMap(Map<String, dynamic> map) {
    return WorkerResumeFormTracker(
      isIndustriesAndJobsCompleted:
          map['isIndustriesAndJobsCompleted'] ?? false,
      isBasicInformationCompleted: map['isBasicInformationCompleted'] ?? false,
      isProfilePictureUploaded: map['isProfilePictureUploaded'] ?? false,
      isSkillsCompleted: map['isSkillsCompleted'] ?? false,
      isCertificationsCompleted: map['isCertificationsCompleted'] ?? false,
      isWorkExperienceCompleted: map['isWorkExperienceCompleted'] ?? false,
      isPersonalReferencesCompleted:
          map['isPersonalReferencesCompleted'] ?? false,
      isDocumentsUploaded: map['isDocumentsUploaded'] ?? false,
      isLinkedInUrlProvided: map['isLinkedInUrlProvided'] ?? false,
    );
  }

  @override
  String toString() {
    return 'WorkerResumeFormTracker(\n'
        '  isIndustriesAndJobsCompleted: $isIndustriesAndJobsCompleted,\n'
        '  isBasicInformationCompleted: $isBasicInformationCompleted,\n'
        '  isProfilePictureUploaded: $isProfilePictureUploaded,\n'
        '  isSkillsCompleted: $isSkillsCompleted,\n'
        '  isCertificationsCompleted: $isCertificationsCompleted,\n'
        '  isWorkExperienceCompleted: $isWorkExperienceCompleted,\n'
        '  isPersonalReferencesCompleted: $isPersonalReferencesCompleted,\n'
        '  isDocumentsUploaded: $isDocumentsUploaded,\n'
        '  isLinkedInUrlProvided: $isLinkedInUrlProvided,\n'
        ')';
  }
}
