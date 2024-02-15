class Job {
  final String jobId;
  final String title;
  final String? description;
  final String? requirements;
  final double? highRange;
  final double? lowRange;
  final int numberOfApplicants;
  int numberOfJobPosts; // New parameter

  Job({
    required this.jobId,
    required this.title,
    this.description,
    this.requirements,
    this.highRange,
    this.lowRange,
    required this.numberOfApplicants,
    required this.numberOfJobPosts, // Initialize in the constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
      'title': title,
      'description': description,
      'requirements': requirements,
      'highRange': highRange,
      'lowRange': lowRange,
      'numberOfApplicants': numberOfApplicants,
      'numberOfJobPosts': numberOfJobPosts, // Add to map
    };
  }

  static Job fromMap(Map<String, dynamic> map) {
    return Job(
      jobId: map['jobId'],
      title: map['title'],
      description: map['description'],
      requirements: map['requirements'],
      highRange: double.parse(map['highRange'].toString()),
      lowRange: double.parse(map['lowRange'].toString()),
      numberOfApplicants: int.parse(map['numberOfApplicants'].toString()),
      numberOfJobPosts: 0, // int.parse(map['numberOfJobPosts'].toString())
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
