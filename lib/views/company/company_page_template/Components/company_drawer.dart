import 'package:auto_size_text/auto_size_text.dart';
import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CompanyDrawer extends StatelessWidget {
  const CompanyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            color: ThemeColors.primaryThemeColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.person,
            text: 'Choose Account Type',
            route: '/',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.home,
            text: 'Workers Home',
            route: '/workers',
            currentPageIndex: 0,
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.group,
            text: 'My Workers',
            route: '/myJobPosts',
            currentPageIndex: 1,
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.search,
            text: 'Search Workers',
            route: '/searchWorkers',
            currentPageIndex: 2,
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.support,
            text: 'Services',
            route: '/companyOffers',
            currentPageIndex: 3,
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.person,
            text: 'Company Profile',
            route: '/companyProfile',
            currentPageIndex: 4,
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.work,
            text: 'Create Company Profile',
            route: '/createCompanyProfile',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.person,
            text: 'Create a Job Post',
            route: '/createJobPost',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.route,
            text: 'Path to Employing a Worker',
            route: '/pathToEmployingWorker',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.chat,
            text: 'Chat with Potential Employees',
            route: '/companyChat',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.notifications,
            text: 'Hiring Alerts & Messages',
            route: '/companyMessages',
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {required BuildContext context,
      required IconData icon,
      required String text,
      required String route,
      int? currentPageIndex}) {
    return ListTile(
      title: Column(
        children: [
          Row(
            children: <Widget>[
              Icon(icon),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: AutoSizeText(
                    text,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
      onTap: () {
        if (currentPageIndex != null) {
          Provider.of<UserProvider>(context, listen: false)
              .updateNavigationIndex(currentPageIndex);
        }
        Navigator.pop(context);
        context.go(route);
      },
    );
  }
}
