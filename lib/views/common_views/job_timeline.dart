import 'package:flutter/material.dart';

class JobTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Timeline'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTimelineStep(
              '1. Register',
              'Start your journey with us by creating an account. Registration is quick and easy. With just a few clicks, you\'ll gain access to countless job opportunities tailored to your interests and skills. Join us now and open the door to your next career adventure.',
            ),
            _buildTimelineStep(
              '2. Create Your Profile',
              'Your profile is your professional showcase. Fill in your educational background, work experience, skills, and more. The more complete your profile, the easier it will be for employers to understand your expertise and reach out with relevant job offers. A well-crafted profile can make you stand out in the competitive job market.',
            ),
            _buildTimelineStep(
              '3. Apply for Jobs or Save to Apply Later',
              'Browse through our extensive list of job postings. Find the ones that resonate with your career goals and apply directly through our platform. Not ready to apply just yet? No problem! You can save any job posting and return to it later when you\'re ready. Your dream job is just a click away.',
            ),
            _buildTimelineStep(
              '4. Companies Interested in Your Skill Set Will Reach Out to You',
              'Your skills and experience are valuable, and companies are looking for talents like you. By having a complete and detailed profile, you may catch the eye of recruiters actively seeking your expertise. When a match is found, companies will reach out to you directly through our platform. Stay active, keep your profile up-to-date, and let the opportunities come to you.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Center(
              child: Icon(Icons.check, size: 12, color: Colors.white),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
