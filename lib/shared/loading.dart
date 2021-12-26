import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyp1/shared/appcolors.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary,
      child: const Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          duration: Duration(milliseconds: 500),
          size: 50,
        ),
      ),
    );
  }
}

class ScoreLoading extends StatelessWidget {
  const ScoreLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      child: Center(
        child: SpinKitRing(
          color: AppColors.secondary,
          duration: Duration(milliseconds: 700),
          size: 30,
          lineWidth: 3.0,
        ),
      ),
    );
  }
}
