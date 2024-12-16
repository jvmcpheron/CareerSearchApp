import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:final_project/data_science_search/job_presenter_ds.dart';
import 'package:final_project/navigation/pancake.dart';

import '../navigation/bottomNavBar.dart';

class DistributionChartPage extends StatefulWidget {
  const DistributionChartPage({Key? key}) : super(key: key);

  @override
  _DistributionChartPageState createState() => _DistributionChartPageState();
}

class _DistributionChartPageState extends State<DistributionChartPage> {
  final JobPresenterDS jobPresenter = JobPresenterDS();
  Map<String, List<int>> salaryGroups = {};
  List<String> companySizes = [];
  bool loading = true;

  Future<void> fetchAndGroupData() async {
    try {
      jobPresenter.fetchJobs("", 7000); // Fetch all jobs
      final jobs = jobPresenter.getSearchResults();

      // Debug: Log the job count
     // print("Number of jobs fetched: ${jobs.length}");

      for (var job in jobs) {
        final companySize = job.getCompanySize.trim(); // Trim whitespace or newlines
        final salary = job.getSalaryInUSDollar;

        // If the company size is one of the first three unique ones, process it
        if (companySizes.length < 3 && !companySizes.contains(companySize)) {
          companySizes.add(companySize);
        }

        // If this company size is in our first three, add the salary to the group
        if (companySizes.contains(companySize)) {
          salaryGroups.putIfAbsent(companySize, () => []).add(salary);
        }
      }

      //print("Grouped salaries: $salaryGroups");
    } catch (e) {
      print("Error grouping data: $e");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAndGroupData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Size Salary Distribution',
            style: TextStyle(fontSize: 20)),
        // backgroundColor: Colors.blueAccent,
        actions: const [PancakeMenuButton()],
        // iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: salaryGroups.entries.map((entry) {
              final companySize = entry.key;
              final salaries = entry.value;
              return buildLineChart("Company Size: $companySize", salaries);
            }).toList(),
          ),
        ),
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
        child: const WhiteBottomBar(page: 'salaryGraphs'),
      ),
    );
  }

  Widget buildLineChart(String title, List<int> salaries) {
    final points = getNormalDistributionPoints(salaries);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(border: Border.all(color: Colors.black, width: 1)),
              lineBarsData: [
                LineChartBarData(
                  spots: points,
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 3,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  List<FlSpot> getNormalDistributionPoints(List<int> salaries) {
    if (salaries.isEmpty) return [];

    final mean = salaries.reduce((a, b) => a + b) / salaries.length;
    final stddev = sqrt(salaries.map((s) => pow(s - mean, 2)).reduce((a, b) => a + b) / salaries.length);

    const int numPoints = 100;
    final minSalary = salaries.reduce(min).toDouble();
    final maxSalary = salaries.reduce(max).toDouble();
    final step = (maxSalary - minSalary) / (numPoints - 1);

    return List.generate(numPoints, (i) {
      final x = minSalary + i * step;
      final y = (1 / (stddev * sqrt(2 * pi))) * exp(-0.5 * pow((x - mean) / stddev, 2));
      return FlSpot(x, y);
    });
  }
}
