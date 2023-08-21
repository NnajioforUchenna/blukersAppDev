import 'package:flutter/material.dart';

import 'company_page_slider.dart';
import 'company_timeline.dart';

class CreateCompanyProfile extends StatelessWidget {
  const CreateCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // title: const Center(
        //   child: Text(
        //     'Creating My Work Profile',
        //     style: ThemeTextStyles.appBarThemeTextStyle,
        //   ),
        // ),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                CompanyTimeLine(),
                const SizedBox(
                  height: 30.0,
                ),
                CompanyPageSlider()
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
