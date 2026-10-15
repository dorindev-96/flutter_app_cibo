import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Makes path_provider return [percorso] as the app documents directory.
void simulaCartellaDocumenti(String percorso) {
  TestWidgetsFlutterBinding.ensureInitialized();
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/path_provider'),
        (_) async => percorso,
      );
}
