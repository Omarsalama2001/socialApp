import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void navigator({@required BuildContext? context, Widget? screen}) {
  Navigator.push(context!, MaterialPageRoute(builder: (_) => screen!));
}

void navigateAndFinish({@required BuildContext? context, Widget? screen}) {
  Navigator.pushAndRemoveUntil(context!, MaterialPageRoute(builder: (_) => screen!), (route) => false);
}

Widget defaultTff({
  required TextEditingController? controller,
  required String? text,
  required IconData? prefixIcon,
  IconData? suffixIcon,
  required String? Function(String? value) validate,
  void Function()? onSuffixPressed,
  void Function(String? value)? onSaved,
  required bool isObsecure,
}) =>
    TextFormField(
      onFieldSubmitted: onSaved,
      obscureText: isObsecure,
      validator: validate,
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: onSuffixPressed,
            icon: !isObsecure ? Icon(suffixIcon) : const Icon(Icons.visibility_off_outlined),
          ),
          prefixIcon: Icon(
            prefixIcon,
          ),
          label: Text("$text"),
          border: const OutlineInputBorder()),
      style: TextStyle(fontSize: 15.sp),
    );

Widget defaultButton({
  required String text,
  required void Function() onPressed,
}) =>
    SizedBox(
      height: 40.sp,
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.black,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      ),
    );
