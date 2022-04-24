import 'package:flutter/material.dart';
import 'package:fyp1/shared/globals.dart' as globals;
import 'package:fyp1/services/database.dart';

class UpdateIKKScore {
  final num dsScore;
  final num dkScore;
  num dsPercentageScore = 0.0;
  num dkPercentageScore = 0.0;
  num totalPercentage = 0.0;

  UpdateIKKScore(this.dsScore, this.dkScore) {
    _init();
  }

  void _init() {
    _calculatePercentageForEachDomain();
    _calculateTotalPercentage();
  }

  _calculatePercentageForEachDomain() {
    dsPercentageScore = dsScore / globals.dsItemCount.toDouble();
    dkPercentageScore = dkScore / globals.dkItemCount.toDouble();
  }

  _calculateTotalPercentage() {
    totalPercentage = (dsScore + dkScore) * 2;
  }

  Future updateScoretoFirebase() async {
    String uid = globals.userModel.uid;
    debugPrint('updating...');
    return await DatabaseService(uid: uid)
        .updateIKKScore(dsPercentageScore, dkPercentageScore);
  }
}
