import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/app_localizations.dart';
import 'package:socialapp/modules/homescreen/cubit/soical_cubit.dart';
import 'package:socialapp/shared/shared/cache_helper.dart';
import 'package:socialapp/shared/shared/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SoicalCubit()..getUserData(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.translate("Home")!)),
        body: BlocConsumer<SoicalCubit, SoicalState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(children: [
              if (!FirebaseAuth.instance.currentUser!.emailVerified)
                Container(
                  color: Colors.grey.withOpacity(.6),
                  child: Padding(
                    padding: EdgeInsets.all(5.0.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.info_outline, size: 30),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Text(
                          "Please verify your email",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                        ),
                        const Spacer(),
                        TextButton(
                          child: Text("send",
                              style: TextStyle(
                                fontSize: 20.sp,
                              )),
                          onPressed: () {
                            print(FirebaseAuth.instance.currentUser!.emailVerified);
                            FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
                              Fluttertoast.showToast(msg: "email sent ", backgroundColor: Colors.greenAccent);
                            }).catchError((error) {
                              print(error);
                              Fluttertoast.showToast(msg: error.toString(), backgroundColor: Colors.redAccent);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ]);
          },
        ),
      ),
    );
  }
}
