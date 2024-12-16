import 'dart:io';
import 'dart:convert';

class CSVReader {
  final String filePath;

  CSVReader(this.filePath);

  Future<void> compareSalariesByCity() async {
    // Step 1: Read the CSV file
    final file = File(filePath);
    if (!file.existsSync()) {
      print('Error: File not found at $filePath');
      return;
    }

    final lines = await file.readAsLines();
    if (lines.isEmpty) {
      print('Error: CSV file is empty.');
      return;
    }

    // Step 2: Parse the CSV file
    final header = lines.first.split(',');
    final jobTitleIndex = header.indexOf('job_title');
    final salaryIndex = header.indexOf('salary_in_usd');
    final cityIndex = header.indexOf('company_location');

    if (jobTitleIndex == -1 || salaryIndex == -1 || cityIndex == -1) {
      print('Error: Required columns not found in the CSV file.');
      return;
    }

    // Step 3: Filter and process the data
    final citySalaryMap = <String, List<double>>{};
    for (var line in lines.skip(1)) {
      final columns = line.split(',');

      if (columns.length <= salaryIndex) continue;

      final jobTitle = columns[jobTitleIndex].trim();
      final salary = double.tryParse(columns[salaryIndex].trim()) ?? 0;
      final city = columns[cityIndex].trim();

      if (jobTitle.toLowerCase().contains('software engineer')) {
        citySalaryMap.putIfAbsent(city, () => []).add(salary);
      }
    }

    // Step 4: Calculate average salary by city
    final cityAvgSalaries = citySalaryMap.map((city, salaries) {
      final avgSalary = salaries.reduce((a, b) => a + b) / salaries.length;
      return MapEntry(city, avgSalary);
    });

    // Step 5: Find the city with the best salary
    final bestCity = cityAvgSalaries.entries.reduce((a, b) => a.value > b.value ? a : b);

    // Step 6: Display results
    print('Average Software Engineer Salaries by City:');
    cityAvgSalaries.forEach((city, avgSalary) {
      print('- $city: \$${avgSalary.toStringAsFixed(2)}');
    });

    print('\nBest city for Software Engineers: ${bestCity.key} (\$${bestCity.value.toStringAsFixed(2)})');
  }
}

void main() async {
  final csvReader = CSVReader('lib/CSVs/jobs_in_data_cleaned.csv');
  await csvReader.compareSalariesByCity();
}
