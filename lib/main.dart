import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mager/app/splash_screen/splash_screen_page.dart';
import 'package:mager/shared/providers/user_provider.dart';
import 'package:mager/shared/theme_preferences/theme_provider.dart';
import 'package:mager/shared/theme_style.dart';
import 'package:provider/provider.dart';

void configLoading(BuildContext context) {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 20.0
    ..progressColor = Theme.of(context).primaryColor
    ..backgroundColor = Theme.of(context).primaryColor
    ..indicatorColor = Theme.of(context).primaryColor
    ..textColor = Theme.of(context).primaryColor
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          storageBucket: 'gs://mager-1c2d6.appspot.com',
          apiKey: 'AIzaSyAZYKa7M_x5eThsho_jHgQaGO8FSPzGz74',
          appId: '1:981074680844:android:02f412fe70934bb6a8a229',
          messagingSenderId: '981074680844',
          projectId: "mager-1c2d6"));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeProvider = ThemeProvider();

  @override
  void initState() {
    configLoading(context);
    getCurrentTheme();
    super.initState();
  }

  void getCurrentTheme() async {
    themeProvider.theme = await themeProvider.themePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: ChangeNotifierProvider(create: (_) {
        return themeProvider;
      }, child: Consumer<ThemeProvider>(builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mager',
          theme: themeProvider.theme == 'light' ? lightTheme : darkTheme,
          home: const SplashScreenPage(),
          builder: EasyLoading.init(),
        );
      })),
    );
  }
}
