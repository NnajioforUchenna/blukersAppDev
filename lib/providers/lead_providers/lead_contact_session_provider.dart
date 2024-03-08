import 'package:flutter/foundation.dart';
import '../../models/lead_models/lead_contact_session_model.dart';
import '../../data_providers/lead_data_providers/lead_contact_session_data_provider.dart';

class LeadContactSessionsProvider with ChangeNotifier {
  final LeadContactSessionDataProvider _dataProvider =
      LeadContactSessionDataProvider();
  List<LeadContactSessionModel> _leadContactSessions = [];

  List<LeadContactSessionModel> get leadContactSession => _leadContactSessions;

  // Initialize the provider by fetching the initial leadContactSession data
  Future<void> initialize() async {
    _leadContactSessions = await _dataProvider.readAllLeadContactSessions();
    notifyListeners();
  }

  // Create a new leadContactSession and update the state
  Future<void> createLeadContactSession(
      LeadContactSessionModel leadContactSession) async {
    await _dataProvider.createLeadContactSession(leadContactSession);
    _leadContactSessions.add(leadContactSession);
    notifyListeners();
  }

  // Read a single leadContactSession by its ID
  Future<LeadContactSessionModel?> readLeadContactSession(String id) async {
    return await _dataProvider.readLeadContactSession(id);
  }

  Future<List<LeadContactSessionModel>> readAllLeadContactSessions() async {
    return await _dataProvider.readAllLeadContactSessions();
  }

  // Update an existing leadContactSession by its ID
  Future<void> updateLeadContactSession(
      String id, Map<String, dynamic> data) async {
    await _dataProvider.updateLeadContactSession(id, data);
  }

  // Delete a leadContactSession by its ID
  Future<void> deleteLeadContactSession(String id) async {
    await _dataProvider.deleteLeadContactSession(id);
    _leadContactSessions.removeWhere((leadContactSession) => id == id);
    notifyListeners();
  }
}
