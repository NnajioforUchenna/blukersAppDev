import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/company/company_chat/mobile_company_chat/components/company_chat_list.dart';
import 'package:blukers/views/company/company_chat/web_company_chat/web_company_chat_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/common_widget/login_or_register.dart';
import '../common_widgets/please_create_company_profile.dart';

class CompanyChat extends StatelessWidget {
  const CompanyChat({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.appUser == null
        ? const LoginOrRegister()
        : up.isUserCompanyProfile()
            ? Responsive.isMobile(context)
                ? const CompanyChatList()
                : const WebCompanyChat()
            : const PleaseCreateCompanyProfile();
  }
}
