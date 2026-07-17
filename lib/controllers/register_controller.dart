// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fashion_app/main.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';

// class RegisterController {
    
// final CollectionReference _usercollection = FirebaseFirestore.instance
//       .collection('users'); 

//   Future <void> addData(String username, String email, String image, String uid) async {
//     final data1 = <String, dynamic>{
//       "username": username,
//       "email": email,
//       "profile image": image,
//       "uid": uid
//     };
//     _usercollection.add(data1);
//   //  _usercollection.doc(uid).set(data1, SetOptions(merge: true));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterController {
  final CollectionReference _userCollection = 
      FirebaseFirestore.instance.collection('users');

  Future<void> addData(String username, String email, String image, String uid) async {
    try {
      await _userCollection.doc(uid).set({
        "username": username,
        "email": email,
        "profileImage": image,
        "createdAt": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding user data: $e");
      rethrow;
    }
  }
}