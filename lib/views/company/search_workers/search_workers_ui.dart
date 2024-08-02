import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/company/search_workers/search_workers_mobile.dart';
import 'package:blukers/views/company/search_workers/search_workers_web.dart';
import 'package:blukers/views/company/search_workers/workers_search_result_page/components/worker_pop_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/job_posts_provider.dart';
import '../../../providers/worker_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import '../../old_common_views/components/animations/index.dart';

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