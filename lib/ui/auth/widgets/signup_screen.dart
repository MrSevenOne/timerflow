import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timerflow/config/constants.dart';
import 'package:timerflow/routing/router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _configPasswordController = TextEditingController();
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: AppConstants.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Do you have account? ',style: theme.textTheme.titleSmall,),
            TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.login,), child: Text('Login',style: theme.textTheme.titleSmall?.copyWith(color: theme.primaryColorLight,fontWeight: FontWeight.w700,),),),
          ],
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(AppConstants.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.0,
          children: [
            Text("Sign Up",style: theme.textTheme.headlineMedium,),
            SizedBox(height: 12.h),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password'
              ),
            ),
            TextField(
              controller: _configPasswordController,
              decoration: InputDecoration(
                labelText: 'Config password'
              ),
            ),
            SizedBox(
              height: 60.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('sign up'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
