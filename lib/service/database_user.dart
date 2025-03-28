import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fashion_app/main.dart';

const String USER_COLLECTION_REF="User";

class DatabaseUser {
  final _firestore = FirebaseFirestore.instanceFor(app: app);
  final _storage = FirebaseStorage.instanceFor(app: app);
  late final CollectionReference _userRef;
  late String imageurl;

  DatabaseUser() {
    _userRef = _firestore.collection(USER_COLLECTION_REF).withConverter<User>
    (fromFirestore: (snapshots,_)=>User.fromJson(snapshots.data()!), toFirestore: (account,_)=>account.toJson());
  }

  Stream <QuerySnapshot>getUsers () {
    return _userRef.snapshots();
  }

  void addUser(User user) {
    _userRef.add(user);
  }
  void updateUser(String userId, User user) {
    _userRef.doc(userId).update(user.toJson());
  }

  Future<User?> getAll(String userId) async {
    try {
      var snapshot = await _userRef.doc(userId).get();
      if (snapshot.exists) {
        var accountdata = snapshot.data();
        if (accountdata != null) {
          var account = accountdata as User;
          return account;
        }
      }
    } catch (e) {
      print("error getting username: $e");
    }
    return null;
  }

  Future<String?> getUsername(String userId) async {
    try {
      var snapshot = await _userRef.doc(userId).get();
      if(snapshot.exists) {
        var accountdata = snapshot.data();
        if (accountdata != null) {
          var account = accountdata as User;
          return account.getUsername();
        }
      }
    } catch (e) {
      print("Error getting username: $e");
    }
    return null;
  }

  Future<String?> getImage(String userId) async {
    try {
      var snapshot = await _userRef.doc(userId).get();
      if(snapshot.exists) {
        var accountdata = snapshot.data();
        if (accountdata != null) {
          var account = accountdata as User;
          return account.getProfileImage();
        }
      }
    } catch (e) {
      print("Error getting username: $e");
    }
    return null;
  }

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadurl = await snapshot.ref.getDownloadURL();
    return downloadurl;
  }

  Future<String?> getEmail(String userId) async {
    try {
      var snapshot = await _userRef.doc(userId).get();
      if(snapshot.exists) {
        var accountdata = snapshot.data();
        if(accountdata != null) {
          var account = accountdata as User;
          return account.getEmail();
        }
      }
    } catch (e) {
      print("Error getting username: $e");
    }
    return null;
  }

  void updateUsername(String userId, String username) {
   getAll(userId).then((value)=>{
    value?.setUsername(username),
    updateUser(userId, value??User("NoUsername", "NoEmail"))  
   });
  }

  void updateImage(String userId, Uint8List image) async {
    String imageurl = await uploadImageToStorage("profile", image);
    getAll(userId).then((value) => {
      value?.setProfileImage(imageurl),
      updateUser(userId, value??User("NoUsername", "NoEmail"))
    });
  }


}