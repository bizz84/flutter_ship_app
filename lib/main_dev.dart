import 'firebase_options_dev.dart';
import 'main.dart';

// * Entry point for the dev flavor
void main() async {
  await runMainApp(firebaseOptions: DefaultFirebaseOptions.currentPlatform);
}
