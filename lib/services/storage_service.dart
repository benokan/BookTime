import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:book_time/services/auth_services.dart';

class StorageRepo {
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file) async {
    var userId = AuthService().getUidofCurrentUser();

    var storageRef = _storage.ref().child("user/$userId");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask;
    String downloadUrl = await (await completedTask).ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getUserProfileImage(String uid) async {
    return await _storage.ref().child("user/$uid").getDownloadURL();
  }

    getUserProfileRef(String uid) async {
    return await _storage.ref().child("user/$uid");
  }


}
