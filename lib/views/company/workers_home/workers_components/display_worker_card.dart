import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../common_files/constants.dart';
import '../../../../models/worker.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../providers/worker_provider.dart';
import '../../../../services/rounded_image.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../../old_common_views/worker_timeline/display_worker_timeline_dialog.dart';

class DisplayWorkerCard extends StatefulWidget {
  final Worker? worker;
  final VoidCallback? onTap;

  const DisplayWorkerCard({
    super.key,
    this.worker,
    this.onTap,
  });

  @override
  _DisplayWorkerCardState createState() => _DisplayWorkerCardState();
}

class _DisplayWorkerCardState extends State<DisplayWorkerCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);

    bool isWorkerSelected() {
      return wp.selectedWorker?.workerId == widget.worker?.workerId;
    }

    UserProvider up = Provider.of<UserProvider>(context);

    bool isWorkerSaved = up.isWorkerSaved(widget.worker?.workerId ?? "");

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: InkWell(
        onTap: widget.onTap,
        child: Transform(
          transform: Matrix4.translationValues(0, _isHovering ? -5 : 0, 0),
          child: Card(
            elevation: _isHovering ? 10 : 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                    width: isWorkerSelected() ? 2 : 1,
                    color: isWorkerSelected()
                        ? const Color(0xFF1E75BB).withOpacity(.20)
                        : Colors.black.withOpacity(.2))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: isWorkerSelected()
                      ? const Color(0xFFE5EDFF)
                      : Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: 15, top: 20, right: 25, left: 25),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isWorkerSelected()
                                ? const Color(0xFF1E75BB).withOpacity(.20)
                                : Colors.black.withOpacity(.2),
                            width: isWorkerSelected() ? 2 : 1,
                          ),
                        ),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.worker?.profilePhotoUrl != null)
                              RoundedImageWidget(
                                size: 40,
                                imageUrl: widget.worker!.profilePhotoUrl,
                                firstChar: getFirstChar(widget.worker
                                        ?.workerResumeDetails?.lastName ??
                                    ''),
                              ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      "${widget.worker?.workerResumeDetails?.firstName ?? '--'} ${widget.worker?.workerResumeDetails?.lastName ?? '--'}",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxFontSize: 22,
                                      minFontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () async {
                                WorkersProvider wp =
                                    Provider.of<WorkersProvider>(context,
                                        listen: false);
                                if (up.companyTimelineStep < 2) {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const DisplayWorkerTimelineDialog());
                                } else {
                                  if (widget.worker == null) {
                                    return;
                                  }

                                  if (!isWorkerSaved) {
                                    up.updateUI(widget.worker!.workerId);
                                    wp.addInterestingWorker(
                                        up.appUser, widget.worker!);
                                  }
                                }
                              },
                              icon: Icon(
                                Icons.bookmark,
                                color: isWorkerSaved
                                    ? ThemeColors.secondaryThemeColor
                                    : Colors.grey,
                                size: 30,
                              ),
                            )
                          ]),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined,
                                    size: 15,
                                    color: ThemeColors.black1ThemeColor),
                                const SizedBox(width: 5),
                                Text(
                                  widget.worker?.location!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeColors.black1ThemeColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 10,
                              children: [
                                InfoContainer(
                                    isSelected: isWorkerSelected(),
                                    text: widget.worker?.workStatus == 0
                                        ? 'Availlable'
                                        : 'Hired'),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ]),
                    ),

                    // Text(widget.worker?.timeAgo ?? ''),
                    // const SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Text(
                    //       widget.worker?.workerResumeDetails?.firstName ?? '',
                    //       style: const TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 18,
                    //       ),
                    //     ),
                    //     const SizedBox(width: 10),
                    //     Text(
                    //       widget.worker?.workerResumeDetails?.lastName ?? '',
                    //       style: const TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 18,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // const SizedBox(height: 10),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       widget.worker?.workStatus == 0
                    //           ? 'Actively Looking'
                    //           : 'Hired',
                    //       style: const TextStyle(
                    //         color: Colors.green,
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             widget.worker?.workerResumeDetails?.skillIds
                    //                     ?.join(', ') ??
                    //                 '', // TODO: Change this to worker?.jobIds?.join(', ') ?? '',
                    //             style: const TextStyle(
                    //               fontSize: 18,
                    //               color: Colors.grey,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //             maxLines: 2,
                    //             overflow: TextOverflow.ellipsis,
                    //           ),
                    //           Text(
                    //             widget.worker?.location!,
                    //             maxLines: 1,
                    //             overflow: TextOverflow.ellipsis,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  final String text;
  final bool isSelected;
  const InfoContainer(
      {super.key, required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isSelected
            ? const Color(0xFFB0DAFF)
            : const Color.fromRGBO(129, 129, 129, 0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          text,
          style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? const Color.fromRGBO(96, 96, 96, 1)
                  : Colors.black),
        ),
      ),
    );
  }
}
