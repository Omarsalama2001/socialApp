import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: unused_import
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:socialapp/modules/homescreen/homes_layout.dart';
import 'package:socialapp/modules/login/loginscreen.dart';
import 'package:socialapp/shared/shared/bloc_observer.dart';
import 'package:socialapp/shared/shared/cache_helper.dart';
import 'package:socialapp/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CasheHelper.createSharedPrefrence();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  late bool isLoggedIn = CasheHelper.checkIfLoggedIn('uId');
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  bool isLoggedIn;
  MyApp({required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(appBarTheme: const AppBarTheme(color: Colors.black)),
          debugShowCheckedModeBanner: false,
          home: isLoggedIn ? const HomeScreen() : loginScreen(),
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate, //translate some widgets by it self to diff
            GlobalWidgetsLocalizations.delegate, //reponsaple for change direction of the widget based on the current widget
            GlobalCupertinoLocalizations.delegate, //translate some widgets by it self to diff lang
          ],
          localeResolutionCallback: (Locale? deviceLocale, supportedLocales) {
            if (deviceLocale != null) {
              return deviceLocale; // if this lang not supported flutter pick the first one in your list codes
            }
          },
        );
      },
      designSize: const Size(360, 690),
      splitScreenMode: true,
    );
  }
}
