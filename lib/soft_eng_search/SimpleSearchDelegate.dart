import 'package:flutter/material.dart';
import './JobCardSE.dart';
import './JobManagerSE.dart';

class SimpleSearchDelegate extends SearchDelegate {
  final JobManagerSE jobManager;

  SimpleSearchDelegate(this.jobManager);

  @override
  String get searchFieldLabel => 'Search jobs';

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Close search
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: jobManager.fetchJobs(query, 10),
      builder: (context, snapshot) {
        // While the fetch is in progress, show a loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Check if there was an error
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error fetching jobs: ${snapshot.error}',
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }

        // Ensure search results are loaded
        if (jobManager.searchResults.isEmpty) {
          return Center(
            child: Text(
              'No jobs found for "$query".',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        // Display the search results
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
    );
  }


  //suggestions!!!
  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestions = jobManager.searchResults
        .where((job) =>
        job.jobTitle.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(

      padding: const EdgeInsets.all(16.0),
      itemCount: suggestions.length,

      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].jobTitle),
          subtitle: Text(suggestions[index].companyName),
          onTap: () {
            query = suggestions[index].jobTitle;
            showResults(context);
          },
        );
      },
    );
  }
}
