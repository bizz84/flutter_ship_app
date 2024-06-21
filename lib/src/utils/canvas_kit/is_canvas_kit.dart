// Use a conditional export to expose the correct API depending on the platform
export 'unsupported.dart'
    if (dart.library.js) 'web.dart'
    if (dart.library.io) 'native.dart';
