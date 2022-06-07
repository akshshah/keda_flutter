import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/bottomNavigation/firestore_chat_module/screens/chat_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/firestore_chat_module/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:keda_flutter/utils/app_color.dart';
import 'package:keda_flutter/utils/logger.dart';
import 'package:keda_flutter/utils/utils.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const routeName = "/auth-screen";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String password, String username, File? imageFile, bool isLogin) async {
    UserCredential userCredential;
    try {
      setState((){
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        if(userCredential.user?.uid != null && imageFile != null){
          final ref = FirebaseStorage.instance.ref().child('user_image').child(userCredential.user?.uid ?? "" "_image");

          await ref.putFile(imageFile).whenComplete(() => null);

          final imageUrl = await ref.getDownloadURL();

          await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
            'username' : username,
            'email' : email,
            'imageUrl' : imageUrl,
          });
        }
        else{
          Utils.showSnackBarWithContext(context, "Oops!, Something went wrong.");
        }
      }

      setState((){
        _isLoading = false;
      });

      Navigator.pushReplacementNamed(context, ChatScreen.routeName);

    } on FirebaseAuthException catch (e) {
      Logger().e("Error Message : ${e.code}");
      var errorMessage = "Authentication Failed ";
      if (e.code == 'weak-password') {
        errorMessage += ': The password provided is too weak.';
      }
      else if (e.code == 'email-already-in-use') {
        errorMessage += ': The account already exists for that email.';
      }
      else if (e.code == 'user-not-found') {
        errorMessage += ': No user found for that email.';
      }
      else if (e.code == 'wrong-password') {
        errorMessage += ': Wrong password provided for that user.';
      }
      else if (e.code == 'invalid-email') {
        errorMessage += ': The email format is not correct';
      }
      Utils.showSnackBarWithContext(context, errorMessage);
      setState((){
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorPrimary,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.colorPrimary,
          body: AuthForm(submitFn: _submitAuthForm, isLoading: _isLoading),
        ),
      ),
    );
  }
}
