import 'package:flutter/material.dart';

import '../../../services/responsive.dart';
import 'worker_desktop_search_bar.dart';
import 'worker_mobile_search_bar.dart';

class AllSearchBar extends StatefulWidget {
  const AllSearchBar({super.key});

  @override
  State<AllSearchBar> createState() => _AllSearchBarState();
}

class _AllSearchBarState extends State<AllSearchBar> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: MobileSearchBar(),
      desktop: DesktopSearchBar(),
    );
  }
}
