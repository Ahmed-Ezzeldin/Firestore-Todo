import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_mvvm/model/services/app_helper.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ================================================================= Get Collection
  Future<QuerySnapshot<Map<String, dynamic>>> getDocData({
    required String collectionPath,
    required String docPath,
    required Map<String, dynamic> data,
  }) async {
    late QuerySnapshot<Map<String, dynamic>> data;
    try {
      data = await _firestore.collection(collectionPath).get();
    } on FirebaseException catch (error) {
      AppHelper.printt(error);
    } catch (error) {
      AppHelper.printt(error);
    }
    return data;
  }

  /// ================================================================= Get Document
  Future<DocumentSnapshot<Map<String, dynamic>>> getCollectionData({
    required String collectionPath,
    required String docPath,
    required Map<String, dynamic> data,
  }) async {
    late DocumentSnapshot<Map<String, dynamic>> data;
    try {
      data = await _firestore.collection(collectionPath).doc(docPath).get();
    } on FirebaseException catch (error) {
      AppHelper.printt(error);
    } catch (error) {
      AppHelper.printt(error);
    }
    return data;
  }

  /// ================================================================= Set Document
  Future<void> setData({
    required String collectionPath,
    required String docPath,
    required Map<String, dynamic> data,
  }) async {
    try {
      _firestore.collection(collectionPath).doc(docPath).set(data);
    } on FirebaseException catch (error) {
      AppHelper.printt(error);
    } catch (error) {
      AppHelper.printt(error);
    }
  }

  /// ================================================================= Update Document
  Future<void> updateData({
    required String collectionPath,
    required String docPath,
    required Map<String, dynamic> data,
  }) async {
    try {
      _firestore.collection(collectionPath).doc(docPath).update(data);
    } on FirebaseException catch (error) {
      AppHelper.printt(error);
    } catch (error) {
      AppHelper.printt(error);
    }
  }

  /// ================================================================= Delete Document
  Future<void> deleteDoc({
    required String collectionPath,
    required String docPath,
  }) async {
    try {
      _firestore.collection(collectionPath).doc(docPath).delete();
    } on FirebaseException catch (error) {
      AppHelper.printt(error);
    } catch (error) {
      AppHelper.printt(error);
    }
  }
}
