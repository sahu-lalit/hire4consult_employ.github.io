import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobCard extends StatelessWidget {
  final String companyName;
  final String department;
  final String jobDescription;
  final String jobType;
  final List<String> keySkills;
  final String position;
  final String region;
  final String specialization;
  final String timeZone;
  final String jobId; // Add jobId field

  const JobCard({
    Key? key,
    required this.jobId, // Add jobId parameter
    required this.companyName,
    required this.department,
    required this.jobDescription,
    required this.jobType,
    required this.keySkills,
    required this.position,
    required this.region,
    required this.specialization,
    required this.timeZone,
  }) : super(key: key);

  Future<List<Map<String, String>>> _fetchApplicantDetails() async {
    List<Map<String, String>> applicantDetails = [];
    try {
      DocumentSnapshot jobDoc =
          await FirebaseFirestore.instance.collection('jobs').doc(jobId).get();
      List<dynamic> applicantUIDs = jobDoc['applicants'];

      for (String uid in applicantUIDs) {
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        applicantDetails.add({
          'email': userDoc['email'],
          'username': userDoc['username'],
          'resumeLink': userDoc['resumeLink'],
        });
      }
    } catch (e) {
      print('Error fetching applicant details: $e');
    }
    return applicantDetails;
  }

  void _showApplicantDetails(
      BuildContext context, List<Map<String, String>> details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Applicant Details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: details.map((detail) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Email: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(detail['email'] ?? ''),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Username: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(detail['username'] ?? ''),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Resume Link: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(detail['resumeLink'] ?? ''),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        List<Map<String, String>> details = await _fetchApplicantDetails();
        _showApplicantDetails(context, details);
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                companyName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('Department: $department'),
              Text('Job Description: $jobDescription'),
              Text('Job Type: $jobType'),
              Text('Key Skills: ${keySkills.join(', ')}'),
              Text('Position: $position'),
              Text('Region: $region'),
              Text('Specialization: $specialization'),
              Text('Time Zone: $timeZone'),
            ],
          ),
        ),
      ),
    );
  }
}
