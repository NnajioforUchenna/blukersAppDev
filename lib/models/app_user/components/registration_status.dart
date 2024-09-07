class RegistrationStatus {
  bool isLoginInformation;
  bool isAppUserInformation;
  bool isWorkersPreference;
  bool isJobsPreference;
  bool isRegistrationComplete;

  RegistrationStatus({
    this.isLoginInformation = false,
    this.isAppUserInformation = false,
    this.isWorkersPreference = false,
    this.isJobsPreference = false,
    this.isRegistrationComplete = false,
  });

  // Method to convert Firestore document to RegistrationStatus object
  factory RegistrationStatus.fromMap(Map<String, dynamic> doc) {
    return RegistrationStatus(
      isLoginInformation: doc['isLoginInformation'] ?? false,
      isAppUserInformation: doc['isAppUserInformation'] ?? false,
      isWorkersPreference: doc['isWorkersPreference'] ?? false,
      isJobsPreference: doc['isJobsPreference'] ?? false,
      isRegistrationComplete: doc['isRegistrationComplete'] ?? false,
    );
  }

  // Method to convert RegistrationStatus object to Map
  Map<String, dynamic> toMap() {
    return {
      'isLoginInformation': isLoginInformation,
      'isAppUserInformation': isAppUserInformation,
      'isWorkersPreference': isWorkersPreference,
      'isJobsPreference': isJobsPreference,
      'isRegistrationComplete': isRegistrationComplete,
    };
  }
}
