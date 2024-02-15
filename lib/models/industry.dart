import 'job.dart'; // Assuming Job class is defined in job.dart with a fromMap method

class Industry {
  final String industryId;
  final String name;
  final String? description;
  final String? imageUrl;
  final Map<String, Job> jobs;

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
      // Convert each Job object in the map to a map
      'jobs': jobs.map((jobId, job) => MapEntry(jobId, job.toMap())),
    };
  }

  static Industry fromMap(Map<String, dynamic> map) {
    Map<String, Job> jobsMap = {};

    List<Map<String, dynamic>> jobsData = map['jobs'] ?? {};

    for (var jobMap in jobsData) {
      String jobId = jobMap["jobId"];
      jobsMap[jobId] = Job.fromMap(jobMap);
    }

    return Industry(
      industryId: map['industryId'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      jobs: jobsMap,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }

  int getApplicantCount() {
    int count = 0;
    jobs.forEach((jobId, job) {
      count += job.numberOfApplicants;
    });
    return count;
  }

  int getNumberOfJobPosts() {
    int count = 0;
    jobs.forEach((jobId, job) {
      count += job.numberOfJobPosts;
    });
    return count;
  }
}
