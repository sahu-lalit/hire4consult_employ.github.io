import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hire4consult_employ/controller/auth_controller/auth_controller_concrete.dart';
import 'package:hire4consult_employ/controller/jobs_controller/jobs_controller_impl.dart';
import 'package:hire4consult_employ/controller/jobs_controller/jobs_dropdowns_controller.dart';
import 'package:hire4consult_employ/firebase_options.dart';
import 'package:hire4consult_employ/utils/locator.dart';
import 'package:hire4consult_employ/view/login_view/login_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator(FirebaseFirestore.instance);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthControllerConcrete()),
      ChangeNotifierProvider(create: (_) => locator<JobsControllerImpl>()),
      ChangeNotifierProvider(create: (_) => locator<JobsDropdownsController>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      autofocus: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
