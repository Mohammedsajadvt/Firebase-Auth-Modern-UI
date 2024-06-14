import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/domain/entities/user_entity.dart';

class FirebaseAuthRepository{
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  FirebaseAuthRepository():
    this._firebaseAuth = FirebaseAuth.instance,
    this._firebaseFirestore = FirebaseFirestore.instance;

    Future<UserEntity> signIn(String email,String password)async{
       try{
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    User user = userCredential.user!;
    return UserEntity(uid: user.uid, displayName: user.displayName!, email: user.email!);
   }catch(e){
   throw Exception('Error SignIn $e'); 
   }
    }
  Future<UserEntity?> signUp(String email,String password, String displayName)async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email,password: password);
      User user = userCredential.user!;
      await user.updateDisplayName(displayName);
      await user.reload();
      user = _firebaseAuth.currentUser!;
      await _firebaseFirestore.collection("users").doc(user.uid).set({
        'uid':user.uid,
        'email':user.email,
        'displayName':user.displayName
      });

    }catch(e){
      throw Exception('Error SignUp $e');
    }

  }  
  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }
  
}