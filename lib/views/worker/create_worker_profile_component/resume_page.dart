import 'package:bulkers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../utils/styles/theme_colors.dart';
import 'your_resume.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final linkedInUrlController = TextEditingController();
    WorkerProvider wp = Provider.of<WorkerProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Upload Profile Your Resume",
              textAlign: TextAlign.center,
              style: GoogleFonts.ebGaramond(
                color: Colors.deepOrangeAccent,
                fontSize: 25,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 20),
            YourResume(),
            const SizedBox(height: 20),
            AuthInput(
              child: TextFormField(
                controller: linkedInUrlController,
                textInputAction: TextInputAction.done,
                validator: (value) => value!.isEmpty ? "Required" : null,
                decoration: InputDecoration(
                  hintText: "LinkedIn URL",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle "previous" logic here
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ThemeColors.secondaryThemeColor),
                    ),
                    child: const Text("Previous"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle "submit" or "next" logic here
                      wp.workerProfileNextPage();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ThemeColors.secondaryThemeColor),
                    ),
                    child: const Text("Next"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}

class AuthInput extends StatelessWidget {
  final Widget child;
  const AuthInput({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
