import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/classes/data_types.dart';

class FirestoreService {
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection('users');

  Future<List<DocumentSnapshot>> getAllDocuments() async {
    final snapshot = await _userRef.get();
    return snapshot.docs;
  }

  Future<ReportType?> getDocumentByIdOld(String documentId) async {
    final snapshot = await _userRef.doc(documentId).get();
    if (snapshot.exists) {
      print('Data received');
      final reports = ReportType.fromFirestore(snapshot);
      print(reports);
    }
    return snapshot.exists ? ReportType.fromFirestore(snapshot) : null;
  }

  Future<List<ReportType?>?> getDocumentById(String documentId) async {
    List<ReportType?> reportData = [];
    final snapshot =
        await _userRef.doc(documentId).collection('medications').get();
    final snapshotData = snapshot.docs;
    final snapshot2 = await _userRef.doc(documentId).get();
    // final snapshot = await FirebaseFirestore.instance
    //     .collection('users/$documentId/medications').get();
    if (snapshotData.isNotEmpty) {
      print('Data received');

      for (var element in snapshotData) {
        print(element);
        reportData.add(ReportType.fromFirestore(element));
      }
      print(reportData);
    }
    return reportData.isNotEmpty ? reportData : null;
  }

  Future<void> addDocument(Map<String, dynamic> data) async {
    await _userRef.add(data);
  }

  Future<void> updateDocument(
      String documentId, Map<String, dynamic> data) async {
    await _userRef.doc(documentId).update(data);
  }

  Future<void> deleteDocument(String documentId) async {
    await _userRef.doc(documentId).delete();
  }
}
