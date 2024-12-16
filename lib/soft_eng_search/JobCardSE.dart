import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import './JobSE.dart';
import './JobManagerSE.dart';


class JobCard extends StatelessWidget {
  final JobSE job;

  const JobCard({
    Key? key,
    required this.job,
  }) : super(key: key);

  void _navigateToJobDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JobDetailsPage(job: job),
      ),
    );
  }

  void _shareJob() {
    Share.share(
      'Check out this job opportunity:\n\n'
          '${job.jobTitle}\n'
          '${job.companyName}\n'
          '${job.location}\n'
          'Salary: \$${job.salary.toStringAsFixed(0)}/year',
      subject: 'Job Opportunity: ${job.jobTitle}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToJobDetails(context),
      child: Container(
        height: 180, // Fixed height for each job card
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        job.jobTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.blueAccent),
                      onPressed: _shareJob,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  job.companyName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  job.location,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${job.salary.toStringAsFixed(0)}/year',
                  style: TextStyle(
                    fontSize: 16,
                    color: job.salary <95000 ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class JobDetailsPage extends StatelessWidget {
  final JobSE job;

  const JobDetailsPage({
    Key? key,
    required this.job,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final JobManagerSE jobManager = JobManagerSE();

    final suggestedJobs = jobManager.searchResults
        .where((suggestedJob) => suggestedJob.location != job.location)
        .take(3) //i want to limit to three suggestions for now
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Job Details',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job Details Section
              Text(
                job.jobTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Location: ${job.location}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Text(
                'Company: ${job.companyName}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                'Company Score: ${job.companyScore.toStringAsFixed(1)}/5',
                style: TextStyle(
                  fontSize: 16,
                  color: job.companyScore < 3.0 ? Colors.red : Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Salary: \$${job.salary.toStringAsFixed(0)}/year',
                style: TextStyle(
                  fontSize: 16,
                  color: job.salary <95000 ? Colors.red : Colors.green,
                ),
              ),
              const SizedBox(height: 32),

              // Suggested Jobs Section
              if (suggestedJobs.isNotEmpty) ...[
                const Text(
                  'Recommended Jobs:',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: suggestedJobs
                      .map((suggestedJob) => JobCard(job: suggestedJob))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}