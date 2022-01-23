import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'appcolors.dart';

extension CapExtenstion on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
  String get capitalizeFirstofEach =>
      split(" ").map((str) => str.inCaps).join(" ");
}

class ScoreCard extends StatelessWidget {
  final DocumentSnapshot score;
  final String title;
  const ScoreCard({Key key, this.score, this.title='Inventori'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 4)),
      ], borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: const EdgeInsets.all(14),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              getRows(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRows() {
    Map<String, dynamic> data = score.data();
    List domains = data.keys.toList();

    List<Widget> list = [];
    for (var element in domains) {
      String domainName = element.replaceAll('_', ' ');
      domainName = domainName.capitalizeFirstofEach;
      list.add(domainRow(domainName, score.get(element)));
      list.add(const SizedBox(height: 8));
    }

    return Column(
      children: list,
    );
  }

  Widget domainRow(String domain, double score) {
    return Column(
      children: [
        Row(
          children: [
            Text(domain),
            const Spacer(),
            Text('${(score * 100).toInt()}%')
          ],
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: score,
            minHeight: 16,
            backgroundColor: Colors.black12,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.secondary),
          ),
        ),
      ],
    );
  }
}