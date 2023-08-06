import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/app_localizations.dart';
import 'package:socialapp/modules/homescreen/homes_layout.dart';
import 'package:socialapp/modules/login/cubit/login_cubit.dart';
import 'package:socialapp/modules/register/registerscreen.dart';
import 'package:socialapp/shared/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/shared/cache_helper.dart';

class loginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  loginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSucessState) {
              Fluttertoast.showToast(msg: "login successfully ", backgroundColor: Colors.green);
              CasheHelper.saveData('uId', state.userId!);
              navigateAndFinish(context: context, screen: const HomeScreen());
            }
            if (state is LoginErrorState) {
              Fluttertoast.showToast(msg: state.error!, backgroundColor: Colors.redAccent);
            }
          },
          builder: (context, state) {
            LoginCubit cubit = LoginCubit.getCubit(context);
            return Padding(
              padding: EdgeInsets.all(15.0.sp),
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(
                        AppLocalizations.of(context)!.translate("login")!,
                        style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Login with us right now ",
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      defaultTff(
                          controller: emailController,
                          text: "Email Address",
                          prefixIcon: Icons.email_outlined,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Email mus not be empty";
                            } else {
                              return null;
                            }
                          },
                          isObsecure: false),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      defaultTff(
                          controller: passwordController,
                          text: "Password",
                          prefixIcon: Icons.lock,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Email mus not be empty";
                            } else {
                              return null;
                            }
                          }, ////////
                          isObsecure: cubit.isVisable,
                          suffixIcon: cubit.isVisable ? Icons.visibility_off : Icons.visibility,
                          onSuffixPressed: () {
                            cubit.changeObsecure();
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      buildButton(state, formKey, emailController, passwordController, cubit),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Dont have an account?', style: TextStyle(fontSize: 12.sp)),
                          TextButton(
                              onPressed: () {
                                navigator(context: context, screen: RegisterScreen());
                              },
                              child: Text(
                                "Register Now ",
                                style: TextStyle(fontSize: 12.sp),
                              ))
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget buildButton(var state, var formKey, var emailController, var passwordController, var cubit) {
  if (state is LoginLoadingState) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.black,
    ));
  } else {
    return defaultButton(
        text: "LOGIN",
        onPressed: () {
          if (formKey.currentState!.validate()) {
            cubit.userLogin(emailController.text, passwordController.text);
          }
        });
  }
}
