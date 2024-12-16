import 'package:flutter/material.dart';
import '../navigation/bottomNavBar.dart';
import '../navigation/pancake.dart';
import 'add_entry_page.dart';
import 'entry.dart';
import 'entry_card.dart';
import 'entry_presenter.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final EntryPresenter presenter = EntryPresenter();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addEntry() {
    Entry e = Entry(DateTime.now(), '', '', '', '', '', '', '', 0);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddEntryPage(entry: e)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Job Search Journal',
        ),
        actions: const [
          PancakeMenuButton(),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: presenter.getEntries().length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: EntryCard(entry: presenter.getEntries()[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: const Icon(Icons.add_sharp),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, -2),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const WhiteBottomBar(page: 'journalPage'),
      ),
    );
  }
}

