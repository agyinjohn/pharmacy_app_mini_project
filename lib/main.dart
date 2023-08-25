import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_health_app/commons/user_provider.dart';

import 'package:pharmacy_health_app/screens/welcome_screen.dart';
import 'package:pharmacy_health_app/widgets/navbar_roots.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async{
WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyAai3TcTKb3ZGp54dJvIkBkluCaUAXZ5HE',
    appId: '1:817558497715:web:193cbfff556a357b5503c6',
    messagingSenderId: '817558497715',
    projectId: 'parmacy-app',
    authDomain: 'parmacy-app.firebaseapp.com',
    storageBucket: 'parmacy-app.appspot.com',
    ));
  }else {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } 

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(color: Colors.black,);
          }

          if (snapshot.hasData) {
     
            return NavBarRoots();
          }
          return  WelcomeScreen();
        },
      ),
    );
  }
}
