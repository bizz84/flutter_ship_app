import 'firebase_options_prod.dart';
import 'main.dart';

// * Entry point for the prod flavor
void main() async {
  await runMainApp(firebaseOptions: DefaultFirebaseOptions.currentPlatform);
}
