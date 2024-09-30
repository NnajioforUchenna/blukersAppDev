import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/worker/worker_profile/worker_profile_mobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../auth/common_widget/login_or_register.dart';
import '../services/services_components/orders/orders_list.dart';
import 'profile_rows/profile_row_five/update_industry.dart';
import 'profile_rows/profile_row_four/update_user_information.dart';
import 'profile_rows/profile_row_nine/delete_profile_page.dart';
import 'profile_rows/profile_row_seven/subscription_widgets.dart';
import 'profile_rows/profile_row_six/update_resume.dart';

class WorkerProfile extends StatefulWidget {
  const WorkerProfile({super.key});

  @override
  State<WorkerProfile> createState() => _WorkerProfileState();
}

class _WorkerProfileState extends State<WorkerProfile> {
  Widget getPageByIndex() {
    switch (index) {
      case 0:
        return const UpdateUserInformation();
      case 1:
        return const UpdateIndustry();
      case 2:
        return const UpdateResume();
      case 3:
        return const SubscriptionWidgetDesktop();
      case 4:
        return const OrdersList();
      case 5:
        return const DeleteAccountPage();
    }
    return const SizedBox.shrink();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);

    return up.appUser == null
        ? const LoginOrRegister()
        : Responsive(
            mobile: Padding(
              padding: const EdgeInsets.only(top: 56, left: 24, right: 24),
              child: WorkerProfileMobile(
                index: index,
                onTapDesktop: (int i) {
                  setState(() {
                    index = i;
                  });
                },
              ),
            ),
            desktop: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: Container(
                  padding: const EdgeInsets.only(top: 40),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            margin: const EdgeInsets.only(right: 34),
                            child: WorkerProfileMobile(
                              index: index,
                              onTapDesktop: (int i) {
                                setState(() {
                                  index = i;
                                });
                              },
                            )),
                      ),
                      Expanded(
                          flex: 8,
                          child: index == 3
                              ? SingleChildScrollView(
                                clipBehavior: Clip.none,
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 640, 
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0x1A000000),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 3,
                                                ),
                                                BoxShadow(
                                                  color: Color(0x17000000),
                                                  offset: Offset(0, 6),
                                                  blurRadius: 6,
                                                ),
                                                BoxShadow(
                                                  color: Color(0x0D000000),
                                                  offset: Offset(0, 14),
                                                  blurRadius: 9,
                                                ),
                                                BoxShadow(
                                                  color: Color(0x03000000),
                                                  offset: Offset(0, 25),
                                                  blurRadius: 10,
                                                ),
                                                BoxShadow(
                                                  color: Color(0x00F35507),
                                                  offset: Offset(0, 39),
                                                  blurRadius: 11,
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: const Color(0xFFF35507)
                                                      .withOpacity(.10))),
                                          child: getPageByIndex()),
                                      const SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x1A000000),
                                          offset: Offset(0, 2),
                                          blurRadius: 3,
                                        ),
                                        BoxShadow(
                                          color: Color(0x17000000),
                                          offset: Offset(0, 6),
                                          blurRadius: 6,
                                        ),
                                        BoxShadow(
                                          color: Color(0x0D000000),
                                          offset: Offset(0, 14),
                                          blurRadius: 9,
                                        ),
                                        BoxShadow(
                                          color: Color(0x03000000),
                                          offset: Offset(0, 25),
                                          blurRadius: 10,
                                        ),
                                        BoxShadow(
                                          color: Color(0x00F35507),
                                          offset: Offset(0, 39),
                                          blurRadius: 11,
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color(0xFFF35507)
                                              .withOpacity(.10))),
                                  child: getPageByIndex()))
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
