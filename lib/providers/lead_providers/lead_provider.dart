import 'package:flutter/foundation.dart';
import 'package:blukers/models/lead_models/lead_model.dart';
import 'package:blukers/data_providers/lead_data_providers/lead_data_provider.dart';

class LeadProvider with ChangeNotifier {
  final LeadDataProvider _dataProvider = LeadDataProvider();
  List<LeadModel> _lead = [];

  List<LeadModel> get lead => _lead;

  // Initialize the provider by fetching the initial lead data
  Future<void> initialize() async {
    _lead = await _dataProvider.readAllLeads();
    notifyListeners();
  }

  // Create a new lead and update the state
  Future<void> createLead(LeadModel lead) async {
    await _dataProvider.createLead(lead);
    _lead.add(lead);
    notifyListeners();
  }

  // Read a single lead by its ID
  Future<LeadModel?> readLead(String id) async {
    return await _dataProvider.readLead(id);
  }

  Future<List<LeadModel>> readAllLeads() async {
    return await _dataProvider.readAllLeads();
  }

  // Update an existing lead by its ID
  Future<void> updateLead(String id, Map<String, dynamic> data) async {
    await _dataProvider.updateLead(id, data);
  }

  // Delete a lead by its ID
  Future<void> deleteLead(String id) async {
    await _dataProvider.deleteLead(id);
    _lead.removeWhere((lead) => id == id);
    notifyListeners();
  }
}
