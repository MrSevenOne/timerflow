import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/auth/auth_viewmodel.dart';
import 'package:timerflow/%20presentation/providers/auth/user_viewmodel.dart';
import 'package:timerflow/%20presentation/widgets/drawer/user_infoedit.dart';
import 'package:timerflow/domain/models/user_model.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final userViewmodel = context.read<UserViewmodel>();
      userViewmodel.getUserInfo(); // 🟢 SHU YERDA CHAQIRILYAPTI!
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Drawer(
  child: Consumer<UserViewmodel>(
    builder: (context, userViewmodel, child) {
      if (userViewmodel.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      final UserModel? user = userViewmodel.userModel;
      final String userName = user?.username ?? 'Guest User';
      final String userEmail = user?.email ?? 'No email';

      return ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
  accountName: Text(userName),
  accountEmail: Text(userEmail),
  currentAccountPicture: const CircleAvatar(
    backgroundColor: Colors.white,
    child: Icon(Icons.person, size: 40, color: Colors.grey),
  ),
  otherAccountsPictures: [
    IconButton(
      icon: const Icon(Icons.settings, color: Colors.white),
      onPressed: () {
        Navigator.pop(context); // Drawer yopilsin
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EditProfilePage(userModel: user!),
          ),
        );
      },
    ),
  ],
  decoration: const BoxDecoration(
    color: Colors.green,
  ),
),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Log out"),
            onTap: () {
              context.read<AuthViewModel>().signOut(context);
            },
          ),
        ],
      );
    },
  ),
);

  }
}

