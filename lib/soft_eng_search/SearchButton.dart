import 'package:flutter/material.dart';
import './JobManagerSE.dart';
import './SimpleSearchDelegate.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jobManager = JobManagerSE(); // Singleton instance
    return IconButton(
      icon: const Icon(Icons.search, color: Colors.white),
      onPressed: () {
        showSearch(
          context: context,
          delegate: SimpleSearchDelegate(jobManager), // Pass the manager
        );
      },
    );
  }
}
