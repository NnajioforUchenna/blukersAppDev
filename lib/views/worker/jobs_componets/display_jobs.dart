import 'package:bulkers/models/job_post.dart';
import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:bulkers/utils/styles/index.dart';

import 'display_job_post_dialog.dart';

class DisplayJobs extends StatelessWidget {
  final String title;
  const DisplayJobs({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    final List<JobPost> jobPosts = jp.selectedJobPosts;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: ThemeColors.primaryThemeColor,
          ),
          elevation: 0,
          title: Text('$title (Jobs)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeColors.primaryThemeColor,
              ),
            )),
      body: ListView.separated(
        padding:
            const EdgeInsets.all(10), // Added to give some space around cards
        itemCount: jobPosts.length,
        itemBuilder: (context, index) {
          final jobPost = jobPosts[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: ThemeColors.primaryThemeColor, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 0), // Adjust for spacing
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15), // Add padding for larger appearance
              onTap: () {
                print('Display details for ${jobPost.jobTitle}');
                showDialog(
                    context: context,
                    builder: (context) => DisplayJobPostDialog(
                          jobPost: jobPost,
                        ));
              },
              title: Text(
                '${jobPost.jobTitle} ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.primaryThemeColor,
                ),
              ),
              subtitle: Text(jobPost.jobDescription),
              leading: Container(
                width: 50, // Adjust size as necessary
                height: 50, // Adjust size as necessary
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(100), // Rounded rectangle
                    image: const DecorationImage(
                      image: NetworkImage("https://picsum.photos/200/300"),
                      fit: BoxFit.cover,
                    )),
              ),
              trailing: Text(jobPost.jobType.toString()),
              // Add more details for each worker, if needed
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 5,
          );
        },
      ),
    );
  }
}
