import 'package:flutter/foundation.dart';
import '../../models/lead_models/lead_contact_method_model.dart';
import '../../data_providers/lead_data_providers/lead_contact_method_data_provider.dart';

class LeadContactMethodProvider with ChangeNotifier {
  final LeadContactMethodDataProvider _dataProvider =
      LeadContactMethodDataProvider();
  List<LeadContactMethodModel> _leadContactMethod = [];

  List<LeadContactMethodModel> get leadContactMethod => _leadContactMethod;

  // Initialize the provider by fetching the initial leadContactMethod data
  Future<void> initialize() async {
    _leadContactMethod = await _dataProvider.readAllLeadContactMethods();
    notifyListeners();
  }

  // Create a new leadContactMethod and update the state
  Future<void> createLeadContactMethod(
      LeadContactMethodModel leadContactMethod) async {
    await _dataProvider.createLeadContactMethod(leadContactMethod);
    _leadContactMethod.add(leadContactMethod);
    notifyListeners();
  }

  // Read a single leadContactMethod by its ID
  Future<LeadContactMethodModel?> readLeadContactMethod(String id) async {
    return await _dataProvider.readLeadContactMethod(id);
  }

  Future<List<LeadContactMethodModel>> readAllLeadContactMethods() async {
    return await _dataProvider.readAllLeadContactMethods();
  }

  // Update an existing leadContactMethod by its ID
  Future<void> updateLeadContactMethod(
      String id, Map<String, dynamic> data) async {
    await _dataProvider.updateLeadContactMethod(id, data);
  }

  // Delete a leadContactMethod by its ID
  Future<void> deleteLeadContactMethod(String id) async {
    await _dataProvider.deleteLeadContactMethod(id);
    _leadContactMethod.removeWhere((leadContactMethod) => id == id);
    notifyListeners();
  }
}
