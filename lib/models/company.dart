import 'address.dart';
import 'social_media_platform.dart';

class Company {
  String companyId;
  String logoUrl;
  String wallpaperUrl;
  String name;
  String companyDescription;
  String companySlogan;
  String companyIndustry;
  List<String> emails;
  List<String> phoneNumbers;
  List<Address> addresses;
  Address? address;
  int yearFounded;
  String website;
  int totalEmployees;
  List<String> industryIds;
  List<String> jobPostIds;
  List<String> companyBadgeIds;
  List<String> companyCertificationIds;
  List<String> companyVerificationIds;
  List<String> companyPhotoUrls;
  List<String> companyReviewIds;
  bool isVerified;
  bool isBasicProfileCompleted;
  bool isProfileUpdateNeeded;
  List<String> interestingWorkersIds;
  List<SocialMediaPlatform> socialMediaPlatforms;
  int dateCreated;

  Company({
    required this.companyId,
    this.logoUrl = '',
    this.wallpaperUrl = '',
    required this.name,
    this.companyDescription = '',
    this.companySlogan = '',
    this.companyIndustry = '',
    required this.emails,
    required this.phoneNumbers,
    this.address,
    this.addresses = const [],
    this.yearFounded = 0,
    this.totalEmployees = 0,
    this.dateCreated = 0, // Set to a default value, adjust as needed
    this.website = '',
    this.industryIds = const [],
    this.jobPostIds = const [],
    this.companyBadgeIds = const [],
    this.companyCertificationIds = const [],
    this.companyVerificationIds = const [],
    this.companyPhotoUrls = const [],
    this.companyReviewIds = const [],
    this.isVerified = false,
    this.isBasicProfileCompleted = false,
    this.isProfileUpdateNeeded = false,
    this.socialMediaPlatforms = const [],
    this.interestingWorkersIds = const [],
  });

  Company.fromSignUp({
    required String companyId,
    required String name,
    required List<String> emails,
    required String companyDescription,
  }) : this(
          companyId: companyId,
          name: name,
          emails: emails,
          phoneNumbers: [],
          companyDescription: companyDescription,
          isBasicProfileCompleted: true,
        );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'companyId': companyId,
      'name': name,
    };

    if (logoUrl.isNotEmpty) map['logoUrl'] = logoUrl;
    if (website.isNotEmpty) map['website'] = website;
    if (wallpaperUrl.isNotEmpty) map['wallpaperUrl'] = wallpaperUrl;
    if (companyDescription.isNotEmpty) {
      map['companyDescription'] = companyDescription;
    }
    if (companySlogan.isNotEmpty) map['companySlogan'] = companySlogan;
    if (companyIndustry.isNotEmpty) map['companyIndustry'] = companyIndustry;
    if (emails.isNotEmpty) map['emails'] = emails;
    if (phoneNumbers.isNotEmpty) map['phoneNumbers'] = phoneNumbers;
    if (addresses.isNotEmpty) {
      map['addresses'] = addresses.map((address) => address.toMap()).toList();
    }
    if (address != null) map['address'] = address!.toMap();
    if (socialMediaPlatforms.isNotEmpty) {
      map['socialMediaPlatforms'] =
          socialMediaPlatforms.map((platform) => platform.toMap()).toList();
    }
    if (yearFounded != 0) map['yearFounded'] = yearFounded;
    if (totalEmployees != 0) map['totalEmployees'] = totalEmployees;
    if (industryIds.isNotEmpty) map['industryIds'] = industryIds;
    if (jobPostIds.isNotEmpty) map['jobPostIds'] = jobPostIds;
    if (companyBadgeIds.isNotEmpty) map['companyBadgeIds'] = companyBadgeIds;
    if (companyCertificationIds.isNotEmpty) {
      map['companyCertificationIds'] = companyCertificationIds;
    }
    if (companyVerificationIds.isNotEmpty) {
      map['companyVerificationIds'] = companyVerificationIds;
    }
    if (companyPhotoUrls.isNotEmpty) map['companyPhotoUrls'] = companyPhotoUrls;
    if (companyReviewIds.isNotEmpty) map['companyReviewIds'] = companyReviewIds;
    if (isVerified) map['isVerified'] = isVerified;
    if (isBasicProfileCompleted) {
      map['isBasicProfileCompleted'] = isBasicProfileCompleted;
    }
    if (isProfileUpdateNeeded) {
      map['isProfileUpdateNeeded'] = isProfileUpdateNeeded;
    }
    if (interestingWorkersIds.isNotEmpty) {
      map['interestingWorkersIds'] = interestingWorkersIds;
    }
    if (dateCreated != 0) {
      map['dateCreated'] = dateCreated; // Assuming default value is 2000
    }

    return map;
  }

  static Company fromMap(Map<String, dynamic> map) {
    return Company(
      companyId: map['companyId'],
      logoUrl: map['logoUrl'] ?? '',
      website: map['website'] ?? '',
      wallpaperUrl: map['wallpaperUrl'] ?? '',
      name: map['name'],
      companyDescription: map['companyDescription'] ?? '',
      companySlogan: map['companySlogan'] ?? '',
      companyIndustry: map['companyIndustry'] ?? '',
      emails: map['emails'] != null ? List<String>.from(map['emails']) : [],
      phoneNumbers: map['phoneNumbers'] != null
          ? List<String>.from(map['phoneNumbers'])
          : [],
      addresses: map['addresses'] != null
          ? (map['addresses'] as List)
              .map((addressMap) => Address.fromMap(addressMap))
              .toList()
          : [],
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      socialMediaPlatforms: map['socialMediaPlatforms'] != null
          ? (map['socialMediaPlatforms'] as List)
              .map((platformMap) => SocialMediaPlatform.fromMap(platformMap))
              .toList()
          : [],
      yearFounded: map['yearFounded'] != null
          ? int.parse(map['yearFounded'].toString())
          : 0,
      totalEmployees: map['totalEmployees'] != null
          ? int.parse(map['totalEmployees'].toString())
          : 0,
      industryIds: map['industryIds'] != null
          ? List<String>.from(map['industryIds'])
          : [],
      jobPostIds:
          map['jobPostIds'] != null ? List<String>.from(map['jobPostIds']) : [],
      companyBadgeIds: map['companyBadgeIds'] != null
          ? List<String>.from(map['companyBadgeIds'])
          : [],
      companyCertificationIds: map['companyCertificationIds'] != null
          ? List<String>.from(map['companyCertificationIds'])
          : [],
      companyVerificationIds: map['companyVerificationIds'] != null
          ? List<String>.from(map['companyVerificationIds'])
          : [],
      companyPhotoUrls: map['companyPhotoUrls'] != null
          ? List<String>.from(map['companyPhotoUrls'])
          : [],
      companyReviewIds: map['companyReviewIds'] != null
          ? List<String>.from(map['companyReviewIds'])
          : [],
      isVerified: map['isVerified'] ?? false,
      isBasicProfileCompleted: map['isBasicProfileCompleted'] ?? false,
      isProfileUpdateNeeded: map['isProfileUpdateNeeded'] ?? false,
      interestingWorkersIds: map['interestingWorkersIds'] != null
          ? List<String>.from(map['interestingWorkersIds'])
          : [],
      dateCreated: map['dateCreated'] != null
          ? int.parse(map['dateCreated'].toString())
          : 0, // Assuming default value is 2000
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
