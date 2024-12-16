import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'entry.dart';
import 'entry_presenter.dart';
import 'journal_page.dart';

class AddEntryPage extends StatefulWidget {
  final Entry entry;

  const AddEntryPage({super.key, required this.entry});

  @override
  State<StatefulWidget> createState() => _AddEntryPageState();

  Entry get getEntry => entry;
}


class _AddEntryPageState extends State<AddEntryPage> {
  final EntryPresenter presenter = EntryPresenter();
  final SizedBox verticalSpacer = const SizedBox(height: 8);
  final TextStyle cardTextStyle = const TextStyle(
      // color: Colors.black54,
      fontSize: 16);
  final EdgeInsets textFieldEdgeInsets = const EdgeInsets.fromLTRB(16,20,16,12);
  // final TextStyle textFieldHintTextStyle = const TextStyle(color: Colors.grey);




  final _jobTitleController = TextEditingController();
  final _listingInfoController = TextEditingController();
  final _positivesController = TextEditingController();
  final _firstImpressionController = TextEditingController();
  final _challengesController = TextEditingController();
  final _improvementsController = TextEditingController();
  final _notesController = TextEditingController();



  @override
  initState() {
    super.initState();
    _jobTitleController.text = widget.entry.getJobTitle;
    _listingInfoController.text = widget.entry.getListingInfo;
    _positivesController.text = widget.entry.getPositives;
    _firstImpressionController.text = widget.entry.getFirstImpression;
    _challengesController.text = widget.entry.getChallenges;
    _improvementsController.text = widget.entry.getImprovements;
    _notesController.text = widget.entry.getNotes;
  }

  @override
  void dispose() {
    super.dispose();
    _jobTitleController.dispose();
    _listingInfoController.dispose();
    _positivesController.dispose();
    _firstImpressionController.dispose();
    _challengesController.dispose();
    _improvementsController.dispose();
    _notesController.dispose();

  }

  void _done() {
    widget.entry.jobTitle = _jobTitleController.text;
    widget.entry.listingInfo = _listingInfoController.text;
    widget.entry.firstImpression = _firstImpressionController.text;
    widget.entry.positives = _positivesController.text;
    widget.entry.challenges = _challengesController.text;
    widget.entry.improvements = _improvementsController.text;
    widget.entry.notes = _notesController.text;

    presenter.addEntry(widget.entry);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) =>  const JournalPage()),
          (Route<dynamic> route) => false,);
  }

  void _back() {
      Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
          // backgroundColor: Colors.white,
          leading: BackButton(onPressed: _back),
          title: const Row(
              children: [Text('Journal Entry'),
                SizedBox(width: 8,)
              ]
          ),
          actions: [
            IconButton(onPressed: _done, icon: const Icon(Icons.done)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${widget.entry.getDate.month}/'
                          '${widget.entry.getDate.day}/'
                          '${widget.entry.getDate.year}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpacer,
              Text(
                'Interview Rating: ',
                style: cardTextStyle,
              ),
              verticalSpacer,
              RatingBar(
                initialRating: widget.entry.getRating,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 40,
                ratingWidget: RatingWidget(
                  full:  const Icon(Icons.star_sharp),
                  half: const Icon(Icons.star_sharp),
                  empty: const Icon(Icons.star_border_sharp),
                ),
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  setState(() {
                    widget.entry.rating = rating;
                  });
                },
              ),
              verticalSpacer,
              Text(
                'Job Title',
                style: cardTextStyle,
              ),
              verticalSpacer,
              TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _jobTitleController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                      contentPadding: textFieldEdgeInsets,)
              ),
              verticalSpacer,
              Text(
                'Job Listing Information',
                style: cardTextStyle,
              ),
              verticalSpacer,
              TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _listingInfoController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: textFieldEdgeInsets,)
              ),
              verticalSpacer,
              Text(
                'What is your first impression of the company?',
                style: cardTextStyle,
              ),
              verticalSpacer,
              TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _firstImpressionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: textFieldEdgeInsets,)
              ),
              verticalSpacer,
              Text(
                'What do you like about the job?',
                style: cardTextStyle,
              ),
              verticalSpacer,
              TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _positivesController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: textFieldEdgeInsets,)
              ),
              verticalSpacer,
              Text(
                'What about the job may not be good for you?',
                style: cardTextStyle,
              ),
              verticalSpacer,
              TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _challengesController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: textFieldEdgeInsets,)
              ),
              verticalSpacer,
              Text(
                'What would you like to improve on before your interview?',
                style: cardTextStyle,
              ),
              verticalSpacer,
              TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _improvementsController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: textFieldEdgeInsets,)
              ),
              verticalSpacer,
              Text(
                'Notes',
                style: cardTextStyle,
              ),
              verticalSpacer,
              TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _notesController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: textFieldEdgeInsets,)
              ),
            ],
          ),
        ),
    );
  }

}