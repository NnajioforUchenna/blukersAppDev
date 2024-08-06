class JobApplicationTracker {
  int numberOfAppliedJobsToday;
  int lastTimeApplied;

  JobApplicationTracker({
    this.numberOfAppliedJobsToday = 0,
    this.lastTimeApplied = 0,
  }) {
    lastTimeApplied = lastTimeApplied == 0
        ? DateTime.now().millisecondsSinceEpoch
        : lastTimeApplied;
  }

  Map<String, dynamic> toMap() {
    return {
      'numberOfAppliedJobsToday': numberOfAppliedJobsToday,
      'lastTimeApplied': lastTimeApplied,
    };
  }

  static JobApplicationTracker fromMap(Map<String, dynamic> map) {
    return JobApplicationTracker(
      numberOfAppliedJobsToday: map['numberOfAppliedJobsToday'] ?? 0,
      lastTimeApplied: map['lastTimeApplied'] ?? 0,
    );
  }

  bool checkIfEligible(String subscriptionType) {
    DateTime now = DateTime.now();
    DateTime todayMidnight = DateTime(now.year, now.month, now.day);
    DateTime lastAppliedDateTime =
        DateTime.fromMillisecondsSinceEpoch(lastTimeApplied);

    if (lastAppliedDateTime.isBefore(todayMidnight)) {
      numberOfAppliedJobsToday = 0;
    }

    switch (subscriptionType.toLowerCase()) {
      case 'basic':
        return numberOfAppliedJobsToday <
            20; // TODO: Remember to change this to 2
      case 'blukers_workers_premium':
        return numberOfAppliedJobsToday < 10;
      case 'blukers_workers_premium_plus':
        return true;
      default:
        return false;
    }
  }

  void keepRecordOfNumberOfJobPostApplied() {
    numberOfAppliedJobsToday++;
    lastTimeApplied = DateTime.now().millisecondsSinceEpoch;
  }
}
