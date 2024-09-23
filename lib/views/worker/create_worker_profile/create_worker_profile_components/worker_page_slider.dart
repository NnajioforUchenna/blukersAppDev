import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../services/make_responsive_web.dart';
import 'classification/classification_page.dart';
import 'personalInformation/personal_information_page.dart';
import 'professional_credentials/professional_credentials_page.dart';
import 'profile_photo_page.dart';
import 'reference/reference_page.dart';
import 'resume/resume_page.dart';
import 'work_experience/work_experience_page.dart';
import 'worker_congratulation_page.dart';

class WorkerPageSlider extends StatefulWidget {
  const WorkerPageSlider({super.key});

  @override
  State<WorkerPageSlider> createState() => _WorkerPageSliderState();
}

class _WorkerPageSliderState extends State<WorkerPageSlider> {
  @override
  Widget build(BuildContext context) {
    CreateWorkerProfileProvider cwpp =
        Provider.of<CreateWorkerProfileProvider>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: PageView(
            controller: cwpp.createProfilePageController,
            physics: const NeverScrollableScrollPhysics(),
            children:[
              Padding(
                padding: Responsive.isDesktop(context)
                    ? const EdgeInsets.only(left: 100, right: 100)
                    : const EdgeInsets.all(0),
                child: const ClassificationPage(),
              ),
              Padding(
                padding: Responsive.isDesktop(context)
                    ? const EdgeInsets.only(left: 100, right: 100)
                    : const EdgeInsets.all(0),
                child: const PersonalInformationPage(),
              ),
              Padding(
                padding: Responsive.isDesktop(context)
                    ? const EdgeInsets.only(left: 100, right: 100)
                    : const EdgeInsets.all(0),
                child: const ProfilePhotoPage(),
              ),
              Padding(
                padding: Responsive.isDesktop(context)
                    ? const EdgeInsets.only(left: 100, right: 100)
                    : const EdgeInsets.all(0),
                child: const ProfessionalCredentialsPage(),
              ),
              Padding(
                padding: Responsive.isDesktop(context)
                    ? const EdgeInsets.only(left: 100, right: 100)
                    : const EdgeInsets.all(0),
                child: const WorkExperiencePage(),
              ),
              Padding(
                padding: Responsive.isDesktop(context)
                    ? const EdgeInsets.only(left: 100, right: 100)
                    : const EdgeInsets.all(0),
                child: const ReferencePage(),
              ),
              Padding(
                padding: Responsive.isDesktop(context)
                    ? const EdgeInsets.only(left: 100, right: 100)
                    : const EdgeInsets.all(0),
                child: const ResumePage(),
              ),
              Padding(
                padding: Responsive.isDesktop(context)
                    ? const EdgeInsets.only(left: 100, right: 100)
                    : const EdgeInsets.all(0),
                child: const WorkerCongratulationPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
