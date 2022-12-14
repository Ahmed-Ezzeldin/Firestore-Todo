import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_mvvm/model/services/auth_service.dart';
import 'package:firebase_mvvm/model/services/preference.dart';
import 'package:firebase_mvvm/model/services/provider_setup.dart';
import 'package:firebase_mvvm/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  /// ============================= Initialize before calling [runApp]
  WidgetsFlutterBinding.ensureInitialized();

  /// ============================= Initialize Preference
  await Preference.initialize();

  /// ============================= Initialize Firebase
  await Firebase.initializeApp();

  /// ============================= Setup Git it (Locator)
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: "Firebase ToDo",
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const SplashScreen(),
      ),
    );
  }
}