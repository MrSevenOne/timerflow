import 'package:get/get_utils/get_utils.dart';
import 'package:timerflow/exports.dart';

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
      // ignore: use_build_context_synchronously
      final userViewmodel = context.read<UserViewmodel>();
      userViewmodel.getUserInfo(); // 🟢 SHU YERDA CHAQIRILYAPTI!
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
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
                decoration:  BoxDecoration(
                  color: theme.primaryColor,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title:  Text("settings".tr),
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.settings,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title:  Text("user_info".tr),
                onTap: () {
                  Navigator.pop(context); // Drawer yopilsin
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfilePage(userModel: user!),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title:  Text("log_out".tr),
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
