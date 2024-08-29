import 'package:blukers/providers/create_worker_profile_provider.dart';
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
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: PageView(
            controller: cwpp.createProfilePageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              MakeResponsiveWeb(
                  image: AssetImage('assets/images/classificationPage.png'),
                  child: ClassificationPage()),
              MakeResponsiveWeb(
                  image:
                      AssetImage('assets/images/personalInformationPage.png'),
                  child: PersonalInformationPage()),
              MakeResponsiveWeb(
                  image: AssetImage('assets/images/profilePhotoPage.png'),
                  child: ProfilePhotoPage()),
              MakeResponsiveWeb(
                  image: AssetImage(
                      'assets/images/professionalCredentialsPage.png'),
                  child: ProfessionalCredentialsPage()),
              MakeResponsiveWeb(
                  image: AssetImage('assets/images/workExperience.png'),
                  child: WorkExperiencePage()),
              MakeResponsiveWeb(
                  image: AssetImage('assets/images/referencePage.png'),
                  child: ReferencePage()),
              MakeResponsiveWeb(
                  image: AssetImage('assets/images/resumePage.png'),
                  child: ResumePage()),
              MakeResponsiveWeb(
                  image:
                      AssetImage('assets/images/workerCongratulationPage.png'),
                  child: WorkerCongratulationPage()),
            ],
          ),
        ),
      ),
    );
  }
}
