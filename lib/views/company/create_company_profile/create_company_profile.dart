import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../auth/common_widget/login_or_register.dart';
import 'Components/company_page_slider.dart';
import 'Components/company_timeline.dart';

class CreateCompanyProfile extends StatelessWidget {
  const CreateCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.appUser == null
    ? const LoginOrRegister()
    : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            CompanyTimeLine(),
            const Expanded(child: CompanyPageSlider()),
          ],
        ),
      );
  }
}
