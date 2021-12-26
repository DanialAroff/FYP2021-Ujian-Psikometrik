import 'package:flutter/material.dart';
import 'package:fyp1/shared/appcolors.dart';

// test item model
class ItemIKK {
  final String question;
  final String answer;

  ItemIKK(this.question, this.answer);

  ItemIKK.fromMap(Map data)
      : question = data['question'],
        answer = data['answer'];
}

class ItemCardIKK extends StatefulWidget {
  const ItemCardIKK({
    Key key,
    this.item,
    this.selectedAnswer,
  }) : super(key: key);
  final ItemIKK item;
  final String selectedAnswer;

  @override
  _ItemCardIKKState createState() => _ItemCardIKKState();
}

class _ItemCardIKKState extends State<ItemCardIKK> {
  String selectedAnswer;

  @override
  void initState() {
    super.initState();
    selectedAnswer = widget.selectedAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Wrap(children: [
            Text(
              widget.item.question,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ]),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Radio(
                value: 'setuju',
                groupValue: selectedAnswer,
                onChanged: (String value) {
                  setState(() => selectedAnswer = value);
                },
                activeColor: AppColors.primary,
                splashRadius: 12,
                visualDensity: const VisualDensity(horizontal: -4, vertical: 0),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
                child: Text(
                  'Setuju',
                  style: TextStyle(fontSize: 15),
                ),
              )
            ],
          ),
          Row(
            children: [
              Radio(
                value: 'tidak setuju',
                groupValue: selectedAnswer,
                onChanged: (String value) {
                  setState(() => selectedAnswer = value);
                },
                activeColor: AppColors.primary,
                splashRadius: 12,
                visualDensity: const VisualDensity(horizontal: -4, vertical: 0),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
                child: Text(
                  'Tidak Setuju',
                  style: TextStyle(fontSize: 15),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
