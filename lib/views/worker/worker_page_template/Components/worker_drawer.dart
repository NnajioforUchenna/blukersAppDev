import 'package:auto_size_text/auto_size_text.dart';
import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WorkerDrawer extends StatelessWidget {
  const WorkerDrawer({super.key});

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
            icon: Icons.work,
            text: 'Jobs',
            route: '/jobs',
            currentPageIndex: 0,
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.corporate_fare_outlined,
            text: 'Select By Industry',
            route: '/selectJobs',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.search,
            text: 'Search',
            route: '/searchJobs',
            currentPageIndex: 2,
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.save,
            text: 'Saved Jobs',
            route: '/myJobs',
            currentPageIndex: 1,
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.support,
            text: 'Services',
            route: '/workerOffers',
            currentPageIndex: 3,
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.person,
            text: 'Profile',
            route: '/workerProfile',
            currentPageIndex: 4,
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.work_history,
            text: 'Create your Resume',
            route: '/createResume',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.route,
            text: 'Path to a Successful Job',
            route: '/pathToJob',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.chat,
            text: 'Chat with Potential Employers',
            route: '/workerChat',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.notifications,
            text: 'Job Alerts & Messages',
            route: '/messenger',
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
    int? currentPageIndex,
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
