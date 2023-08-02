import 'package:bulkers/views/worker/create_worker_profile_component/worker_page_slider.dart';
import 'package:bulkers/views/worker/create_worker_profile_component/worker_timeline.dart';
import 'package:flutter/material.dart';

import '../../../services/responsive.dart';
import '../../../utils/styles/theme_text_styles.dart';

class CreateWorkerProfile extends StatelessWidget {
  const CreateWorkerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Creating My Work Profile',
            style: ThemeTextStyles.headerThemeTextStyle,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width,
          child: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                WorkerTimeLine(),
                const SizedBox(
                  height: 30.0,
                ),
                WorkerPageSlider()
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
