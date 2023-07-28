import 'job.dart';

class Industry {
  final String industryId;
  final String name;
  final String? description;
  final String? imageUrl;
  final List<Job> jobs;

  Industry({
    required this.industryId,
    required this.name,
    this.description,
    this.imageUrl,
    required this.jobs,
  });

  Map<String, dynamic> toMap() {
    return {
      'industryId': industryId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'jobs': jobs.map((job) => job.toMap()).toList(),
    };
  }

  static Industry fromMap(Map<String, dynamic> map) {
    List<dynamic> jobsData = map['jobs'];
    List<Job> jobsList = jobsData
        .map((jobMap) => Job.fromMap(jobMap as Map<String, dynamic>))
        .toList();

    return Industry(
      industryId: map['industryId'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      jobs: jobsList,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }

  int getApplicantCount() {
    int count = 0;
    for (Job job in jobs) {
      count += job.numberOfApplicants;
    }
    return count;
  }

  getNumberOfJobPosts() {
    int count = 0;
    for (Job job in jobs) {
      count += job.numberOfJobPosts;
    }
    return count;
  }
}
