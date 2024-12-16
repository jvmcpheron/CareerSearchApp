import 'package:flutter/material.dart';
import './soft_eng_search/JobCardSE.dart';
import './soft_eng_search/JobManagerSE.dart';
import './soft_eng_search/SimpleSearchDelegate.dart'; // Import SearchDelegate
import './navigation/pancake.dart';
import './navigation/bottomNavBar.dart';

class JobPage extends StatefulWidget {
  const JobPage({Key? key}) : super(key: key);

  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  final JobManagerSE jobManager = JobManagerSE();

  // Future for fetching jobs
  late Future<void> _jobFetchFuture;

  @override
  void initState() {
    super.initState();
    // Get jobs for page
    _jobFetchFuture = jobManager.fetchJobs('', 10);
  }

  Future<void> _showAverageSalaries() async {
    try {
      final salariesByCity = await jobManager.fetchAverageSalariesByCity();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Average Salaries by City"),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                children: salariesByCity.entries.map((entry) {
                  return ListTile(
                    title: Text(entry.key),
                    subtitle: Text("Average Salary: \$${entry.value}"),
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          );
        },
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to fetch salaries: $error"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Job Listings',
          // style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SimpleSearchDelegate(jobManager),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: _showAverageSalaries,
          ),
          const PancakeMenuButton(),
        ],
        // backgroundColor: Colors.blueAccent,
        // iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<void>(
        future: _jobFetchFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading jobs: ${snapshot.error}',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          }

          if (jobManager.searchResults.isEmpty) {
            return const Center(
              child: Text(
                'No jobs available.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: jobManager.searchResults.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: JobCard(job: jobManager.searchResults[index]),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -2),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const WhiteBottomBar(page: 'jobSearchSE'),
      ),
    );
  }
}
