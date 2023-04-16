import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:eva/utilities/firebase/storage/storage.dart';

class FileDownloader {
  final StorageService _storageService = StorageService();

  Future<Uint8List> downloadFile(String downloadUrl) async {
    debugPrint('Starting download...');

    try {
      final ref = _storageService.storage
          .refFromURL('gs://elderly-virtual-assistant-2.appspot.com');
      final img = await ref.child(downloadUrl).getDownloadURL();
      if (img != null) {
        final file = await http.get(Uri.parse(img));
        debugPrint('Status Code: ${file.statusCode}');
        return file.bodyBytes;
      }
      const oneMegabyte = 1024 * 1024;
      debugPrint('DownloadUrl Failed, attempting getData method.');
      final Uint8List? data = await ref.getData(oneMegabyte);
      if (data != null) {
        return data;
      }
    } on FirebaseException catch (e) {
      // Handle any errors.
      debugPrint('Firebase errors on file download!');
    }
    final data = Uint8List(0);
    return data;
  }
}
