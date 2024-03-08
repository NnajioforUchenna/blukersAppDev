import 'show_network_pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../utils/styles/theme_colors.dart';
import '../../create_worker_profile/create_worker_profile_components/ShowPDF.dart';

class UploadYourResume extends StatefulWidget {
  const UploadYourResume({super.key});

  @override
  State<UploadYourResume> createState() => _UploadYourResumeState();
}

class _UploadYourResumeState extends State<UploadYourResume> {
  bool isFileUploaded = false;
  PlatformFile? filePlatformFile;
  String fileNameUrl = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserProvider up = Provider.of<UserProvider>(context, listen: false);
      if (up.appUser != null &&
          up.appUser?.worker != null &&
          up.appUser?.worker?.pdfResumeUrl != null) {
        setState(() {
          fileNameUrl = up.appUser!.worker!.pdfResumeUrl;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
    return Dialog(
      backgroundColor: ThemeColors.blukersBlueThemeColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      insetPadding: EdgeInsets.only(
          left: 16, right: 16, top: height * 0.2, bottom: height * 0.2),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.05),
            width: width * 0.8,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    Map<String, dynamic> result = await up.uploadResume();
                    if (result.isNotEmpty) {
                      setState(() {
                        filePlatformFile = result['file'];
                        isFileUploaded = true;
                        fileNameUrl = '';
                      });
                    }
                  },
                  child: Container(
                    height: height * 0.2,
                    margin: const EdgeInsets.only(
                        top: 20, bottom: 20, right: 20, left: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Colors.grey[300],
                    ),
                    child: fileNameUrl.isNotEmpty
                        ? AddEditIcon(
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: ShowNetworkPDF(
                                remotePath: fileNameUrl,
                              ),
                            ),
                          )
                        : !isFileUploaded
                            ? Center(
                                child: Text(
                                  'Upload your Resume',
                                  style: GoogleFonts.montserrat(fontSize: 20),
                                ),
                              )
                            : AddEditIcon(
                                child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: ShowPDF(pdf: filePlatformFile!),
                                ),
                              ),
                  ),
                ),
                Container(
                  height: height * 0.03,
                  width: width * 0.23,
                  margin: EdgeInsets.only(top: height * 0.03, bottom: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Update',
                      style: GoogleFonts.montserrat(
                        color: ThemeColors.primaryThemeColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10, // Adjust as needed
            left: 15, // Adjust as needed
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Material(
                elevation: 4.0, // Set the elevation here
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16.0), // Half of the width/height to make it a perfect circle
                ),
                child: Container(
                  width: 32, // Adjust as needed
                  height: 32, // Adjust as needed
                  decoration: const BoxDecoration(
                    color: Colors.white, // Adjust as needed
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text("x",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: ThemeColors.primaryThemeColor,
                            fontSize: 20)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AddEditIcon({required SizedBox child}) {
    return Stack(
      children: [
        child,
        const Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: ThemeColors.secondaryThemeColor,
            child: Icon(
              UniconsLine.pen,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
