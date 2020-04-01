import 'package:flutter_test/flutter_test.dart';
import 'package:e2e/e2e.dart';
import 'package:google_api_availability/google_api_availability.dart';

void main() {
  E2EWidgetsFlutterBinding.ensureInitialized();

  testWidgets('can check for availability', (WidgetTester tester) async {
    // Depending on the target device, this should not throw but simply return a value.
    await GoogleApiAvailability.instance
        .checkGooglePlayServicesAvailability(false);
  });
}
