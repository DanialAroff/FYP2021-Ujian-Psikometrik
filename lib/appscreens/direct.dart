import 'package:flutter/material.dart';
import 'package:fyp1/appscreens/home/home_admin.dart';
import 'package:fyp1/appscreens/home/home_student.dart';
import 'package:fyp1/models/user.dart';
import 'package:fyp1/services/database.dart';
import 'package:fyp1/shared/loading.dart';
import 'package:fyp1/shared/globals.dart' as globals;

class Direct extends StatelessWidget {
  final String uid;
  const Direct({Key key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyUser>(
      future: DatabaseService(uid: uid).getUser,
      builder: (BuildContext context, AsyncSnapshot<MyUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else {
          if (snapshot.hasError) {
            return null;
          } else {
            debugPrint('User Role : ' + snapshot.data.userRole);
            MyUser userModel = MyUser(
                uid: uid,
                email: snapshot.data.email,
                fullName: snapshot.data.fullName,
                userRole: snapshot.data.userRole);
            globals.userModel = userModel;
            if (snapshot.data.userRole == 'admin') {
              return const AdminHomePage();
            } else {
              return StudentHomePage(user: userModel);
            }
          }
        }
      },
    );
  }
}
