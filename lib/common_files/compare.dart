// import 'package:blukers/providers/app_settings_provider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../providers/industry_provider.dart';
// import '../../../providers/job_posts_provider.dart';
// import '../../common_views/all_search_bar_components/all_search_bar.dart';
// import '../../common_views/loading_page.dart';
// import '../../common_views/page_template/page_template.dart';
// import '../../common_views/select_industry_components/display_industries.dart';
// import '../jobs_and_componets/choose_target_language.dart';
// import '../jobs_and_componets/job_search_result_page.dart';
//
// class Jobs extends StatelessWidget {
//   const Jobs({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
//     JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
//     AppVersionsProvider avp = Provider.of<AppVersionsProvider>(context);
//
//     if (!kIsWeb) {
//       avp.checkForUpdate(context);
//     }
//
//     return PageTemplate(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             const AllSearchBar(),
//             // if (Responsive.isDesktop(context))
//             const SizedBox(
//               height: 10,
//             ),
//             // const Row(
//             //   mainAxisAlignment: MainAxisAlignment.end,
//             //   children: [
//             //     Spacer(),
//             //     SizedBox(height: 50, width: 200, child: ChooseTargetLanguage()),
//             //     SizedBox(width: 30)
//             //   ],
//             // ),
//             const Center(
//               child: ChooseTargetLanguage(),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Divider(),
//             AnimatedCrossFade(
//               firstChild: ip.industries.isEmpty
//                   ? LoadingPage()
//                   : const DisplayIndustries(),
//               secondChild: const JobSearchResultPage(),
//               crossFadeState: jp.isSearching
//                   ? CrossFadeState.showSecond
//                   : CrossFadeState.showFirst,
//               duration: const Duration(milliseconds: 500),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
