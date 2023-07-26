import 'package:flutter/material.dart';

class JobPostsProvider with ChangeNotifier {
  Map<String, dynamic> _jobPosts = {};

  Map<String, dynamic> get jobPosts => _jobPosts;
}
