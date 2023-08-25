import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy_health_app/utils/storage_method.dart';
import 'package:provider/provider.dart';

import '../commons/constanst.dart';
import '../commons/user_provider.dart';
import '../models/usermoded.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<Map<String, dynamic>?> getCurrentUser(String? uid) async {
    if (uid != null) {
      final snap = await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      return snap.data();
    }
    return null;
  }

  Future<bool> signUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    bool res = false;
    try {
      res = false;
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await _firebaseFirestore
                .collection('users')
                .doc(cred.user!.uid)
                .get();
        if (snapshot.data() != null) {
          UserModel user = UserModel.fromMap(snapshot.data()!);
          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false).setUserData(user);
        }
      }
      res = true;
    } on FirebaseAuthException catch (e) {
      res = false;
      showSnackBar(context, e.message!);
    } catch (e) {
      res = false;
      showSnackBar(context, e.toString());
    }
    return res;
  }

  Future<bool> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
    required String phone,
    required Uint8List profilePic,
  }) async {
    bool res = false;
    try {
      res = false;
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String profileUrl =
          await uploadProfileToStorage(profilePic, credential.user!.uid);

      UserModel user = UserModel(
          name: username,
          email: email,
          phone: phone,
          uid: credential.user!.uid,
          password: password,
          profilePic: profileUrl);

      _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set(user.toMap());
      res = true;
    } on FirebaseAuthException catch (e) {
      res = false;
      showSnackBar(context, e.message!);
    } catch (e) {
      res = false;
      showSnackBar(context, e.toString());
    }
    return res;
  }
   signOut({required BuildContext context})async{
    try{
      await FirebaseAuth.instance.signOut();
    }catch(err){
       showSnackBar(context, err.toString());
    }
  }
}
