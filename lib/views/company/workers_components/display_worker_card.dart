import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common_files/constants.dart';
import '../../../models/worker.dart';
import '../../../providers/worker_provider.dart';
import '../../../services/rounded_image.dart';

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
    WorkerProvider wp = Provider.of<WorkerProvider>(context);

    bool isWorkerSelected() {
      return wp.selectedWorker?.workerId == widget.worker?.workerId;
    }

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
              borderRadius: BorderRadius.circular(10),
            ),
            child: AnimatedContainer(
              padding: const EdgeInsets.all(20),
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color:
                    isWorkerSelected() ? const Color(0xFFE5EDFF) : Colors.white,
                border: Border(
                  left: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.worker?.timeAgo ?? ''),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        widget.worker?.firstName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.worker?.lastName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.worker?.workStatus == WorkStatus.activelyLooking
                            ? 'Actively Looking'
                            : 'Hired',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.worker?.skillIds.join(', ') ??
                                  '', // TODO: Change this to worker?.jobIds?.join(', ') ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.worker?.location!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      if (widget.worker?.profilePhotoUrl != null)
                        RoundedImageWidget(
                          imageUrl: widget.worker!.profilePhotoUrl,
                          firstChar:
                              getFirstChar(widget.worker?.lastName ?? ''),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
