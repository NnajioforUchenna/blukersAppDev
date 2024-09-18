import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/providers/worker_chat_provider.dart';
import 'package:blukers/services/responsive.dart';
import 'package:blukers/utils/styles/theme_colors.dart';
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
    WorkerChatProvider wp = Provider.of<WorkerChatProvider>(context);
    int messageCount = wp.unreadMessageCount;
    return up.appUser == null
        ? const LoginOrRegister()
        : up.isUserCompanyProfile()
            ? Responsive.isMobile(context)
                ? Container(
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Messages",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: ThemeColors.black1ThemeColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              messageCount != 0
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromARGB(255, 234, 239, 243),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          messageCount.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          //vertical line
                          const SizedBox(height: 10),
                          const Divider(
                            color: ThemeColors.grey1ThemeColor,
                            thickness: 1,
                          ),
                          //searchbar
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 234, 239, 243),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: "Search Messages",
                                hintStyle: TextStyle(
                                  color: ThemeColors.grey1ThemeColor,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Expanded(child: CompanyChatList()),
                        ],
                      ),
                    ),
                )
                : const WebCompanyChat()
            : const PleaseCreateCompanyProfile();
  }
}
