import 'dart:typed_data';

import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FireAuth fireAuth = FireAuth();

  Future<String> uploadImageToStorage(
      String childName, Uint8List imageFile) async {
    final userId = await fireAuth.getCurrentUserId();
    final Reference storageRef = _storage.ref().child(childName).child(userId);

    try {
      final UploadTask uploadTask = storageRef.putData(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException  {
      throw FirebaseException;
    }
  }
}
