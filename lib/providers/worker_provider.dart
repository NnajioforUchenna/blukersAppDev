import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../models/worker.dart';
// Assuming the file containing the Worker class is named 'worker.dart'.

class WorkerProvider with ChangeNotifier {
  Worker? _worker;

  Worker? get worker => _worker;

  update(AppUser? user) {}

// Any other methods related to the Worker can be added as required.
}
