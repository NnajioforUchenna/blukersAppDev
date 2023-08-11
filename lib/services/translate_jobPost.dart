import 'package:bulkers/services/translate.dart';

import '../models/job_post.dart';

Future<JobPost> TranslateJobPost(
    {required JobPost jobPost, required targetLanguage}) async {
  JobPost translatedJobPost = JobPost(
    jobPostId: jobPost.jobPostId,
    companyId: jobPost.companyId,
    companyName: jobPost.companyName,
    companyLogo: jobPost.companyLogo,
    jobType: jobPost.jobType,
    salaryType: jobPost.salaryType,
    salaryAmount: jobPost.salaryAmount,
    contractDuration: jobPost.contractDuration,
    addresses: jobPost.addresses,
    address: jobPost.address,
    applicantUserIds: jobPost.applicantUserIds,
    declineUserIds: jobPost.declineUserIds,
    interviewedUserIds: jobPost.interviewedUserIds,
    hiredUserIds: jobPost.hiredUserIds,
    numberOfPositionsAvailable: jobPost.numberOfPositionsAvailable,
    jobUrgencyLevel: jobPost.jobUrgencyLevel,
    jobPostStatus: jobPost.jobPostStatus,
    dateCreated: jobPost.dateCreated,
    schedule: jobPost.schedule,
    industryIds: jobPost.industryIds,
    jobIds: jobPost.jobIds,
  );

  if (jobPost.jobTitle.isNotEmpty) {
    translatedJobPost.jobTitle = await translateText(
        text: jobPost.jobTitle, targetLanguage: targetLanguage);
  }
  if (jobPost.jobDescription.isNotEmpty) {
    translatedJobPost.jobDescription = await translateText(
        text: jobPost.jobDescription, targetLanguage: targetLanguage);
  }
  if (jobPost.requirements.isNotEmpty) {
    translatedJobPost.requirements = await translateText(
        text: jobPost.requirements, targetLanguage: targetLanguage);
  }
  if (jobPost.skills.isNotEmpty) {
    String skills = jobPost.skills.join(', ');
    skills = await translateText(text: skills, targetLanguage: targetLanguage);
    translatedJobPost.skills = skills.split(', ');
  }

  print('translatedJobPost: $translatedJobPost');
  return translatedJobPost;
}
