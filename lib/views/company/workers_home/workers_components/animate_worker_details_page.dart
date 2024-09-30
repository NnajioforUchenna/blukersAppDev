import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../providers/worker_provider.dart';
import '../../../old_common_views/components/animations/index.dart';
import 'display_worker_details.dart';

class AnimateWorkerDetails extends StatelessWidget {
  const AnimateWorkerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);

    if (wp.selectedWorker != null) {
      return WorkerDisplayDetailsWidget(
        worker: wp.selectedWorker!,
      );
    }else if(wp.selectedWorker == null){
       return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/empty_job.svg',
          ),
          const SizedBox(height: 38),
          Text(
            'Click on Worker to view',
            style: GoogleFonts.montserrat(
              fontSize: 16,
            ),
          ),
        ],
      ));
    }
     else if (wp.workersToDisplay.isNotEmpty) {
      return WorkerDisplayDetailsWidget(
        worker: wp.workersToDisplay.first,
      );
    } 
     else {
      return const Center(
          child: MyAnimation(
        name: 'blukersLoadingDots',
      ));
    }
  }
}
