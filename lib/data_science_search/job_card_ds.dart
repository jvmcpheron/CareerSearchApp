import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import './job_ds.dart';

class JobCardDS extends StatelessWidget {
  final JobDS job;

  const JobCardDS({
    super.key,
    required this.job,

  });

  final Color popupColor = Colors.white;
  final TextStyle detailsTextStyle = const TextStyle(
      fontSize: 14);
  final TextStyle cardTextStyle = const TextStyle(
      fontSize: 16);
  final SizedBox spacer = const SizedBox(width: 5, height: 15);


  void _shareJob() {
    Share.share(
      'Check out this job opportunity:\n\n'
          '${job.jobTitle}\n'
          '${job.companyLocation}\n'
          '${job.employmentType}\n'
          'Salary: \$${job.salaryInUSDollar.toStringAsFixed(0)}/year',
      subject: 'Job Opportunity: ${job.jobTitle}',
    );
  }

  Future<void> _jobDetailsDialogBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 15),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              // surfaceTintColor: Colors.white,
              // backgroundColor: popupColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          spacer,
                          ListTile(
                            title: Text(job.jobTitle,
                              style: const TextStyle(
                                  // color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                              overflow: TextOverflow.fade,),
                            trailing: const CloseButton(),
                          ),
                          const SizedBox(height: 16),

                          Text(
                            job.companyLocation,
                            style: detailsTextStyle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            job.employmentType,
                            style: detailsTextStyle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            job.workSetting,
                            style: detailsTextStyle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Salary: \$${job.salary.toStringAsFixed(0)}',
                            style: detailsTextStyle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Job Category: ${job.jobCategory}',
                            style: detailsTextStyle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Employee Residence: ${job.employeeResidence}',
                            style: detailsTextStyle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Experience Level: ${job.experienceLevel}',
                            style: detailsTextStyle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Company Size: ${job.companySize}',
                            style: detailsTextStyle,
                          ),
                          const SizedBox(height: 8),
                        ],
                      )
                  ),
                ],
              )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    const SizedBox verticalSpacer = SizedBox(height: 8);

    return GestureDetector(
      onTap: () => _jobDetailsDialogBuilder(context),
      child: SizedBox(
        height: 200, // Fixed height for each job card
        // margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Card(
          elevation: 2,
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
                        job.jobTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.blueAccent),
                      onPressed: _shareJob,
                    ),
                  ],
                ),
                // verticalSpacer,
                Row(
                    children: [
                      const Icon(Icons.location_on_sharp),
                      Text(
                        job.companyLocation,
                        style: cardTextStyle,
                      )
                    ]
                ),
                verticalSpacer,
                Text(
                  '\$${job.salaryInUSDollar.toStringAsFixed(0)}',
                  style: cardTextStyle,
                ),
                verticalSpacer,
                Text(
                  job.employmentType,
                  style: cardTextStyle,
                ),
                verticalSpacer,
                Text(
                  job.workSetting,
                  style: cardTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
