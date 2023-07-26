import 'address.dart';

class Company {
  final String companyId;
  final String? logoUrl; // Nullable
  final String? wallpaperUrl; // Nullable
  final String name;
  final String? companyDescription; // Nullable
  final List<String> emails; // At least one is necessary
  final List<String> phoneNumbers; // At least one is necessary
  final List<Address>? addresses; // Nullable
  final int? yearFounded; // Nullable
  final int? totalEmployees; // Nullable
  final List<String>? industryIds; // Nullable
  final List<String>? jobPostIds; // Nullable
  final List<String>? companyBadgeIds; // Nullable
  final List<String>? companyCertificationIds; // Nullable
  final List<String>? companyVerificationIds; // Nullable
  final List<String>? companyPhotoUrls; // Nullable
  final List<String>? companyReviewIds; // Nullable
  final bool? isVerified; // Nullable
  final bool? isBasicProfileCompleted; // Nullable
  final bool? isProfileUpdateNeeded; // Nullable

  Company({
    required this.companyId,
    this.logoUrl,
    this.wallpaperUrl,
    required this.name,
    this.companyDescription,
    required this.emails,
    required this.phoneNumbers,
    this.addresses,
    this.yearFounded,
    this.totalEmployees,
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
  });

  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'logoUrl': logoUrl,
      'wallpaperUrl': wallpaperUrl,
      'name': name,
      'companyDescription': companyDescription,
      'emails': emails,
      'phoneNumbers': phoneNumbers,
      'addresses': addresses?.map((address) => address.toMap()).toList(),
      'yearFounded': yearFounded,
      'totalEmployees': totalEmployees,
      'industryIds': industryIds,
      'jobPostIds': jobPostIds,
      'companyBadgeIds': companyBadgeIds,
      'companyCertificationIds': companyCertificationIds,
      'companyVerificationIds': companyVerificationIds,
      'companyPhotoUrls': companyPhotoUrls,
      'companyReviewIds': companyReviewIds,
      'isVerified': isVerified,
      'isBasicProfileCompleted': isBasicProfileCompleted,
      'isProfileUpdateNeeded': isProfileUpdateNeeded,
    };
  }

  static Company fromMap(Map<String, dynamic> map) {
    return Company(
      companyId: map['companyId'],
      logoUrl: map['logoUrl'],
      wallpaperUrl: map['wallpaperUrl'],
      name: map['name'],
      companyDescription: map['companyDescription'],
      emails: List<String>.from(map['emails']),
      phoneNumbers: List<String>.from(map['phoneNumbers']),
      addresses: map['addresses'] != null
          ? (map['addresses'] as List)
              .map((addressMap) => Address.fromMap(addressMap))
              .toList()
          : null,
      yearFounded: map['yearFounded'],
      totalEmployees: map['totalEmployees'],
      industryIds: map['industryIds'] != null
          ? List<String>.from(map['industryIds'])
          : null,
      jobPostIds: map['jobPostIds'] != null
          ? List<String>.from(map['jobPostIds'])
          : null,
      companyBadgeIds: map['companyBadgeIds'] != null
          ? List<String>.from(map['companyBadgeIds'])
          : null,
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
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
