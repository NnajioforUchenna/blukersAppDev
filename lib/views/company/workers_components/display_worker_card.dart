import 'package:flutter/material.dart';

import '../../../models/worker.dart';

class DisplayWorkerCard extends StatefulWidget {
  final Worker? worker;
  final VoidCallback? onTap;

  const DisplayWorkerCard({
    Key? key,
    this.worker,
    this.onTap,
  }) : super(key: key);

  @override
  _DisplayWorkerCardState createState() => _DisplayWorkerCardState();
}

class _DisplayWorkerCardState extends State<DisplayWorkerCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.worker?.firstName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      if (widget.worker?.profilePhotoUrl != null)
                        Image.network(
                          widget.worker!.profilePhotoUrl!,
                          height: 50,
                          width: 50,
                        ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.worker?.lastName ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.worker?.workerBriefDescription ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
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
                  SizedBox(height: 5),
                  Text(
                    widget.worker?.emails.join(', ') ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
