// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fashion_app/main.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';

// class RegisterController {
//   var collection = FirebaseFirestore.instanceFor(app: app).collection("User");
//   var data;

//   addData(String username, String email) async {
//     final data1 = <String, dynamic>{
//       "username": username,
//       "email": email
//     };
//     collection.doc(auth.currentUser!.uid).set(data1);
//   }
// }