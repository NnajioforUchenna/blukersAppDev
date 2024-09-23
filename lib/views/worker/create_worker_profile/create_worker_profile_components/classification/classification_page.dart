import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/industry.dart';
import '../../../../../../providers/industry_provider.dart';
import '../../../../../../services/responsive.dart';
import '../../../../../../utils/localization/localized_industries.dart';
import '../../../../../../utils/localization/localized_jobs.dart';
import '../../../../../providers/create_worker_profile_provider.dart';
import '../timeline_navigation_button.dart';

class ClassificationPage extends StatefulWidget {
  const ClassificationPage({super.key});

  @override
  State<ClassificationPage> createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  @override
  Widget build(BuildContext context) {
    IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
    CreateWorkerProfileProvider cwpp =
        Provider.of<CreateWorkerProfileProvider>(context);

    List<Industry> industries = ip.industries.values.toList();

    bool areJobsSelected() {
      return cwpp.selectedJobs.entries.any((entry) => entry.value.isNotEmpty);
    }

    return Container(
      color: Colors.white,
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            if (industries.isEmpty)
              const Center(child: CircularProgressIndicator()),
            ...industries.map((industry) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                        LocalizedIndustries.get(context, industry.name),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                        ),
                        trailing: cwpp.selectedIndustries.contains(industry.industryId)
                          ? Transform.rotate(
                            angle: 3.14, // Rotate 180 degrees
                            child: SvgPicture.asset(
                              'assets/icons/arrow_down.svg',
                              height: 20,
                              width: 20,
                            ),
                            )
                          : SvgPicture.asset(
                            'assets/icons/arrow_down.svg',
                            height: 20,
                            width: 20,
                          ),
                        onTap: () {
                        setState(() {
                          if (cwpp.selectedIndustries
                            .contains(industry.industryId)) {
                          cwpp.selectedIndustries.remove(industry.industryId);
                          cwpp.selectedJobs.remove(industry.industryId);
                          } else {
                          cwpp.selectedIndustries.add(industry.industryId);
                          }
                        });
                        },
                      ),
                      if (cwpp.selectedIndustries.contains(industry.industryId))
                        ...industry.jobs.entries.map((entry) {
                          final jobId = entry.value.title;
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: CheckboxListTile(
                              title: Text(
                                LocalizedJobs.get(context, jobId),
                                style: TextStyle(
                                  color: Colors.blueGrey[700],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200,
                                  height: 1.25,
                                ),
                              ),
                              value: cwpp.selectedJobs[industry.industryId]
                                      ?.contains(jobId) ??
                                  false,
                              onChanged: (bool? value) {
                                if (!cwpp.selectedJobs
                                    .containsKey(industry.industryId)) {
                                  cwpp.selectedJobs[industry.industryId] = [];
                                }
                                setState(() {
                                  if (value == true) {
                                    cwpp.selectedJobs[industry.industryId]!
                                        .add(jobId);
                                  } else {
                                    cwpp.selectedJobs[industry.industryId]!
                                        .remove(jobId);
                                  }
                                });
                              },
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimelineNavigationButton(
                  isSelected: true, // Always enable the home button
                  onPress: () {
                    context.go('/jobs');
                  },
                  navDirection: 'left',
                ),
                const Spacer(),
                TimelineNavigationButton(
                  isSelected: areJobsSelected(),
                  onPress: areJobsSelected()
                      ? () {
                          cwpp.createWorkerProfile(
                            context,
                            cwpp.selectedIndustries,
                            cwpp.selectedJobs,
                          );
                        }
                      : () {}, // Disable the button if no jobs are selected
                ),
              ],
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
