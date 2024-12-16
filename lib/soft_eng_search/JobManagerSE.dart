import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'JobSE.dart';

class JobManagerSE {
  // Singleton instance
  static final JobManagerSE _instance = JobManagerSE._internal();

  // Factory constructor
  factory JobManagerSE() => _instance;

  // Private internal constructor
  JobManagerSE._internal();

  // Private list to store search results
  final List<JobSE> _searchResults = [];

  // Getter for search results
  List<JobSE> get searchResults => List.unmodifiable(_searchResults);

  // Fetch jobs from CSV file
  Future<void> fetchJobs(String query, int numResults) async {
    const String csvAssetPath = 'assets/SoftwareEngineerSalariesCleaned.csv'; // Path in pubspec.yaml

    try {
      // Load the CSV file as a string from assets
      final csvString = await rootBundle.loadString(csvAssetPath);

      // Parse the CSV string into rows
      final List<List<dynamic>> rows = const CsvToListConverter(eol: "\n").convert(csvString);

      // Skip the header row and map rows to JobSE objects
      final List<JobSE> jobs = rows.skip(1).map((row) {
        return JobSE(
          '', // ID not present in your CSV
          row[2].toString(), // Job Title
          row[3].toString(), // Location
          _parseSalary(row[5].toString()), // Salary
          row[0].toString(), // Company
          double.parse(row[1].toString()), // Company Score
        );
      }).toList();

      // Filter and limit the results
      final filteredJobs = jobs
          .where((job) => job.jobTitle.toLowerCase().contains(query.toLowerCase()))
          .take(numResults)
          .toList();

      // Update search results
      _searchResults
        ..clear()
        ..addAll(filteredJobs);
    } catch (e) {
      print("Error reading CSV: $e");
      _searchResults.clear(); // Clear results on error
    }
  }

  // Parse salary from a salary range string
  int _parseSalary(String salaryRange) {
    try {
      // Check if the salary is hourly (contains keywords like "hour" or "per hour")
      if (salaryRange.toLowerCase().contains('hour') || salaryRange.toLowerCase().contains('per hour')) {
        // Extract the salary range (remove non-numeric characters except for the hyphen between the range)
        final cleanedSalaryRange = salaryRange.replaceAll(RegExp(r'[^0-9.-]'), '');

        // Split the range if there's a hyphen and get the average of the range
        final salaryParts = cleanedSalaryRange.split('-');
        if (salaryParts.length == 2) {
          final minHourlyRate = double.tryParse(salaryParts[0]) ?? 0.0;
          final maxHourlyRate = double.tryParse(salaryParts[1]) ?? 0.0;

          // Calculate the average hourly rate
          final averageHourlyRate = (minHourlyRate + maxHourlyRate) / 2;

          // Convert the average hourly rate to an annual salary (assuming 40 hours/week and 52 weeks/year)
          int annualSalary = (averageHourlyRate * 40 * 52).toInt();
          return annualSalary;
        }
      }

      // Handle salary ranges with 'K' for thousands (e.g., "$68K - $94K")
      if (salaryRange.toUpperCase().contains('K')) {
        final cleanedSalaryRange = salaryRange.replaceAll(RegExp(r'[^0-9K.-]'), '').toUpperCase();

        // Split the salary range into two parts (e.g., "$68K - $94K" becomes ["68K", "94K"])
        final salaryParts = cleanedSalaryRange.split('-');
        if (salaryParts.length == 2) {
          // Parse the salary range, removing the "K" and converting to an integer in thousands
          final minSalary = double.tryParse(salaryParts[0].replaceAll('K', '').trim()) ?? 0.0;
          final maxSalary = double.tryParse(salaryParts[1].replaceAll('K', '').trim()) ?? 0.0;

          // Convert the salary values to actual numbers (thousands * 1000)
          final minSalaryInThousands = (minSalary * 1000).toInt();
          final maxSalaryInThousands = (maxSalary * 1000).toInt();

          // Calculate the average salary
          final averageSalary = ((minSalaryInThousands + maxSalaryInThousands) / 2).toInt();
          return averageSalary;
        }
      }

      // If the salary is not hourly, clean it up and parse it as an annual salary
      final cleanedSalary = salaryRange.replaceAll(RegExp(r'[^\d]'), '');

      // If the cleaned salary is empty or cannot be parsed, return 0
      if (cleanedSalary.isEmpty) {
        return 0;
      }

      // Convert the cleaned salary to an integer
      int salary = int.parse(cleanedSalary);

      // Return the salary value (annual salary in this case)
      return salary;
    } catch (e) {
      print("Error parsing salary: $e");
    }

    return 0; // Default to 0 if parsing fails
  }




  // Fetch average salaries by city
  Future<Map<String, String>> fetchAverageSalariesByCity() async {
    const String csvAssetPath = 'assets/SoftwareEngineerSalariesCleaned.csv'; // Path in pubspec.yaml

    try {
      // Load the CSV file as a string from assets
      final csvString = await rootBundle.loadString(csvAssetPath);

      // Parse the CSV string into rows
      final List<List<dynamic>> rows = const CsvToListConverter(eol: "\n").convert(csvString);

      // Create a map to store total salaries and job counts per city
      final Map<String, List<int>> citySalaryData = {};

      // Skip the header row and process each job entry
      for (var i = 1; i < rows.length; i++) {
        final row = rows[i];
        final String city = row[3].toString(); // Location (city)
        final int salary = _parseSalary(row[5].toString()); // Salary

        if (!citySalaryData.containsKey(city)) {
          citySalaryData[city] = [];
        }
        citySalaryData[city]!.add(salary);
      }

      // Initialize a NumberFormat for formatting salaries with commas
      final numberFormat = NumberFormat("#,##0");

      // Calculate average salary for each city and format it
      final Map<String, String> averageSalariesByCity = {};
      citySalaryData.forEach((city, salaries) {
        final double average = salaries.isEmpty ? 0 : salaries.reduce((a, b) => a + b) / salaries.length;
        averageSalariesByCity[city] = numberFormat.format(average);
      });

      return averageSalariesByCity;
    } catch (e) {
      print("Error calculating average salaries: $e");
      return {};
    }
  }
}
