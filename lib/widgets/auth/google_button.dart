import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shop_smart/root.dart';

import '../../services/my_app_methods.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});
  Future<void>? googleSignIn({required BuildContext context}) async {
    final googleSignIN = GoogleSignIn();
    final googleAccount = await googleSignIN.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final authResult = await FirebaseAuth.instance.signInWithCredential(
              GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken));
          if (authResult.additionalUserInfo!.isNewUser) {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(authResult.user!.uid)
                .set({
              "userId": authResult.user!.uid,
              "userName": authResult.user!.displayName,
              "userIamge": authResult.user!.photoURL,
              "userEmail": authResult.user!.email,
              "createdAt": Timestamp.now(),
              "userCart": [],
              "userWish": [],
            });
          }
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await Navigator.pushNamed(context, RootScreen.id);
          });
        } on FirebaseException catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await MyAppMethods.showErrorOrWarningDialog(
              fct: () {},
              subTitle: "An error has been occured ${error.message}",
              context: context,
            );
          });
        } catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await MyAppMethods.showErrorOrWarningDialog(
              fct: () {},
              subTitle: "An error has been occured $error",
              context: context,
            );
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          googleSignIn(context: context);
        },
        style: ElevatedButton.styleFrom(minimumSize: const Size(150, 50)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Ionicons.logo_google,
              size: 20,
              color: Colors.red,
            ),
            Text(
              "Sign in with google",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ));
  }
}
