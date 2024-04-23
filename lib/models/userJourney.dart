final List<String> engagementStatuses = [
  'engagedMember',
  'dormantMember',
  'basicMember'
];
final List<String> subscriptionStatuses = [
  'premiumSubscriber',
  'premiumPlusSubscriber',
  'formerSubscriber'
];

class UserJourney {
  Map<String, int> statusHistory = {};

  void updateStatus(String status) {
    // Clear any conflicting engagement statuses if setting a new one
    if (engagementStatuses.contains(status)) {
      for (var engStatus in engagementStatuses) {
        if (engStatus != status) {
          statusHistory.remove(engStatus);
        }
      }
    }

    // Clear any conflicting subscription statuses if setting a new one
    if (subscriptionStatuses.contains(status)) {
      for (var subStatus in subscriptionStatuses) {
        if (subStatus != status) {
          statusHistory.remove(subStatus);
        }
      }
    }

    // Set the new status with the current time stamp
    statusHistory[status] = DateTime.now().millisecondsSinceEpoch;
  }

  int? getStatus(String status) {
    return statusHistory[status];
  }

  // Optionally, create a method to print all current statuses
  void printStatuses() {
    statusHistory.forEach((status, timestamp) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      print("$status was set on $date");
    });
  }
}

// class UserJourney {
//   int? prospect;
//   int? newcomer;
//   int? initiate;
//   int? member;
//   int? subscriber;
//   int? eliteClient;
// }
