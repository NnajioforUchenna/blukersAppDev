import 'package:blukers/views/worker/faq/components/success_path.dart';
import 'package:flutter/material.dart';

class FrequentlyAskQuestions extends StatefulWidget {
  const FrequentlyAskQuestions({super.key});

  @override
  State<FrequentlyAskQuestions> createState() => _FrequentlyAskQuestionsState();
}

class _FrequentlyAskQuestionsState extends State<FrequentlyAskQuestions> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            elevation: 3,
            child: ExpansionTile(title: const Text('Path to a successful job'),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: const FAQJobTimeline()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
