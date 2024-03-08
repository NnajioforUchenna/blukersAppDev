import 'package:flutter/foundation.dart';
import '../../models/lead_models/lead_contact_model.dart';
import '../../data_providers/lead_data_providers/lead_contact_data_provider.dart';

class LeadContactProvider with ChangeNotifier {
  final LeadContactDataProvider _dataProvider = LeadContactDataProvider();
  List<LeadContactModel> _leadContact = [];

  List<LeadContactModel> get leadContact => _leadContact;

  // Initialize the provider by fetching the initial leadContact data
  Future<void> initialize() async {
    _leadContact = await _dataProvider.readAllLeadContacts();
    notifyListeners();
  }

  // Create a new leadContact and update the state
  Future<void> createLeadContact(LeadContactModel leadContact) async {
    await _dataProvider.createLeadContact(leadContact);
    _leadContact.add(leadContact);
    notifyListeners();
  }

  // Read a single leadContact by its ID
  Future<LeadContactModel?> readLeadContact(String id) async {
    return await _dataProvider.readLeadContact(id);
  }

  Future<List<LeadContactModel>> readAllLeadContacts() async {
    return await _dataProvider.readAllLeadContacts();
  }

  // Update an existing leadContact by its ID
  Future<void> updateLeadContact(String id, Map<String, dynamic> data) async {
    await _dataProvider.updateLeadContact(id, data);
  }

  // Delete a leadContact by its ID
  Future<void> deleteLeadContact(String id) async {
    await _dataProvider.deleteLeadContact(id);
    _leadContact.removeWhere((leadContact) => id == id);
    notifyListeners();
  }
}
