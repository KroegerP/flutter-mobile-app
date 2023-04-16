import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('your_collection_name');

  Future<List<DocumentSnapshot>> getAllDocuments() async {
    final snapshot = await _collectionReference.get();
    return snapshot.docs;
  }

  Future<DocumentSnapshot?> getDocumentById(String documentId) async {
    final snapshot = await _collectionReference.doc(documentId).get();
    return snapshot.exists ? snapshot : null;
  }

  Future<void> addDocument(Map<String, dynamic> data) async {
    await _collectionReference.add(data);
  }

  Future<void> updateDocument(
      String documentId, Map<String, dynamic> data) async {
    await _collectionReference.doc(documentId).update(data);
  }

  Future<void> deleteDocument(String documentId) async {
    await _collectionReference.doc(documentId).delete();
  }
}
