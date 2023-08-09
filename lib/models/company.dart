import 'address.dart';
import 'social_media_platform.dart';

class Company {
  String companyId;
  String? logoUrl;
  String? wallpaperUrl;
  String name;
  String? companyDescription;
  String? companySlogan;
  String? companyIndustry;
  List<String> emails;
  List<String> phoneNumbers;
  List<Address>? addresses;
  int? yearFounded;
  String? website;
  int? totalEmployees;
  List<String>? industryIds;
  List<String>? jobPostIds;
  List<String>? companyBadgeIds;
  List<String>? companyCertificationIds;
  List<String>? companyVerificationIds;
  List<String>? companyPhotoUrls;
  List<String>? companyReviewIds;
  bool? isVerified;
  bool? isBasicProfileCompleted;
  bool? isProfileUpdateNeeded;
  List<String>? interestingWorkersIds = [];
  List<SocialMediaPlatform>? socialMediaPlatforms;
  DateTime? dateCreated;

  Company(
      {required this.companyId,
      this.logoUrl,
      this.wallpaperUrl,
      required this.name,
      this.companyDescription,
      this.companySlogan,
      this.companyIndustry,
      required this.emails,
      required this.phoneNumbers,
      this.addresses,
      this.yearFounded,
      this.totalEmployees,
      this.dateCreated,
      this.website,
      this.industryIds,
      this.jobPostIds,
      this.companyBadgeIds,
      this.companyCertificationIds,
      this.companyVerificationIds,
      this.companyPhotoUrls,
      this.companyReviewIds,
      this.isVerified,
      this.isBasicProfileCompleted,
      this.isProfileUpdateNeeded,
      this.socialMediaPlatforms,
      this.interestingWorkersIds});

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
      'emails': emails,
      'phoneNumbers': phoneNumbers,
    };

    if (logoUrl != null) map['logoUrl'] = logoUrl;
    if (website != null) map['website'] = website;
    if (wallpaperUrl != null) map['wallpaperUrl'] = wallpaperUrl;
    if (companyDescription != null) {
      map['companyDescription'] = companyDescription;
    }
    if (companySlogan != null) map['companySlogan'] = companySlogan;
    if (companyIndustry != null) map['companyIndustry'] = companyIndustry;
    if (addresses != null) {
      map['addresses'] = addresses?.map((address) => address.toMap()).toList();
    }
    if (socialMediaPlatforms != null) {
      map['socialMediaPlatforms'] =
          socialMediaPlatforms?.map((platform) => platform.toMap()).toList();
    }

    if (yearFounded != null) map['yearFounded'] = yearFounded;
    if (totalEmployees != null) map['totalEmployees'] = totalEmployees;
    if (industryIds != null) map['industryIds'] = industryIds;
    if (jobPostIds != null) map['jobPostIds'] = jobPostIds;
    if (companyBadgeIds != null) map['companyBadgeIds'] = companyBadgeIds;
    if (companyCertificationIds != null) {
      map['companyCertificationIds'] = companyCertificationIds;
    }
    if (companyVerificationIds != null) {
      map['companyVerificationIds'] = companyVerificationIds;
    }
    if (companyPhotoUrls != null) map['companyPhotoUrls'] = companyPhotoUrls;
    if (companyReviewIds != null) map['companyReviewIds'] = companyReviewIds;
    if (isVerified != null) map['isVerified'] = isVerified;
    if (isBasicProfileCompleted != null) {
      map['isBasicProfileCompleted'] = isBasicProfileCompleted;
    }
    if (isProfileUpdateNeeded != null) {
      map['isProfileUpdateNeeded'] = isProfileUpdateNeeded;
    }
    if (interestingWorkersIds!.isNotEmpty) {
      map['interestingWorkersIds'] = interestingWorkersIds;
    }

    if (dateCreated != null) map['dateCreated'] = dateCreated;

    return map;
  }

  static Company fromMap(Map<String, dynamic> map) {
    return Company(
      companyId: map['companyId'],
      logoUrl: map['logoUrl'],
      website: map['website'],
      wallpaperUrl: map['wallpaperUrl'],
      name: map['name'],
      companyDescription: map['companyDescription'],
      companySlogan: map['companySlogan'],
      companyIndustry: map['companyIndustry'],
      emails: map['emails'] != null ? List<String>.from(map['emails']) : [],
      phoneNumbers: map['phoneNumbers'] != null
          ? List<String>.from(map['phoneNumbers'])
          : [],
      addresses: map['addresses'] != null
          ? (map['addresses'] as List)
              .map((addressMap) => Address.fromMap(addressMap))
              .toList()
          : null,
      socialMediaPlatforms: map['socialMediaPlatforms'] != null
          ? (map['socialMediaPlatforms'] as List)
              .map((platformMap) => SocialMediaPlatform.fromMap(platformMap))
              .toList()
          : null,
      yearFounded: map['yearFounded'] != null
          ? int.parse(map['yearFounded'].toString())
          : null,
      totalEmployees: map['totalEmployees'] != null
          ? int.parse(map['totalEmployees'].toString())
          : null,
      industryIds: map['industryIds'] != null
          ? List<String>.from(map['industryIds'])
          : null,
      jobPostIds: map['jobPostIds'] != null
          ? List<String>.from(map['jobPostIds'])
          : null,
      companyBadgeIds: map['companyBadgeIds'] != null
          ? List<String>.from(map['companyBadgeIds'])
          : [],
      companyCertificationIds: map['companyCertificationIds'] != null
          ? List<String>.from(map['companyCertificationIds'])
          : null,
      companyVerificationIds: map['companyVerificationIds'] != null
          ? List<String>.from(map['companyVerificationIds'])
          : null,
      companyPhotoUrls: map['companyPhotoUrls'] != null
          ? List<String>.from(map['companyPhotoUrls'])
          : null,
      companyReviewIds: map['companyReviewIds'] != null
          ? List<String>.from(map['companyReviewIds'])
          : null,
      isVerified: map['isVerified'],
      isBasicProfileCompleted: map['isBasicProfileCompleted'],
      isProfileUpdateNeeded: map['isProfileUpdateNeeded'],
      interestingWorkersIds: map['interestingWorkersIds'] != null
          ? List<String>.from(map['interestingWorkersIds'])
          : [],
      dateCreated: map['dateCreated'] != null
          ? DateTime.parse(map['dateCreated'])
          : null,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
