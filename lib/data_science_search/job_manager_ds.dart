import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/data_science_search/csv_reader_ds.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'job_ds.dart';
import 'package:csv/csv.dart';

class JobManagerDS {

  static final JobManagerDS _instance = JobManagerDS._internal();
  factory JobManagerDS() => _instance;
  JobManagerDS._internal();

  final List<JobDS> jobs = []; // all jobs from csv

  final List<JobDS> _allResults = []; // jobs that match search string
  final List<JobDS> _inPersonJobs = []; // in-person and match search
  final List<JobDS> _hybridJobs = []; // hybrid and match search
  final List<JobDS> _remoteJobs = []; // remote and match search

  List<JobDS> get getAllResults => List.unmodifiable(_allResults);
  List<JobDS> get getInPersonJobs => List.unmodifiable(_inPersonJobs);
  List<JobDS> get getHybridJobs => List.unmodifiable(_hybridJobs);
  List<JobDS> get getRemoteJobs => List.unmodifiable(_remoteJobs);


  Future<void> convertJobsData() async {
    const String filePath = 'assets/jobs_in_data_cleaned.csv';

    CSVReaderDS reader = CSVReaderDS(filePath);
    final List<List<dynamic>> jobsData = await reader.fetchData();

    jobs.addAll(jobsData.skip(1).map((line) {
      return JobDS(
        '',
        line[0],
        line[1],
        line[2],
        line[3],
        line[4],
        line[5],
        line[6],
        line[7],
        line[8],
        line[9],
        line[10],
        line[11],
      );
    }).toList());

  }


  void fetchJobs(String query, int numResults) {

    if (jobs.isEmpty) {
      convertJobsData();
    }

    // FILTERING
    final filteredJobs = jobs
        .where((job) => job.jobCategory.toLowerCase().contains(query.toLowerCase()))

    // //limit to number of desired results
        .take(numResults)

    // //add to list
        .toList();

    // UPDATING LIST
    _allResults
      ..clear()
      ..addAll(filteredJobs);

    // Update separated lists for each work setting
    fetchInPersonJobs(query, numResults);
    fetchHybridJobs(query, numResults);
    fetchRemoteJobs(query, numResults);
  }

  void fetchInPersonJobs(String query, int numResults) {
    final inPersonJobs = _allResults.where((job) =>
        job.workSetting.contains('In-person')).toList();

    _inPersonJobs
    ..clear()
    ..addAll(inPersonJobs);
  }

  void fetchHybridJobs(String query, int numResults) {
    final hybridJobs = _allResults.where((job) =>
        job.workSetting.contains('Hybrid')).toList();

    _hybridJobs
      ..clear()
      ..addAll(hybridJobs);
  }

  void fetchRemoteJobs(String query, int numResults) {
    final remoteJobs = _allResults.where((job) =>
        job.workSetting.contains('Remote')).toList();

    _remoteJobs
      ..clear()
      ..addAll(remoteJobs);
  }

  Future<Map<String, String>> fetchAverageSalariesByJobPosition() async {
    const String csvAssetPath = 'assets/jobs_in_data_cleaned.csv'; // Path in pubspec.yaml

    try {
      // Load the CSV file as a string from assets
      final csvString = await rootBundle.loadString(csvAssetPath);

      // Parse the CSV string into rows
      final List<List<dynamic>> rows = const CsvToListConverter(eol: "\n").convert(csvString);

      // Create a map to store total salaries and job counts per job position
      Map<String, List<int>>? jobPositionSalaryData = {};

      // Skip the header row and process each job entry
      for (var i = 1; i < rows.length; i++) {
        final row = rows[i];
        final String position = row[1].toString(); // Job Position
        final int salary = row[5]; // Salary in USD

        if (!jobPositionSalaryData.containsKey(position)) {
          jobPositionSalaryData[position] = [];
        }
        jobPositionSalaryData[position]!.add(salary);
      }

      //Sort the map alphabetically
      var sortedKeys = jobPositionSalaryData.keys.toList()..sort();
      var sortedMap = {
        for (var key in sortedKeys) key: jobPositionSalaryData[key],
      };
      jobPositionSalaryData = sortedMap.cast<String, List<int>>();

      // Initialize a NumberFormat for formatting salaries with commas
      final numberFormat = NumberFormat("#,##0");

      // Calculate average salary for each city and format it
      final Map<String, String> averageSalariesByJobPosition = {};
      jobPositionSalaryData.forEach((position, salaries) {
        final double average = salaries.isEmpty ? 0 : salaries.reduce((a, b) => a + b) / salaries.length;
        averageSalariesByJobPosition[position] = numberFormat.format(average);
      });

      return averageSalariesByJobPosition;
    } catch (e) {
      print("Error calculating average salaries: $e");
      return {};
    }
  }

  Future<Map<String, String>> fetchJobsByPosition(String jobPosition) async {
    const String csvAssetPath = 'assets/jobs_in_data_cleaned.csv'; // Path in pubspec.yaml
    // Load the CSV file as a string from assets
    final csvString = await rootBundle.loadString(csvAssetPath);

    // Parse the CSV string into rows
    final List<List<dynamic>> rows = const CsvToListConverter(eol: "\n").convert(csvString);

    // Create a map to store total salaries and job counts per company location
    Map<String, List<int>?> countrySalaryData = {};

    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row[1].toString() == jobPosition) {
        final String country = row[10].toString(); // Company Location
        final int salary = row[5];  // Salary
        if (!countrySalaryData.containsKey(country)) {
          countrySalaryData[country] = [];
        }
        countrySalaryData[country]!.add(salary);
      }
    }

    //Sort the map alphabetically
    var sortedKeys = countrySalaryData.keys.toList()..sort();
    var sortedMap = {
      for (var key in sortedKeys) key: countrySalaryData[key],
    };
    countrySalaryData = sortedMap.cast<String, List<int>>();

    // Initialize a NumberFormat for formatting salaries with commas
    final numberFormat = NumberFormat("#,##0");

    // Calculate average salary for each city and format it
    final Map<String, String> averageSalariesByJobPosition = {};
    countrySalaryData.forEach((country, salaries) {
      final double average = salaries!.isEmpty ? 0 : salaries.reduce((a, b) => a + b) / salaries.length;
      averageSalariesByJobPosition[country] = numberFormat.format(average);
    });

    return averageSalariesByJobPosition;
  }
}
