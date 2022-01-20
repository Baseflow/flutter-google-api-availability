import 'package:flutter_test/flutter_test.dart';
import 'package:google_api_availability/google_api_availability.dart';

void main() {
  test(
      'GooglePlayServicesAvailability has the right amount of availability states',
      () {
    const values = GooglePlayServicesAvailability.values;

    expect(values.length, 8);
  });

  test('check if corresponding status gets received when calling constructor',
      () {
    const values = GooglePlayServicesAvailability.values;

    for (var i = 0; i < values.length; i++) {
      expect(values[i], GooglePlayServicesAvailability.byValue(i));
    }
  });

  test('check if toString method returns the corresponding name', () {
    var playServicesAvailability = const GooglePlayServicesAvailability.private(0);

    expect(playServicesAvailability.toString(),
        'GooglePlayServicesAvailability.success');
  });
}
