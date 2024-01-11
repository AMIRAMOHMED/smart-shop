import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserModel with ChangeNotifier {
  final String userName, userId, userIamge, userEmail;

  final Timestamp createdAt;
  final List userCart, userWish;

  UserModel(
      {required this.userName,
      required this.userId,
      required this.userIamge,
      required this.userEmail,
      required this.createdAt,
      required this.userCart,
      required this.userWish});
}
