import 'package:flutter/material.dart';
import 'package:wicca_store_3/Services/prefrence_servce.dart';
import 'package:wicca_store_3/views/login.dart';
import 'package:wicca_store_3/views/master_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    checkUser();
    super.initState();
  }

  void checkUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    var result = PrefrencesService.prefs?.get('user');
    if (context.mounted) {
      if (result != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MasterPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      ),
    );
  }
}
