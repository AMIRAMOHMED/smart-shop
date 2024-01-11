import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;

  UserModel? get getUserModel {
    return userModel;
  }

  Future<UserModel?> fetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user == null) {
      return null;
    }
    var uid = user.uid;
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      final userDocDict = userDoc.data();
      userModel = UserModel(
          userName: userDoc.get("userName"),
          userId: userDoc.get("userId"),
          userIamge: userDoc.get("userIamge"),
          userEmail: userDoc.get("userEmail"),
          createdAt: userDoc.get("createdAt"),
          userCart: userDocDict!.containsKey("userCart")
              ? userDoc.get("userCart")
              : [],
          userWish: userDocDict.containsKey("userWish")
              ? userDoc.get("userWish")
              : []);
      return userModel;
    } on FirebaseException catch (error) {
      throw error.message.toString();
    } catch (error) {
      rethrow;
    }
  }
}
