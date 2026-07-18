import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import 'app.dart';

late final FirebaseApp firebaseApp;
late final FirebaseAuth firebaseAuth;
late final FirebaseFirestore firestore;

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  firebaseAuth = FirebaseAuth.instanceFor(app: firebaseApp);
  firestore = FirebaseFirestore.instanceFor(app: firebaseApp);
  runApp(const MyApp());
}
