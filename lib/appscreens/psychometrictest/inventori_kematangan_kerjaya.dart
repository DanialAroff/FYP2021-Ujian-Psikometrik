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
  final String _initialValue = 'Not selected';

  // 14/01/2022
  List<String> _gpValuesDK;
  List<String> _gpValuesDS;

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
              // fill list with all of the items/questions from firebase
              // according to the domain (Domain Sikap/Domain Kecekapan)
              for (DocumentSnapshot document in documents) {
                if (document.get('domain') == 'sikap') {
                  _itemsDS.add(ItemIKK.fromMap(document.data()));
                } else if (document.get('domain') == 'kecekapan') {
                  _itemsDK.add(ItemIKK.fromMap(document.data()));
                }
              }
              _gpValuesDS = List.filled(_itemsDS.length, _initialValue);
              _gpValuesDK = List.filled(_itemsDK.length, _initialValue);

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
                  listBuilder("DS"),
                  const SizedBox(height: 12.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 2.0, color: AppColors.secondary),
                      ),
                    ),
                    child: const Text(
                      'Domain Kecekapan',
                      style: TextStyle(
                          color: AppColors.text2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  listBuilder("DK"),
                  TextButton(
                      onPressed: () {
                        // for (int i = 0; i < _gpValuesDS.length; i++) {
                        //   debugPrint('DS : ${_gpValuesDS[i]}');
                        // }
                        // for (int i = 0; i < _gpValuesDK.length; i++) {
                        //   debugPrint('DK : ${_gpValuesDK[i]}');
                        // }
                        bool isAllAnswered = true;
                        if (_gpValuesDS.contains(_initialValue) ||
                            _gpValuesDK.contains(_initialValue)) {
                          isAllAnswered = false;
                        }

                        if (!isAllAnswered) {
                          debugPrint(
                              'There are still questions left unanswered.');
                        } else {
                          debugPrint('All questions has been answered.');
                          int correctAnsDS = 0;
                          int correctAnsDK = 0;
                          for (int i = 0; i < _itemsDS.length; i++) {
                            if (_gpValuesDS[i].toLowerCase() == _itemsDS[i].answer) {
                              correctAnsDS++;
                            }
                          }
                          for (int i = 0; i < _itemsDK.length; i++) {
                            if (_gpValuesDK[i].toLowerCase() == _itemsDK[i].answer) {
                              correctAnsDK++;
                            }
                          }
                          debugPrint('Domain Sikap : $correctAnsDS/${_itemsDS.length}');
                          debugPrint('Domain Kecekapan : $correctAnsDK/${_itemsDK.length}');
                        }
                      },
                      child: const Text('Answers')),
                ],
              );
            }
            return const ScoreLoading();
          },
        ));
  }

  // to build list of question card. Divided to 2 sections.
  // First is the question number and the second is radio buttons.
  Widget listBuilder(String domain) {
    List<Widget> itemCard = [];
    List items;
    if (domain == 'DS') {
      items = _itemsDS;
    } else {
      items = _itemsDK;
    }
    // initializing the cards content
    for (int x = 0; x < items.length; x++) {
      if (domain == 'DS') {
        itemCard.insert(
            x,
            ItemCardIKK(
              item: items.elementAt(x),
              //  to store the selected answer
              selectedAnswer: _gpValuesDS[x],
              answer: (String value) {
                _gpValuesDS[x] = value;
              },
            ));
      } else {
        itemCard.insert(
            x,
            ItemCardIKK(
              item: items.elementAt(x),
              //  to store the selected answer
              selectedAnswer: _gpValuesDK[x],
              answer: (String value) {
                _gpValuesDK[x] = value;
              },
            ));
      }
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
}
