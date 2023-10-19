import 'package:blukers/views/worker/create_worker_profile_component/worker_page_slider.dart';
import 'package:blukers/views/worker/create_worker_profile_component/worker_timeline.dart';
import 'package:flutter/material.dart';

class CreateWorkerProfile extends StatelessWidget {
  const CreateWorkerProfile({super.key});

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
    //       // width: Responsive.isDesktop(context)
    //       //     ? MediaQuery.of(context).size.width * 0.3
    //       //     : MediaQuery.of(context).size.width,
    //       child: CustomScrollView(
    //         slivers: [
    //           SliverList(
    //               delegate: SliverChildListDelegate([
    //             WorkerTimeLine(),
    //             const SizedBox(
    //               height: 30.0,
    //             ),
    //             WorkerPageSlider(),
    //             const SizedBox(
    //               height: 30.0,
    //             ),
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
