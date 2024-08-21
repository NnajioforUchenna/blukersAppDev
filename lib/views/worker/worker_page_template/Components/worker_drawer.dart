import 'package:auto_size_text/auto_size_text.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
            icon: Icons.corporate_fare_outlined,
            text: 'Select By Industry',
            route: '/selectJobs',
          ),

          _createDrawerItem(
            context: context,
            icon: Icons.save,
            text: 'Saved Jobs',
            route: '/myJobs',
          ),
          _createDrawerItem(
            context: context,
            icon: Icons.design_services,
            text: 'Services',
            route: '/workerOffers',
          ),

          _createDrawerItem(
            context: context,
            icon: Icons.question_answer_outlined,
            text: 'FAQ',
            route: '/workerFAQ',
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
