class DevSubscriptionFeaturesWorker {
  static const Map<String, dynamic> basic = {
    "canCreateResume": true,
    "canUploadResume": false,
    "totalJobApplicationsPerDay": 2,
    "canUploadCertifications": false,
    "canShowProfileOnTopInEmployersSearch": false,
    "canDisplayImmigrationVerifiedStatus": false,
    "canDisplayEmploymentVerifiedStatus": false,
  };

  static const Map<String, dynamic> premium = {
    "canCreateResume": true,
    "canUploadResume": true,
    "totalJobApplicationsPerDay": 10,
    "canUploadCertifications": true,
    "canShowProfileOnTopInEmployersSearch": true,
    "canDisplayImmigrationVerifiedStatus": false,
    "canDisplayEmploymentVerifiedStatus": false,
  };

  static const Map<String, dynamic> premiumPlus = {
    "canCreateResume": true,
    "canUploadResume": true,
    "totalJobApplicationsPerDay": 9999999,
    "canUploadCertifications": true,
    "canShowProfileOnTopInEmployersSearch": true,
    "canDisplayImmigrationVerifiedStatus": true,
    "canDisplayEmploymentVerifiedStatus": true,
  };
}
