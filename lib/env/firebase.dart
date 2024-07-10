import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_ship_app/env/flavor.dart';
import 'package:flutter_ship_app/firebase_options_prod.dart' as prod;
import 'package:flutter_ship_app/firebase_options_stg.dart' as stg;
import 'package:flutter_ship_app/firebase_options_dev.dart' as dev;

Future<void> initializeFirebaseApp() async {
  final firebaseOptions = switch (getFlavor()) {
    Flavor.prod => prod.DefaultFirebaseOptions.currentPlatform,
    Flavor.stg => stg.DefaultFirebaseOptions.currentPlatform,
    Flavor.dev => dev.DefaultFirebaseOptions.currentPlatform,
  };
  await Firebase.initializeApp(options: firebaseOptions);
}
