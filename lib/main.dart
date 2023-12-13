import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wicca_store_3/provider/CartProvider.dart';
import 'package:wicca_store_3/provider/FavouriteProvider.dart';
import 'package:wicca_store_3/provider/ProductProvider.dart';
import 'package:wicca_store_3/theme/themeutils.dart';
import 'package:wicca_store_3/views/splashpage.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var preferenceInstance = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(preferenceInstance);
  var result = GetIt.I.allReadySync();

  if (result == true) {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>> prefrences set successfully');
  } else {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Error When Set prefrences');
  }

  GetIt.I.registerSingleton<ProductProvider>(ProductProvider());
  GetIt.I.registerSingleton<FavouriteProvider>(FavouriteProvider());
  GetIt.I.registerSingleton<CartProvider>(CartProvider());

  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Wicca shop',
      theme: ThemeUtils.themeData,
      home: SplashPage(),
    );
  }
}
