import 'package:bulkers/models/job_post.dart';
import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
          title: Text('Jobs listed under $title',
              textAlign: TextAlign.center,
              style: GoogleFonts.ebGaramond(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ))),
      body: ListView.separated(
        padding:
            const EdgeInsets.all(10), // Added to give some space around cards
        itemCount: jobPosts.length,
        itemBuilder: (context, index) {
          final jobPost = jobPosts[index];
          return Card(
            elevation: 5,
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
              title: Text('${jobPost.jobTitle} '),
              subtitle: Text(jobPost.jobDescription),
              leading: Container(
                width: 50, // Adjust size as necessary
                height: 50, // Adjust size as necessary
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(15), // Rounded rectangle
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
            height: 10,
          );
        },
      ),
    );
  }
}
