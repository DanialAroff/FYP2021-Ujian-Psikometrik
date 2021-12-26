// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp1/appscreens/wrapper.dart';
import 'package:fyp1/models/user.dart';
import 'package:fyp1/services/auth.dart';
import 'package:fyp1/shared/appcolors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
        theme: ThemeData(fontFamily: 'Nunito Sans', unselectedWidgetColor: AppColors.primary),
      ),
    );
  }
}
