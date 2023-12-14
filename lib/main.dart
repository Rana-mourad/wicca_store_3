import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wicca_store_3/firebase_options.dart';
import 'package:wicca_store_3/provider/CartProvider.dart';
import 'package:wicca_store_3/provider/FavouriteProvider.dart';
import 'package:wicca_store_3/provider/ProductProvider.dart';
import 'package:wicca_store_3/provider/ProfileProvider.dart';
import 'package:wicca_store_3/theme/themeutils.dart';
import 'package:get_it/get_it.dart';
import 'package:wicca_store_3/views/splashpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();
  DefaultFirebaseOptions.currentPlatform;

  var preferenceInstance = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(preferenceInstance);

  var result = GetIt.I.allReadySync();

  if (result == true) {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>> prefrences set successfully');
  } else {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Error When Set prefrences');
  }
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider for better management
    return MultiProvider(
      providers: [
        // Registering providers
        Provider<ProductProvider>(
          create: (_) => ProductProvider(),
        ),
        Provider<FavouriteProvider>(
          create: (_) => FavouriteProvider(),
        ),
        Provider<CartProvider>(
          create: (_) => CartProvider(),
        ),
        Provider<ProfileProvider>(
          create: (_) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Wicca shop',
        theme: ThemeUtils.themeData,
        home: SplashPage(),
      ),
    );
  }
}
