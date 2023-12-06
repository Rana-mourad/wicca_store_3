import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wicca_store_3/theme/themeutils.dart';
import 'package:wicca_store_3/views/splashpage.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var prefrenceInstance = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(prefrenceInstance);

  var result = GetIt.I.allReadySync();

  if (result == true) {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>> prefrences set successfully');
  } else {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Error When Set prefrences');
  }

  // await PrefrencesService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopify Application',
      theme: ThemeUtils.themeData,
      home: SplashPage(),
    );
  }
}
