// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_mvvm/model/services/auth_service.dart';
// import 'package:firebase_mvvm/model/services/preference.dart';
// import 'package:firebase_mvvm/model/services/provider_setup.dart';
// import 'package:firebase_mvvm/view/screens/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   /// ============================= Initialize before calling [runApp]
//   WidgetsFlutterBinding.ensureInitialized();

//   /// ============================= Initialize Preference
//   await Preference.initialize();

//   /// ============================= Initialize Firebase
//   await Firebase.initializeApp();

//   /// ============================= Setup Git it (Locator)
//   setupLocator();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthService()),
//       ],
//       child: MaterialApp(
//         title: "Firebase ToDo",
//         theme: ThemeData(primarySwatch: Colors.teal),
//         home: const SplashScreen(),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}