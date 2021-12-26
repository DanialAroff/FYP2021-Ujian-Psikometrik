// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fyp1/appscreens/authenticate/authenticate.dart';
import 'package:fyp1/models/user.dart';
import 'package:provider/provider.dart';
import 'direct.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    final user = Provider.of<MyUser>(context);
    
    if (user == null) {
      return const Authenticate();
    } else {
      return Direct(uid: user.uid);
    }
  }
}
