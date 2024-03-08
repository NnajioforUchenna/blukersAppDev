import 'create_worker_profile_components/worker_page_slider.dart';
import 'create_worker_profile_components/worker_timeline.dart';
import 'package:flutter/material.dart';

class CreateWorkerProfile extends StatelessWidget {
  const CreateWorkerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          WorkerTimeLine(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const WorkerPageSlider(),
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
