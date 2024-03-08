class JobsPreference {
  List<String> industryIds;
  Map<String, List<String>> jobIds;

  JobsPreference({
    required this.industryIds,
    required this.jobIds,
  });

  // Convert JobsPreference to Map
  Map<String, dynamic> toMap() {
    return {
      'industryIds': industryIds,
      'jobIds': jobIds.map((key, value) => MapEntry(key, value)),
    };
  }

  // Create JobsPreference from Map
  factory JobsPreference.fromMap(Map<String, dynamic> map) {
    // Ensure 'industryIds' and 'jobIds' are present and are lists
    final industryIds = List<String>.from(map['industryIds'] ?? []);
    final jobIds = Map<String, dynamic>.from(map['jobIds'] ?? {}).map(
      (key, value) => MapEntry(key, List<String>.from(value ?? [])),
    );
    return JobsPreference(industryIds: industryIds, jobIds: jobIds);
  }
}
