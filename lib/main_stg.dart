import 'firebase_options_stg.dart';
import 'main.dart';

// * Entry point for the stg flavor
void main() async {
  await runMainApp(firebaseOptions: DefaultFirebaseOptions.currentPlatform);
}
