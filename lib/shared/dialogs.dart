import 'package:flutter/material.dart';
import 'package:fyp1/services/auth.dart';
import 'package:fyp1/shared/appcolors.dart';

class Dialogs {
  // final void Function() confirmFunction;

  showTestIncompleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 8,
                    child: SizedBox(
                      width: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Ujian Tidak Lengkap',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: AppColors.text1),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Sila lengkapkan semua soalan.',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.dialogText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        splashRadius: 1.0, // don't want splash for this button
                        padding: const EdgeInsets.all(0.0),
                        alignment: Alignment.topRight,
                        color: Colors.black38,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close)),
                  ),
                ],
              ));
        });
  }

  // dialog for confirmation on finishing a test
  confirmTestCompletion(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // description? content?
                SizedBox(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Serah Jawapan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: AppColors.text1),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Selesai menjawab ujian?',
                        style: TextStyle(
                            fontSize: 15.0, color: AppColors.dialogText),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 400, // how to make sizedbox take size of parent
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 80,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Tidak',
                              style: TextStyle(
                                  color: AppColors.text1, fontSize: 15.0),
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 85,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.primary,
                              elevation: 0,
                              shadowColor: AppColors.secondary,
                            ),
                            child: const Text(
                              'Ya',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  logOutConfirmation(BuildContext context) {
    AuthService _auth = AuthService();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Log Keluar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: AppColors.text1),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Log Keluar?',
                        style: TextStyle(
                            fontSize: 15.0, color: AppColors.dialogText),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 400, // how to make sizedbox take size of parent
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 80,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Batal',
                              style: TextStyle(
                                  color: AppColors.text1, fontSize: 15.0),
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 85,
                        child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await _auth.logOut();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.primary,
                              elevation: 0,
                            ),
                            child: const Text(
                              'Ya',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
