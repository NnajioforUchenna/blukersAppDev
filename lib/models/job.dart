class Job {
  final String jobId;
  final String title;
  final String? description;
  final String? requirements;
  final double? highRange;
  final double? lowRange;
  final int numberOfApplicants; // New parameter.

  Job({
    required this.jobId,
    required this.title,
    this.description,
    this.requirements,
    this.highRange,
    this.lowRange,
    required this.numberOfApplicants, // Initialize in the constructor.
  });

  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
      'title': title,
      'description': description,
      'requirements': requirements,
      'highRange': highRange,
      'lowRange': lowRange,
      'numberOfApplicants': numberOfApplicants, // Add to map.
    };
  }

  static Job fromMap(Map<String, dynamic> map) {
    return Job(
      jobId: map['jobId'],
      title: map['title'],
      description: map['description'],
      requirements: map['requirements'],
      highRange: map['highRange'],
      lowRange: map['lowRange'],
      numberOfApplicants: map['numberOfApplicants'], // Extract from map.
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
