import 'package:flutter/foundation.dart';
import '../../models/lead_models/lead_contact_session_status_model.dart';
import '../../data_providers/lead_data_providers/lead_contact_session_status_data_provider.dart';

class LeadContactSessionStatusProvider with ChangeNotifier {
  final LeadContactSessionStatusDataProvider _dataProvider =
      LeadContactSessionStatusDataProvider();
  List<LeadContactSessionStatusModel> _leadContactSessionStatuses = [];

  List<LeadContactSessionStatusModel> get leadContactSessionStatus =>
      _leadContactSessionStatuses;

  // Initialize the provider by fetching the initial leadContactSessionStatus data
  Future<void> initialize() async {
    _leadContactSessionStatuses =
        await _dataProvider.readAllLeadContactSessionStatuses();
    notifyListeners();
  }

  // Create a new leadContactSessionStatus and update the state
  Future<void> createLeadContactSessionStatus(
      LeadContactSessionStatusModel leadContactSessionStatus) async {
    await _dataProvider
        .createLeadContactSessionStatus(leadContactSessionStatus);
    _leadContactSessionStatuses.add(leadContactSessionStatus);
    notifyListeners();
  }

  // Read a single leadContactSession by its ID
  Future<LeadContactSessionStatusModel?> readLeadContactSessionStatus(
      String id) async {
    return await _dataProvider.readLeadContactSessionStatus(id);
  }

  Future<List<LeadContactSessionStatusModel>>
      readAllLeadContactSessionStatuses() async {
    return await _dataProvider.readAllLeadContactSessionStatuses();
  }

  // Update an existing leadContactSessionStatus by its ID
  Future<void> updateLeadContactSessionStatus(
      String id, Map<String, dynamic> data) async {
    await _dataProvider.updateLeadContactSessionStatus(id, data);
  }

  // Delete a leadContactSessionStatus by its ID
  Future<void> deleteLeadContactSessionStatus(String id) async {
    await _dataProvider.deleteLeadContactSessionStatus(id);
    _leadContactSessionStatuses
        .removeWhere((leadContactSessionStatus) => id == id);
    notifyListeners();
  }
}
