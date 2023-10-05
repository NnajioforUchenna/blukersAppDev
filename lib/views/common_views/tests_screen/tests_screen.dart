import 'package:flutter/material.dart';
import 'package:blukers/views/common_views/tests_screen/crud/crud.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  @override
  Widget build(BuildContext context) {
    return const CRUD();
  }
}

// USE TEMPLATE BELOW FOR A NEW TEST:
/*
import 'package:blukers/providers/app_versions_provider.dart';
import 'package:blukers/providers/chat_provider.dart';
import 'package:blukers/providers/user_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/auth/common_widget/login_or_register.dart';
import 'package:blukers/views/common_views/components/app_version_display.dart';
import 'package:blukers/views/common_views/profile_dialog.dart';
import 'package:blukers/views/common_views/profile_section.dart';
import 'package:blukers/views/company/profile_components/edit_basic_profile.dart';
import 'package:blukers/views/company/profile_components/user_basic_profile_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import 'package:blukers/views/common_views/page_template/page_template.dart';
class TestsScreenTemplate extends StatefulWidget {
  const TestsScreenTemplate({super.key});
  @override
  State<TestsScreenTemplate> createState() => _TestsScreenTemplateState();
}
class _TestsScreenTemplateState extends State<TestsScreenTemplate> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
*/