import 'package:auto_size_text/auto_size_text.dart';
import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/providers/worker_provider.dart';
import 'package:blukers/views/company/common_widgets/please_create_company_profile.dart';
import 'package:blukers/views/company/company_chat/mobile_company_chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../models/worker.dart';
import '../../../../providers/company_chat_provider.dart';
import '../../../../services/responsive.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../../old_common_views/worker_timeline/display_worker_timeline_dialog.dart';
import 'worker_details_components/worker_detail_block_five.dart';
import 'worker_details_components/worker_detail_block_four.dart';
import 'worker_details_components/worker_detail_block_one.dart';
import 'worker_details_components/worker_detail_block_three.dart';
import 'worker_details_components/worker_detail_block_two.dart';
// Replace with your actual path.

class WorkerDisplayDetailsWidget extends StatefulWidget {
  final Worker worker;
  const WorkerDisplayDetailsWidget({
    super.key,
    required this.worker,
  });

  @override
  State<WorkerDisplayDetailsWidget> createState() =>
      _WorkerDisplayDetailsWidgetState();
}

class _WorkerDisplayDetailsWidgetState extends State<WorkerDisplayDetailsWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = CurvedAnimation(
        parent: _controller, curve: Curves.easeInOut); // Add a curve
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant WorkerDisplayDetailsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.worker != widget.worker) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Worker worker = widget.worker;
    UserProvider up = Provider.of<UserProvider>(context);
      
    bool isWorkerSaved = up.isWorkerSaved(worker.workerId);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: Responsive.isMobile(context)? BorderSide.none: BorderSide(width: 2, color: Colors.black.withOpacity(.2))),
        child: FadeTransition(
          opacity: _animation,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.symmetric(
            horizontal: Responsive.isMobile(context) ? 12 : 33, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WorkerDetailBlockOne(worker: worker),
                      WorkerDetailBlockTwo(worker: worker),
                      WorkerDetailBlockThree(worker: worker),
                      WorkerDetailBlockFour(
                        workExperiences:
                            worker.workerResumeDetails?.workExperiences ?? [],
                      ),
                      WorkerDetailBlockFive(
                        skills: worker.workerResumeDetails?.skillIds ?? [],
                      ),
                    ],
                  ),
                ),
              ),
                if(Responsive.isMobile(context))  Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 14),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(17),
                        bottomLeft: Radius.circular(17)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1A000000),
                        offset: Offset(0, -2),
                        blurRadius: 9,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ThemeColors.secondaryThemeColorDark,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                                CompanyChatProvider cp = Provider.of<CompanyChatProvider>(context,listen: false);
                                // Add functionality for Chat
                              if (up.companyTimelineStep < 2) {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const DisplayWorkerTimelineDialog());
                              } else {
                                cp.companyStartChat(up.appUser, worker);
                                showDialog(
                                    context: context,
                                    builder: (context) => up
                                            .isUserCompanyProfile()
                                        ? Container(
                                            padding:
                                                Responsive.isDesktop(context)
                                                    ? const EdgeInsets.all(150)
                                                    : const EdgeInsets.all(30),
                                            child:
                                                const CompanyChatRoomScreen())
                                        : const PleaseCreateCompanyProfile());
                              }
                            },
                            child: Center(
                              child: AutoSizeText(
                                "Send Message",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 21),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                      color: ThemeColors
                                          .secondaryThemeColorDark)),
                            ),
                            onPressed: () async {
                                  WorkersProvider wp = Provider.of<WorkersProvider>(context, listen: false);
                               if (up.companyTimelineStep < 2) {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const DisplayWorkerTimelineDialog());
                              } else {
                                if (!isWorkerSaved) {
                                  up.updateUI(worker.workerId);
                                  wp.addInterestingWorker(up.appUser, worker);
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(isWorkerSaved ? 'Saved' : 'Save',
                                    style: GoogleFonts.montserrat(
                                        color: ThemeColors
                                            .secondaryThemeColorDark,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                                const SizedBox(width: 5),
                                Icon(
                                  isWorkerSaved
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: ThemeColors.secondaryThemeColorDark,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
