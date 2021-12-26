import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreInsertTesting {
  final String uid;
  ScoreInsertTesting(this.uid);

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('skor_inventori_kematangan_kerjaya');

  Future insertScore(String domain) async {
    
  }
}
