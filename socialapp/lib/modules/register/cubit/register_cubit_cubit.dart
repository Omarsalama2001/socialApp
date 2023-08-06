import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/models/user_model.dart';
part 'register_cubit_state.dart';

class RegisterCubitCubit extends Cubit<RegisterCubitState> {
  RegisterCubitCubit() : super(RegisterCubitInitial());
  static RegisterCubitCubit getCubit(BuildContext context) {
    return BlocProvider.of(context);
  }

  bool isVisable = false;
  void changeObsecure() {
    isVisable = !isVisable;
    emit(ChangeObsecure());
  }

  void createUser(
    String userName,
    String email,
    String phone,
    String? uId,
  ) {
    emit(CreateUserLoading());
    UserMoedl model = UserMoedl(email: email, phone: phone, userName: userName, userId: uId);
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap(model)).then((_) {
      emit(CreateUserSuccess());
    }).catchError((error) {
      emit(CreateUserError(error));
    });
  }

  void register(String email, String password, String phone, String userName) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((UserCredential response) {
      createUser(userName, email, phone, response.user!.uid);
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }
}
