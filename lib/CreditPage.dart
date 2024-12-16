import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Required for launching URLs
import './navigation/pancake.dart';
import './navigation/bottomNavBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acknowledgements',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyCreditPage(),
    );
  }
}

class MyCreditPage extends StatelessWidget {
  const MyCreditPage({super.key});

  // Helper method to open URLs
  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Acknowledgements',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          PancakeMenuButton(),
        ],
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 16),
            const Text(
              'We used the following datasets:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _launchURL(
                  'https://www.kaggle.com/datasets/emreksz/software-engineer-jobs-and-salaries-2024'),
              child: Card(
                elevation: 2,
                color: Colors.deepPurple.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.dataset, color: Colors.deepPurple.shade300),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Software Engineer Jobs & Salaries 2024 by Emre Öksüz',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _launchURL(
                  'https://www.kaggle.com/datasets/hummaamqaasim/jobs-in-data'),
              child: Card(
                elevation: 2,
                color: Colors.deepPurple.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.dataset, color: Colors.deepPurple.shade300),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Jobs and Salaries in Data Science by Hummaam Qaasim',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Code Contributors:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Jane McPheron, Milly Maleck, Jacob Halvorson, Lucanzo Giancola, '
                  'Isaac Lonnes, Jackson Dugan',
              style: TextStyle(fontSize: 14),
            ),
            const Spacer(), // Pushes University of Minnesota Duluth to the bottom
            const Center(
              child: Text(
                'University of Minnesota Duluth 2024',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, -2),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const WhiteBottomBar(page: 'ack'),
      ),
    );
  }
}

