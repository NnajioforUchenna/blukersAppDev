import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/company/search_workers/search_workers_mobile.dart';
import 'package:blukers/views/company/search_workers/search_workers_web.dart';

import 'package:flutter/material.dart';

class SearchWorkersUi extends StatefulWidget {
  const SearchWorkersUi({super.key});

  @override
  State<SearchWorkersUi> createState() => _SearchWorkersUiState();
}

class _SearchWorkersUiState extends State<SearchWorkersUi> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String buttonLabel = 'Search Jobs';
  String searchName = 'Position, work area or company';
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const SearchWorkersUiMobile()
        : const SearchWorkersUiWeb();
  }
}