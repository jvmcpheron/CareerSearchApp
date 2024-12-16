import 'dart:io';

import 'package:csv/csv.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';

class CSVReaderDS {
  final String filePath;

  CSVReaderDS(this.filePath);


  Future<List<List>> fetchData() async {
    final List<List<dynamic>> lines = [];
    try {
      // final String directory = (await getApplicationSupportDirectory()).path;
      // final path = "$directory/$filePath";

      // get string of csv data from file
      final jobsData = await rootBundle.loadString(filePath);
      // convert string to list of lines
      lines.addAll(const CsvToListConverter(eol: '\n').convert(jobsData));
    } catch (e) {
      print("Error reading CSV: $e");
    }
    return lines;
  }

  Future<void> writeData(List<List<dynamic>> data) async {

    String csv = const ListToCsvConverter().convert(data);

    try {
      // final String directory = (await getApplicationSupportDirectory()).path;
      // final path = "$directory/$filePath";


      final file = File(filePath);
      await file.writeAsString(csv);
    } catch (e) {
      print("Error writing to CSV: $e");
    }
  }
}
