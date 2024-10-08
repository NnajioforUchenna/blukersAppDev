import 'package:auto_size_text/auto_size_text.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.group,
            text: 'My Workers',
            route: '/myJobPosts',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.search,
            text: 'Search Workers',
            route: '/searchWorkers',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.support,
            text: 'Services',
            route: '/companyOffers',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.person,
            text: 'Company Profile',
            route: '/companyProfile',
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

  Widget _createDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String text,
    required String route,
  }) {
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
        Navigator.pop(context);
        context.go(route);
      },
    );
  }
}
