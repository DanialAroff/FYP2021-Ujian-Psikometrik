import 'package:flutter/material.dart';
import 'package:fyp1/appscreens/psychometrictest/inventori_kematangan_kerjaya.dart';
import 'package:fyp1/models/user.dart';
import 'package:fyp1/shared/constants.dart';
import 'appcolors.dart';

class TestCard extends StatelessWidget {
  final String testCode;
  final MyUser user;
  const TestCard({Key key, this.testCode, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String testName;
    if (testCode == 'IKK') {
      testName = 'Inventori Kematangan Kerjaya';
    } else if (testCode == 'ITP') {
      testName = 'Inventori Trait Personaliti';
    } else if (testCode == 'IMK') {
      testName = 'Inventori Minat Kerjaya';
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Card(
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              gradient: LinearGradient(colors: [
                AppColors.primary,
                AppColors.primary,
              ], begin: Alignment.topCenter)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                testName,
                style: const TextStyle(
                    fontFamily: mainFont,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.start,
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {
                  if (testCode == 'IKK') {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                PsychometricTestIKK(user: user),
                            transitionDuration: Duration.zero));
                  } else if (testCode == 'ITP') {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                PsychometricTestIKK(user: user),
                            transitionDuration: Duration.zero));
                  }
                },
                child: const Text(
                  'Jawab Ujian',
                  style: TextStyle(
                      // color: AppColors.primary,
                      color: Colors.white,
                      fontFamily: mainFont,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                    primary: AppColors.gray,
                    minimumSize: const Size(130, 40),
                    // backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 0.8),
                    splashFactory: InkRipple.splashFactory),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
