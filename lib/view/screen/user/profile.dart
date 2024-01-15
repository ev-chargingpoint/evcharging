import 'package:evchargingpoint/view/auth/login_screen.dart';
import 'package:evchargingpoint/view/screen/user/detail_profile.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Anda yakin ingin logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pushAndRemoveUntil(
                dialogContext,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text('Ya'),
          ),
        ],
      );
    },
  );
}

class _ProfileMenuState extends State<ProfileMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Menu'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DetailProfile()),
                        );
                      },
                      leading: const Icon(Icons.person),
                      title: const Text('Account Details'),
                      trailing:
                          const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.lock),
                      title: const Text('Change Password'),
                      trailing:
                          const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  onTap: () {
                    _showLogoutConfirmationDialog(context);
                  },
                  leading: const Icon(Icons.logout_outlined, color: Colors.red),
                  title: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
