import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/extensions.dart';
import 'package:socialapp/modules/login/loginscreen.dart';
import 'package:socialapp/modules/register/cubit/register_cubit_cubit.dart';
import 'package:socialapp/shared/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var emailAdressController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubitCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<RegisterCubitCubit, RegisterCubitState>(
          listener: (context, state) {
            if (state is CreateUserSuccess) {
              Fluttertoast.showToast(msg: "welcome to our family", backgroundColor: Colors.green);
              navigateAndFinish(context: context, screen: loginScreen());
            }
            if (state is RegisterErrorState) {
              Fluttertoast.showToast(msg: state.error!, backgroundColor: Colors.redAccent);
            }
          },
          builder: (context, state) {
            var cubit = RegisterCubitCubit.getCubit(context);
            return Padding(
              padding: EdgeInsets.all(15.0.sp),
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(
                        "REGISTER".tr(context, "signup"),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 45.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Register Now and Communicate with your friends",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      defaultTff(
                          controller: userNameController,
                          text: "User Name",
                          prefixIcon: Icons.person,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "User Name cannot be Empty";
                            } else {
                              return null;
                            }
                          },
                          isObsecure: false),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      defaultTff(
                          controller: emailAdressController,
                          text: "Email Address",
                          prefixIcon: Icons.email,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          isObsecure: false),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      defaultTff(
                          controller: passwordController,
                          text: "Password",
                          prefixIcon: Icons.lock,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "password cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          suffixIcon: cubit.isVisable ? Icons.visibility_off : Icons.visibility,
                          isObsecure: cubit.isVisable,
                          onSuffixPressed: () {
                            cubit.changeObsecure();
                          }),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      defaultTff(
                          controller: phoneController,
                          text: "Phone",
                          prefixIcon: Icons.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "phone cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          isObsecure: false),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      buildButton(state, formKey, emailAdressController, passwordController, phoneController, userNameController, cubit),
                      SizedBox(height: MediaQuery.of(context).size.height / 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          TextButton(
                              onPressed: () {
                                navigateAndFinish(context: context, screen: loginScreen());
                              },
                              child: Text(
                                "Login Now ",
                                style: TextStyle(fontSize: 10.sp),
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

bool checkEmailValidity(String email) {
  final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  return emailValid;
}

bool CheckPasswordValidity(String password) {
  final bool emailValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password);
  return emailValid;
}

Widget buildButton(var state, var formKey, var emailAdressController, var passwordController, var phoneController, var userNameController, var cubit) {
  if (state is RegisterLoadingState || state is CreateUserLoading) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.black,
    ));
  } else {
    return defaultButton(
        text: "Register",
        onPressed: () {
          if (formKey.currentState!.validate()) {
            if (checkEmailValidity(emailAdressController.text)) {
              if (CheckPasswordValidity(passwordController.text)) {
                cubit.register(emailAdressController.text, passwordController.text, phoneController.text, userNameController.text);
              } else {
                Fluttertoast.showToast(msg: "password is badly formated ", backgroundColor: Colors.red);
              }
            } else {
              Fluttertoast.showToast(msg: "email is badly formated ", backgroundColor: Colors.red);
            }
          }
        });
  }
}
