import 'package:flutter/material.dart';
import 'package:fyp1/shared/appcolors.dart';
import 'package:fyp1/shared/dialogs.dart';

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
                Dialogs().logOutConfirmation(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
