import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:eva/utilities/firebase/storage/storage.dart';

class FileDownloader {
  final StorageService _storageService = StorageService();

  Future<File> downloadFile(String downloadUrl) async {
    debugPrint('Starting download');
    final ref = _storageService.storage
        .refFromURL('gs://elderly-virtual-assistant-2.appspot.com');
    // final img = ref.child(downloadUrl).getDownloadURL();
    print(ref.name);
    try {
      const oneMegabyte = 1024 * 1024;
      print('GETTING DATA');
      final Uint8List? data = await ref.getData(oneMegabyte);
      print('GOT DATA');
      if (data != null) {
        return File.fromRawPath(data);
      }
    } on FirebaseException catch (e) {
      // Handle any errors.
      debugPrint('Firebase errors on file download!');
    }
    final data = Uint8List(0);
    return File.fromRawPath(data);
    // final url = await ref.getDownloadURL();
    // debugPrint(url);
    // final response = await http.get(Uri.parse(url));
    // final documentDirectory = await getApplicationDocumentsDirectory();
    // final filePath = '${documentDirectory.path}/${ref.name}';
    // final file = File(filePath);
    // await file.writeAsBytes(response.bodyBytes);
    // return file;
  }
}
