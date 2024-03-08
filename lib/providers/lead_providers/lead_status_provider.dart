import 'package:flutter/foundation.dart';
import '../../models/lead_models/lead_status_model.dart';
import '../../data_providers/lead_data_providers/lead_status_data_provider.dart';

class LeadStatusProvider with ChangeNotifier {
  final LeadStatusDataProvider _dataProvider = LeadStatusDataProvider();
  List<LeadStatusModel> _leadStatus = [];

  List<LeadStatusModel> get leadStatus => _leadStatus;

  // Initialize the provider by fetching the initial leadStatus data
  Future<void> initialize() async {
    _leadStatus = await _dataProvider.readAllLeadStatuses();
    notifyListeners();
  }

  // Create a new leadStatus and update the state
  Future<void> createLead(LeadStatusModel leadStatus) async {
    await _dataProvider.createLeadStatus(leadStatus);
    _leadStatus.add(leadStatus);
    notifyListeners();
  }

  // Read a single leadStatus by its ID
  Future<LeadStatusModel?> readLeadStatus(String id) async {
    return await _dataProvider.readLeadStatus(id);
  }

  Future<List<LeadStatusModel>> readAllLeadStatuses() async {
    return await _dataProvider.readAllLeadStatuses();
  }

  // Update an existing leadStatus by its ID
  Future<void> updateLead(String id, Map<String, dynamic> data) async {
    await _dataProvider.updateLeadStatus(id, data);
  }

  // Delete a leadStatus by its ID
  Future<void> deleteLeadStatus(String id) async {
    await _dataProvider.deleteLeadStatus(id);
    _leadStatus.removeWhere((leadStatus) => id == id);
    notifyListeners();
  }
}
