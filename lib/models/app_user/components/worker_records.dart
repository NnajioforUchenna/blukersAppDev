class WorkerRecords {
  List<String>? savedJobPostIds;
  List<String>? appliedJobPostIds;
  List<String>? workerBadgeIds;
  List<String>? workerVerificationsIds;
  List<String>? activeMemberships;

  WorkerRecords({
    this.savedJobPostIds,
    this.appliedJobPostIds,
    this.workerBadgeIds,
    this.workerVerificationsIds,
    this.activeMemberships,
  });

  Map<String, dynamic> toMap() {
    return {
      'savedJobPostIds': savedJobPostIds,
      'appliedJobPostIds': appliedJobPostIds,
      'workerBadgeIds': workerBadgeIds,
      'workerVerificationsIds': workerVerificationsIds,
      'activeMemberships': activeMemberships,
    };
  }

  factory WorkerRecords.fromMap(Map<String, dynamic> map) {
    return WorkerRecords(
      savedJobPostIds: List<String>.from(map['savedJobPostIds'] ?? []),
      appliedJobPostIds: List<String>.from(map['appliedJobPostIds'] ?? []),
      workerBadgeIds: List<String>.from(map['workerBadgeIds'] ?? []),
      workerVerificationsIds:
          List<String>.from(map['workerVerificationsIds'] ?? []),
      activeMemberships: List<String>.from(map['activeMemberships'] ?? []),
    );
  }

  @override
  String toString() {
    return 'WorkerRecords(\n'
        '  savedJobPostIds: $savedJobPostIds,\n'
        '  appliedJobPostIds: $appliedJobPostIds,\n'
        '  workerBadgeIds: $workerBadgeIds,\n'
        '  workerVerificationsIds: $workerVerificationsIds,\n'
        '  activeMemberships: $activeMemberships,\n'
        ')';
  }
}
