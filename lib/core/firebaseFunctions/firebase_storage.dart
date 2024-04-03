import 'dart:typed_data';

import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FireAuth fireAuth = FireAuth();

  Future<String> uploadImageToStorage(
      String childName, Uint8List imageFile,) async {
    final userId = fireAuth.getCurrentUserId();
    final storageRef = _storage.ref().child(childName).child(userId);

    try {
      final uploadTask = storageRef.putData(imageFile);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException {
      throw FirebaseException;
    }
  }
}
