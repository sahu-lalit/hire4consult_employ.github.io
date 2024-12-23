import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hire4consult_employ/controller/jobs_controller/jobs_controller_impl.dart';
import 'package:hire4consult_employ/controller/jobs_controller/jobs_dropdowns_controller.dart';
import 'package:hire4consult_employ/model/jobs_model/jobs_model.dart';
import 'package:hire4consult_employ/view/main_view/widgets/job_card.dart';
import 'package:hire4consult_employ/view/profile_view/profile_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final TextEditingController jobTypeController = TextEditingController();
  final TextEditingController keySkillsController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController timeZoneController = TextEditingController();

  Future<void> _submitJob() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference jobs = FirebaseFirestore.instance.collection('jobs');
    await jobs.add({
      'company_name': companyNameController.text,
      'department': departmentController.text,
      'job_description': jobDescriptionController.text,
      'job_type': jobTypeController.text,
      'key_skills': keySkillsController.text.split(','),
      'position': positionController.text,
      'region': regionController.text,
      'specialization': specializationController.text,
      'time_zone': timeZoneController.text,
      'userID': user?.uid,
      'applicants': [],
    });
  }

  @override
  Widget build(BuildContext context) {
    var jobsController = Provider.of<JobsControllerImpl>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    width: 260,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/hire_logo.png'),
                            fit: BoxFit.cover)),
                  ),
                  Center(
                    child: Text(
                      'Post a Job',
                      textAlign: TextAlign.center,
                      
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                        letterSpacing:
                            1.2, // Add letter spacing for a modern look
                      ),
                    ),
                  ),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20),
                      color: Colors.grey[500],
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Create a Job'),
                              content: SingleChildScrollView(
                                child: Column(
                                  spacing: 10.0,
                                  children: [
                                    TextField(
                                      controller: companyNameController,
                                      decoration: InputDecoration(
                                          labelText: 'Company Name'),
                                    ),
                                    TextField(
                                      controller: departmentController,
                                      decoration: InputDecoration(
                                          labelText: 'Department'),
                                    ),
                                    TextField(
                                      controller: jobDescriptionController,
                                      decoration: InputDecoration(
                                          labelText: 'Job Description'),
                                    ),
                                    TextField(
                                      controller: jobTypeController,
                                      decoration: InputDecoration(
                                          labelText: 'Job Type'),
                                    ),
                                    TextField(
                                      controller: keySkillsController,
                                      decoration: InputDecoration(
                                          labelText: 'Key Skills'),
                                    ),
                                    TextField(
                                      controller: positionController,
                                      decoration: InputDecoration(
                                          labelText: 'Position'),
                                    ),
                                    TextField(
                                      controller: regionController,
                                      decoration:
                                          InputDecoration(labelText: 'Region'),
                                    ),
                                    TextField(
                                      controller: specializationController,
                                      decoration: InputDecoration(
                                          labelText: 'Specialization'),
                                    ),
                                    TextField(
                                      controller: timeZoneController,
                                      decoration: InputDecoration(
                                          labelText: 'Time Zone'),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Submit'),
                                  onPressed: () async {
                                    await _submitJob();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Create a Job',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('jobs')
                    .where('userID',
                        isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        color: Colors.blue,
                        size: 50.0,
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text('No jobs found.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var jobData = snapshot.data!.docs[index];
                      return JobCard(
                        jobId: jobData.id, // Pass the job document ID
                        companyName: jobData['company_name'],
                        department: jobData['department'],
                        jobDescription: jobData['job_description'],
                        jobType: jobData['job_type'],
                        keySkills: List<String>.from(jobData['key_skills']),
                        position: jobData['position'],
                        region: jobData['region'],
                        specialization: jobData['specialization'],
                        timeZone: jobData['time_zone'],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ));
  }
}
