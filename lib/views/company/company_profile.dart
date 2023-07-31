import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/views/auth/common_widget/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_views/page_template/page_template.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return PageTemplate(
        child: up.appUser == null ? LoginOrRegister() : Container());
  }
}
