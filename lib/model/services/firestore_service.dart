import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_mvvm/model/services/app_helper.dart';

class FirestoreService {
  
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ================================================================= Get Collection Data
  static Future<QuerySnapshot<Map<String, dynamic>>> getColData({
    required String collectionPath,
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

  /// ================================================================= Get Document Data
  static Future<DocumentSnapshot<Map<String, dynamic>>> getDocData({
    required String collectionPath,
    required String id,
  }) async {
    late DocumentSnapshot<Map<String, dynamic>> data;
    try {
      data = await _firestore.collection(collectionPath).doc(id).get();
    } on FirebaseException catch (error) {
      AppHelper.printt(error);
    } catch (error) {
      AppHelper.printt(error);
    }
    return data;
  }

  /// ================================================================= Set Document
  static Future<void> setData({
    required String collectionPath,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      _firestore.collection(collectionPath).doc(id).set(data);
    } on FirebaseException catch (error) {
      AppHelper.printt(error);
    } catch (error) {
      AppHelper.printt(error);
    }
  }

  /// ================================================================= Update Document
  static Future<void> updateData({
    required String collectionPath,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      _firestore.collection(collectionPath).doc(id).update(data);
    } on FirebaseException catch (error) {
      AppHelper.printt(error);
    } catch (error) {
      AppHelper.printt(error);
    }
  }

  /// ================================================================= Delete Document
  static Future<void> deleteDoc({
    required String collectionPath,
    required String id,
  }) async {
    try {
      _firestore.collection(collectionPath).doc(id).delete();
    } on FirebaseException catch (error) {
      AppHelper.printt(error);
    } catch (error) {
      AppHelper.printt(error);
    }
  }
}
