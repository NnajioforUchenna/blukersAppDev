import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/company/company_chat/mobile_company_chat/components/company_chat_list.dart';
import 'package:blukers/views/company/company_chat/web_company_chat/web_company_chat_interface.dart';
import 'package:flutter/material.dart';

class CompanyChat extends StatelessWidget {
  const CompanyChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const CompanyChatList()
        : const WebCompanyChat();
  }
}
