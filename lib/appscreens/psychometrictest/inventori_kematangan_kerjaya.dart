import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp1/appscreens/psychometrictest/test_result.dart';
import 'package:fyp1/appscreens/psychometrictest/update_scores.dart';
import 'package:fyp1/models/inventory_item.dart';
import 'package:fyp1/models/user.dart';
import 'package:fyp1/services/database.dart';
import 'package:fyp1/shared/appcolors.dart';
import 'package:fyp1/shared/loading.dart';
import 'package:fyp1/shared/dialogs.dart';

class PsychometricTestIKK extends StatefulWidget {
  const PsychometricTestIKK({Key key, this.user}) : super(key: key);
  final MyUser user;

  @override
  _PsychometricTestIKKState createState() => _PsychometricTestIKKState();
}

class _PsychometricTestIKKState extends State<PsychometricTestIKK> {
  Dialogs dialogs = Dialogs();
  List<ItemIKK> _itemsDS; // domain sikap
  List<ItemIKK> _itemsDK; // domain kecekapan
  final String _initialValue = 'Not selected';
  final String _testValue = "Tidak setuju";

  // 14/01/2022 group values for each domain
  List<String> _gpValuesDK;
  List<String> _gpValuesDS;
  num _dsScore = 0, _dkScore = 0;
  num _dsPercentageScore = 0, _dkPercentageScore = 0;

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
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        border: Border(
                      left: BorderSide(
                        color: AppColors.primary,
                        width: 4.0,
                      ),
                    )),
                    child: const Text(
                      'Domain Sikap',
                      style: TextStyle(
                          color: AppColors.text2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  listBuilder("DS"),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        border: Border(
                      left: BorderSide(
                        color: AppColors.primary,
                        width: 4.0,
                      ),
                    )),
                    child: const Text(
                      'Domain Kecekapan',
                      style: TextStyle(
                          color: AppColors.text2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  listBuilder("DK"),
                  const SizedBox(height: 16.0),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.secondary.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: const Offset(0, 0))
                        ]),
                    child: ElevatedButton(
                        onPressed: () async {
                          _dsScore = 0;
                          _dkScore = 0;
                          bool isAllAnswered = true;
                          // Check if there are any questions still not answered
                          if (_gpValuesDS.contains(_initialValue) ||
                              _gpValuesDK.contains(_initialValue)) {
                            isAllAnswered = false;
                          }

                          for (int i = 0; i < _itemsDS.length; i++) {
                            if (_gpValuesDS[i].toLowerCase() ==
                                _itemsDS[i].answer) {
                              _dsScore++;
                            }
                          }
                          for (int i = 0; i < _itemsDK.length; i++) {
                            if (_gpValuesDK[i].toLowerCase() ==
                                _itemsDK[i].answer) {
                              _dkScore++;
                            }
                          }
                          _dsPercentageScore = _dsScore / _itemsDS.length * 100;
                          _dkPercentageScore = _dkScore / _itemsDK.length * 100;

                          if (!isAllAnswered) {
                            debugPrint(
                                'There are still questions left unanswered.');
                            dialogs.showTestIncompleteDialog(context);
                          } else {
                            // If all question has been answered prompt user
                            // to continue to the result page
                            dynamic isTestComplete =
                                await dialogs.confirmTestCompletion(context);
                            if (isTestComplete == true) {
                              await UpdateIKKScore(_dsScore, _dkScore)
                              .updateScoretoFirebase();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TestResultScreen(
                                            dsScore: _dsScore,
                                            dsPercentageScore:
                                                _dsPercentageScore,
                                            dkScore: _dkScore,
                                            dkPercentageScore:
                                                _dkPercentageScore,
                                          )),
                                  (route) => false);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primary,
                          elevation: 0.0,
                          padding: const EdgeInsets.all(12.0),
                        ),
                        child: const Text(
                          'Seterusnya',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )),
                  ),
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
    List<ItemIKK> items;
    items = domain == 'DS' ? _itemsDS : _itemsDK;
    // Initializing the cards content
    for (int x = 0; x < items.length; x++) {
      itemCard.insert(
          x,
          ItemCardIKK(
            item: items.elementAt(x),
            selectedAnswer: items.elementAt(x).domain == 'sikap'
                ? _gpValuesDS[x]
                : _gpValuesDK[x],
            answer: (String value) {
              items.elementAt(x).domain == 'sikap'
                  ? _gpValuesDS[x] = value
                  : _gpValuesDK[x] = value;
            },
          ));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      addAutomaticKeepAlives: true,
      physics: const BouncingScrollPhysics(),
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
    );
  }
}
