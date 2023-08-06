import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/shared/shared/constants.dart';

part 'soical_state.dart';

class SoicalCubit extends Cubit<SoicalState> {
  SoicalCubit() : super(SoicalInitial());
  static SoicalCubit getCubit(BuildContext context) {
    return BlocProvider.of(context);
  }

  void getUserData() {
    emit(SocialGetUserLoading());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(uId);
      print(value.data().toString());
      emit(SocialGetUserSuccess());
    }).catchError((error) {
      print(error);
      emit(SocialGetUserError());
    });
  }
}
