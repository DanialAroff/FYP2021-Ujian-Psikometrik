import 'package:flutter/material.dart';
import 'package:fyp1/services/auth.dart';
import 'package:fyp1/shared/appcolors.dart';

class LogoutDialog {
  createLogoutDialog(BuildContext context) {
    AuthService _auth = AuthService();
    return showDialog(
        context: context,
        barrierColor: Colors.black54,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            insetAnimationDuration: const Duration(milliseconds: 700),
            child: Container(
              padding: const EdgeInsets.all(12),
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: Text(
                        'Log Keluar?',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await _auth.logOut();
                      },
                      child: const Text('Log Keluar',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: AppColors.primary,
                        fixedSize: const Size(200.0, 40.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        side: const BorderSide(
                          color: AppColors.primary,
                          width: 1.0,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Batal',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        primary: AppColors.text2,
                        fixedSize: const Size(200.0, 40.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        side: const BorderSide(
                          color: AppColors.gray,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }
}

class AppDrawer extends StatelessWidget {
  final String fullName;
  final String email;

  const AppDrawer({Key key, this.fullName, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primary),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito Sans',
                    fontSize: 12,
                  ),
                ),
                Text(
                  fullName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito Sans',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              selected: true,
              title: Text(
                'Laman Utama',
                style: TextStyle(color: AppColors.text2),
              ),
              leading: Icon(Icons.home, color: Color(0xff303030)),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text(
                'Profil',
                style: TextStyle(color: AppColors.text2),
              ),
              leading: Icon(Icons.person, color: Color(0xff303030)),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text(
                'Log Keluar',
                style: TextStyle(color: AppColors.text2),
              ),
              leading: const Icon(Icons.logout, color: Color(0xff303030)),
              onTap: () {
                LogoutDialog().createLogoutDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
