import 'package:flutter/material.dart';

import 'company_page_slider.dart';
import 'company_timeline.dart';

class CreateCompanyProfile extends StatelessWidget {
  const CreateCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.white,
    //     elevation: 0,
    //   ),
    //   body: Center(
    //     child: SizedBox(
    //       height: MediaQuery.of(context).size.height,
    //       child: CustomScrollView(
    //         slivers: [
    //           SliverList(
    //               delegate: SliverChildListDelegate([
    //             CompanyTimeLine(),
    //             const SizedBox(height: 30.0),
    //             CompanyPageSlider()
    //           ]))
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          CompanyTimeLine(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const CompanyPageSlider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
