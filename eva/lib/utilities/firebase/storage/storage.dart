import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final String _storagePath = 'gs://elderly-virtual-assistant-2.appspot.com';

  Future<String> uploadFile(File file) async {
    final uploadTask = storage.ref(_storagePath).putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> deleteFile(String downloadUrl) async {
    final ref = storage.refFromURL(downloadUrl);
    await ref.delete();
  }
}
