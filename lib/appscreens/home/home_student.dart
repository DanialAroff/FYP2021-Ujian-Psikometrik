// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp1/models/user.dart';
import 'package:fyp1/services/database.dart';
import 'package:fyp1/shared/appcolors.dart';
// import 'package:fyp1/services/auth.dart';
import 'package:fyp1/shared/loading.dart';
import 'package:fyp1/shared/drawer.dart';
import 'package:fyp1/shared/scorecards.dart';
import 'package:fyp1/shared/testcard.dart';
import 'package:provider/provider.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key key, this.user}) : super(key: key);
  final MyUser user;

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  // final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<DocumentSnapshot>.value(
      value: DatabaseService(uid: widget.user.uid).currentUserIKKScore,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu, color: AppColors.text2),
            );
          }),
          title: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: 'Selamat Datang',
                    style: TextStyle(fontSize: 11, color: AppColors.text2)),
                TextSpan(
                    text: '\n${widget.user.fullName}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text2)),
              ],
            ),
          ),
          backgroundColor: AppColors.background1,
          elevation: 0,
        ),
        drawer:
            AppDrawer(fullName: widget.user.fullName, email: widget.user.email),
        body: SafeArea(
          right: false,
          left: false,
          // Main container
          child: Container(
            color: AppColors.background1,
            child: ListView(
              padding: EdgeInsets.all(10),
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Text(
                        'Ujian Psikometrik',
                        style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text2),
                      ),
                    ),
                    // the test cards
                    TestCard(
                        testCode: 'IKK', user: widget.user),
                    SizedBox(
                      height: 5,
                    ),
                    TestCard(
                      testCode: 'ITP', user:  widget.user),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // SKOR UJIAN
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Text(
                        'Skor Ujian',
                        style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text2),
                      ),
                    ),
                    // Test Scores
                    StreamBuilder<DocumentSnapshot>(
                        stream: DatabaseService(uid: widget.user.uid)
                            .currentUserIKKScore,
                        builder: (BuildContext buildContext,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.data.exists) {
                              return ScoreCard(
                                  score: snapshot.data,
                                  title: 'Inventori Kematangan Kerjaya');
                            } else {
                              return SizedBox.shrink();
                            }
                          } else {
                            // need to add a spinkit
                            return ScoreLoading();
                          }
                        }),
                    SizedBox(height: 12),
                    StreamBuilder<DocumentSnapshot>(
                        stream: DatabaseService(uid: widget.user.uid)
                            .currentUserITPScore,
                        builder: (BuildContext buildContext,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.data.exists) {
                              return ScoreCard(
                                  score: snapshot.data,
                                  title: 'Inventori Trait Personaliti');
                            } else {
                              return SizedBox.shrink();
                            }
                          } else {
                            // need to add a spinkit
                            return ScoreLoading();
                          }
                        }),
                    SizedBox(height: 12),
                    StreamBuilder<DocumentSnapshot>(
                        stream: DatabaseService(uid: widget.user.uid)
                            .currentUserIMKScore,
                        builder: (BuildContext buildContext,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.data.exists) {
                              return ScoreCard(
                                  score: snapshot.data,
                                  title: 'Inventori Minat Kerjaya');
                            } else {
                              return SizedBox.shrink();
                            }
                          } else {
                            // need to add a spinkit
                            return ScoreLoading();
                          }
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget testCard(BuildContext context, String uid, MyUser user) {
  //   String fullName = user.fullName;
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width,
  //     height: 150,
  //     child: Card(
  //       elevation: 0,
  //       child: Container(
  //         padding: const EdgeInsets.all(15),
  //         decoration: const BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(5)),
  //             gradient: LinearGradient(colors: [
  //               AppColors.primary,
  //               AppColors.primary,
  //             ], begin: Alignment.topCenter)),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(
  //               testName,
  //               style: const TextStyle(
  //                   fontFamily: mainFont,
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.white),
  //               textAlign: TextAlign.start,
  //             ),
  //             const Spacer(),
  //             OutlinedButton(
  //               onPressed: () {
  //                 if (page == 'IKK') {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) => const PsychometricTestIKK()));
  //                 } else if (page == 'ITP') {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) => const PsychometricTestIKK()));
  //                 }
  //               },
  //               child: const Text(
  //                 'Jawab Ujian',
  //                 style: TextStyle(
  //                     // color: AppColors.primary,
  //                     color: Colors.white,
  //                     fontFamily: mainFont,
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //               style: OutlinedButton.styleFrom(
  //                   primary: AppColors.gray,
  //                   minimumSize: const Size(130, 40),
  //                   // backgroundColor: Colors.white,
  //                   side: const BorderSide(color: Colors.white, width: 0.8),
  //                   splashFactory: InkRipple.splashFactory),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
