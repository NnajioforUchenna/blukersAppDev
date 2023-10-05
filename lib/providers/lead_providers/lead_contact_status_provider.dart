import 'package:flutter/foundation.dart';
import 'package:blukers/models/lead_models/lead_contact_status_model.dart';
import 'package:blukers/data_providers/lead_data_providers/lead_contact_status_data_provider.dart';

class LeadContactStatusProvider with ChangeNotifier {
  final LeadContactStatusDataProvider _dataProvider =
      LeadContactStatusDataProvider();
  List<LeadContactStatusModel> _leadContactStatus = [];

  List<LeadContactStatusModel> get leadContactStatus => _leadContactStatus;

  // Initialize the provider by fetching the initial leadContactStatus data
  Future<void> initialize() async {
    _leadContactStatus = await _dataProvider.readAllLeadContactStatuses();
    notifyListeners();
  }

  // Create a new leadContactStatus and update the state
  Future<void> createLeadContactStatus(
      LeadContactStatusModel leadContactStatus) async {
    await _dataProvider.createLeadContactStatus(leadContactStatus);
    _leadContactStatus.add(leadContactStatus);
    notifyListeners();
  }

  // Read a single leadContactStatus by its ID
  Future<LeadContactStatusModel?> readLeadContactStatus(String id) async {
    return await _dataProvider.readLeadContactStatus(id);
  }

  Future<List<LeadContactStatusModel>> readAllLeadContactStatuses() async {
    return await _dataProvider.readAllLeadContactStatuses();
  }

  // Update an existing leadContactStatus by its ID
  Future<void> updateLeadContactStatus(
      String id, Map<String, dynamic> data) async {
    await _dataProvider.updateLeadContactStatus(id, data);
  }

  // Delete a leadContactStatus by its ID
  Future<void> deleteLeadContactStatus(String id) async {
    await _dataProvider.deleteLeadContactStatus(id);
    _leadContactStatus.removeWhere((leadContactStatus) => id == id);
    notifyListeners();
  }
}
