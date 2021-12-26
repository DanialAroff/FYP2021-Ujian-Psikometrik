import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp1/models/inventory_item.dart';
import 'package:fyp1/models/user.dart';
import 'package:fyp1/services/database.dart';
import 'package:fyp1/shared/appcolors.dart';
import 'package:fyp1/shared/loading.dart';

class PsychometricTestIKK extends StatefulWidget {
  const PsychometricTestIKK({Key key, this.user}) : super(key: key);
  final MyUser user;

  @override
  _PsychometricTestIKKState createState() => _PsychometricTestIKKState();
}

class _PsychometricTestIKKState extends State<PsychometricTestIKK> {
  List<ItemIKK> _itemsDS; // domain sikap
  List<ItemIKK> _itemsDK; // domain kecekapan
  List<String> _dsSelectedAnswer = [];
  List<String> _dkSelectedAnswer;
  final String _initialValue = 'Not selected';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background1,
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:
                  const Icon(Icons.keyboard_arrow_left, color: AppColors.text2),
            );
          }),
          title: const Text(
            'Inventori Kematangan Kerjaya',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: AppColors.text2),
          ),
          backgroundColor: AppColors.background1,
          elevation: 0,
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: DatabaseService().itemsIKK,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Text('Something is wrong');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              // QuerySnapshot.docs to get a list of document snapshot
              List<DocumentSnapshot> documents = snapshot.data.docs;
              _itemsDS = [];
              _itemsDK = [];
              _dsSelectedAnswer = [];
              _dkSelectedAnswer = [];

              for (DocumentSnapshot document in documents) {
                if (document.get('domain') == 'sikap') {
                  _itemsDS.add(ItemIKK.fromMap(document.data()));
                } else if (document.get('domain') == 'kecekapan') {
                  _itemsDK.add(ItemIKK.fromMap(document.data()));
                }
              }
              // _fillList(_dsSelectedAnswer, _itemsDS.length);
              // _fillList(_dkSelectedAnswer, _itemsDK.length);
              return ListView(
                padding: const EdgeInsets.all(10.0),
                physics: const BouncingScrollPhysics(),
                addAutomaticKeepAlives: true,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 2.0, color: AppColors.secondary),
                      ),
                    ),
                    child: const Text(
                      'Domain Sikap',
                      style: TextStyle(
                          color: AppColors.text2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  listBuilder(_itemsDK, _dsSelectedAnswer),
                  const SizedBox(height: 12.0),
                  listBuilder(_itemsDK, _dsSelectedAnswer),
                  listBuilder(_itemsDS, _dsSelectedAnswer),
                  // Container(
                  //   padding: const EdgeInsets.all(10.0),
                  //   decoration: const BoxDecoration(
                  //     border: Border(
                  //       bottom:
                  //           BorderSide(width: 2.0, color: AppColors.secondary),
                  //     ),
                  //   ),
                  //   child: const Text(
                  //     'Domain Kecekapan',
                  //     style: TextStyle(
                  //         color: AppColors.text2,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 16),
                  //   ),
                  // ),
                  // listBuilder(_itemsDK, _dkSelectedAnswer),
                ],
              );
            }
            return const ScoreLoading();
          },
        ));
  }

  // to build list of question card. Divided to 2 sections.
  // First is the question number and the second is radio buttons.
  Widget listBuilder(List<ItemIKK> items, List<String> selectedAnswers) {
    List<Widget> itemCard = [];
    for (int x = 0; x < items.length; x++) {
      itemCard.insert(
          x,
          ItemCardIKK(
            item: items.elementAt(x),
          ));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      addAutomaticKeepAlives: true,
      itemBuilder: (context, position) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4)),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(children: [
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                decoration: const BoxDecoration(
                    // color: AppColors.secondary,
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  topRight: Radius.circular(6.0),
                )),
                child: Text(
                  'Soalan ${position + 1}',
                  style: const TextStyle(
                      color: AppColors.text2, fontWeight: FontWeight.bold),
                )),
            Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                child: itemCard.elementAt(position)),
          ]),
        );
      },
      physics: const BouncingScrollPhysics(),
    );
  }

  // void _fillList(List<String> selectedAnswers, int length) {
  //   for (int x = 0; x < length; x++) {
  //     selectedAnswers.add(_initialValue);
  //   }
  // }
}
