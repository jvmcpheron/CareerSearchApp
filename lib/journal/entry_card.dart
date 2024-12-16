import 'package:final_project/journal/add_entry_page.dart';
import 'package:final_project/journal/entry_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'entry.dart';
import 'journal_page.dart';

class EntryCard extends StatefulWidget {
  final Entry entry;

  const EntryCard({super.key, required this.entry});

  @override
  State<StatefulWidget> createState() => _EntryCardState();

  Entry get getEntry => entry;
}


class _EntryCardState extends State<EntryCard> {
  final EntryPresenter presenter = EntryPresenter();
  final SizedBox verticalSpacer = const SizedBox(height: 8);
  final TextStyle infoTextStyle = const TextStyle(
      fontSize: 16);
  final TextStyle titleTextStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold);
  final EdgeInsets textFieldEdgeInsets = const EdgeInsets.fromLTRB(
      16, 20, 16, 12);
  final TextStyle textFieldHintTextStyle = const TextStyle(color: Colors.grey);


  late final TextEditingController _jobTitleController;
  late final TextEditingController _listingInfoController;
  late final TextEditingController _positivesController;
  late final TextEditingController _firstImpressionController;
  late final TextEditingController _challengesController;
  late final TextEditingController _improvementsController;
  late final TextEditingController _notesController;


  @override
  initState() {
    super.initState();
    _jobTitleController = TextEditingController();
    _listingInfoController = TextEditingController();
    _positivesController = TextEditingController();
    _firstImpressionController = TextEditingController();
    _challengesController = TextEditingController();
    _improvementsController = TextEditingController();
    _notesController = TextEditingController();
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

  void _editEntry() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddEntryPage(
              entry: widget.entry,
            ),
      ),
    );
  }

  Future<void> _deleteEntryAlert() {
    RoundedRectangleBorder alertDialogShape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)));
    ButtonStyle buttonStyle = TextButton.styleFrom(
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)))
    );

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: alertDialogShape,
              title: const Text('Delete entry?',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: buttonStyle,
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        const SizedBox(width: 5),
                        TextButton(
                          style: buttonStyle,
                          child: const Text('Delete'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {});
                            _deleteEntry();
                          },
                        ),
                      ],
                    )
                  ]
              )
          );
        }
    );
  }

  void _deleteEntry() {
    presenter.removeEntry(widget.entry);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const JournalPage()),
          (Route<dynamic> route) => false,);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_sharp),
                    onPressed: _editEntry,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_sharp),
                    onPressed: _deleteEntryAlert,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Interview Rating: ',
                    style: titleTextStyle,
                  ),
                  RatingBar(
                    initialRating: widget.entry.getRating,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 20,
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star_sharp),
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
                ],
              ),
              verticalSpacer,
              Row(
                children: [
                  Text(
                    'Job Title: ',
                    style: titleTextStyle,
                  ),
                  Text(
                    widget.entry.getJobTitle,
                    style: infoTextStyle,
                  ),
                ],
              ),
              verticalSpacer,
              Text(
                'Job Listing Information: ',
                style: titleTextStyle,
              ),
              Text(
                widget.entry.getListingInfo,
                style: infoTextStyle,
              ),
              verticalSpacer,
              Text(
                'First Impression:',
                style: titleTextStyle,
              ),
              Text(
                widget.entry.getFirstImpression,
                style: infoTextStyle,
              ),
              verticalSpacer,
              Text(
                'Positives:',
                style: titleTextStyle,
              ),
              Text(
                widget.entry.getPositives,
                style: infoTextStyle,
              ),
              verticalSpacer,
              Text(
                'Challenges:',
                style: titleTextStyle,
              ),
              Text(
                widget.entry.getChallenges,
                style: infoTextStyle,
              ),
              verticalSpacer,
              Text(
                'Improvements:',
                style: titleTextStyle,
              ),
              Text(
                widget.entry.getImprovements,
                style: infoTextStyle,
              ),
              verticalSpacer,
              Text(
                'Notes:',
                style: titleTextStyle,
              ),
              Text(
                widget.entry.getNotes,
                style: infoTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

}