// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

bool isCanvasKitRenderer() {
  final dynamic flutterCanvasKit = js.context['flutterCanvasKit'];
  return flutterCanvasKit != null;
}
