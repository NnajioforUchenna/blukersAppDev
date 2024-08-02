import 'package:blukers/models/app_user/app_user.dart';

import '../common_files/get_time_ago.dart';
import 'address.dart';
import 'app_user/components/worker_records.dart';
import 'app_user/components/worker_resume_details.dart';

enum WorkStatus { activelyLooking, hired }

class Worker {
  String workerId;
  List<String> emails;
  String phoneNumber;
  String workerBriefDescription;
  String profilePhotoUrl;

  // Tracking Worker Profile form
  WorkerResumeDetails? workerResumeDetails;
  WorkerRecords? workerRecords;

  int workStatus;
  List<Address> addresses;
  Address? address;
  int dateCreated;

  int createdAt;
  int modifiedAt;

  Worker({
    required this.workerId,
    List<String>? emails,
    this.phoneNumber = '',
    this.workerBriefDescription = '',
    this.profilePhotoUrl = 'https://picsum.photos/200/300',
    this.workerResumeDetails,
    this.workerRecords,
    this.workStatus = 0,
    List<Address>? addresses,
    this.address,
    this.dateCreated = 0,
    this.createdAt = 0,
    this.modifiedAt = 0,
  })  : emails = emails ?? [],
        addresses = addresses ?? [];

  get timeAgo => getTimeAgo(dateCreated.toString());
  get location =>
      addresses.isNotEmpty ? addresses.first.location : 'Location not set';

  Map<String, dynamic> toMap() {
    return {
      'workerId': workerId,
      if (emails.isNotEmpty) 'emails': emails,
      if (phoneNumber.isNotEmpty) 'phoneNumber': phoneNumber,
      if (workerBriefDescription.isNotEmpty)
        'workerBriefDescription': workerBriefDescription,
      if (profilePhotoUrl.isNotEmpty) 'profilePhotoUrl': profilePhotoUrl,
      if (workerResumeDetails != null)
        'workerResumeDetails': workerResumeDetails!.toMap(),
      if (workerRecords != null) 'workerRecords': workerRecords!.toMap(),
      if (workStatus != 0) 'workStatus': workStatus,
      if (addresses.isNotEmpty)
        'addresses': addresses.map((address) => address.toMap()).toList(),
      if (address != null) 'address': address!.toMap(),
      if (dateCreated != 0) 'dateCreated': dateCreated,
      if (createdAt != 0) 'createdAt': createdAt,
      if (modifiedAt != 0) 'modifiedAt': modifiedAt,
    };
  }

  static Worker? fromMap(Map<String, dynamic> map) {
    try {
      return Worker(
        workerId: map['workerId'],
        emails: (map['emails'] as List?)?.cast<String>() ?? [],
        phoneNumber: map['phoneNumber'] ?? '',
        workerBriefDescription: map['workerBriefDescription'] ?? '',
        profilePhotoUrl: map['profilePhotoUrl'] ?? '',
        workerResumeDetails: map['workerResumeDetails'] != null
            ? WorkerResumeDetails.fromMap(map['workerResumeDetails'])
            : null,
        workerRecords: map['workerRecords'] != null
            ? WorkerRecords.fromMap(map['workerRecords'])
            : null,
        workStatus: map['workStatus'] != null
            ? int.parse(map['workStatus'].toString())
            : 0,
        addresses: (map['addresses'] as List?)
                ?.map((item) => Address.fromMap(item))
                .toList() ??
            [],
        address:
            map['address'] != null ? Address.fromMap(map['address']) : null,
        dateCreated: map['dateCreated'] != null
            ? int.parse(map['dateCreated'].toString())
            : 0,
        createdAt: map['createdAt'] != null
            ? int.parse(map['createdAt'].toString())
            : 0,
        modifiedAt: map['modifiedAt'] != null
            ? int.parse(map['modifiedAt'].toString())
            : 0,
      );
    } catch (e) {
      print('An error occurred while creating the Worker object: $e');
      return null;
    }
  }

  @override
  String toString() {
    return toMap().toString();
  }

  static Worker fromAppUser(AppUser appUser) {
    Worker worker = Worker(workerId: appUser.uid);

    if (appUser.registrationDetails != null) {
      worker.emails.add(appUser.registrationDetails!.email);
      worker.phoneNumber = appUser.registrationDetails!.phoneNumber ?? '';
      worker.workerBriefDescription =
          appUser.registrationDetails!.shortDescription ?? '';
    }

    if (appUser.phoneNumber != null) worker.phoneNumber = appUser.phoneNumber!;
    if (appUser.workerResumeDetails != null) {
      worker.workerResumeDetails = appUser.workerResumeDetails;
      worker.profilePhotoUrl = appUser.workerResumeDetails?.profilePhotoUrl ??
          'https://picsum.photos/200/300';
    }
    if (appUser.workerRecords != null) {
      worker.workerRecords = appUser.workerRecords;
    }

    return worker;
  }

  String getDisplayName() {
    // Initialize an empty string to store the display name
    String displayName = '';

    // Append the first name if it is not null
    if (workerResumeDetails?.firstName != null) {
      displayName += workerResumeDetails!.firstName!;
    }

    // Append the last name if it is not null
    if (workerResumeDetails?.lastName != null) {
      // Add a space only if the first name is not empty
      if (displayName.isNotEmpty) {
        displayName += ' ';
      }
      displayName += workerResumeDetails!.lastName!;
    }

    // Return the constructed display name, or 'Unnamed Worker' if both are null
    return displayName.isNotEmpty ? displayName : 'Name Not Given';
  }
}
