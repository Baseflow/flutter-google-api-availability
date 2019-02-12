part of google_api_availability;

class Codec {
  static GooglePlayServicesAvailability decodePlayServicesAvailability(
      String value) {
    final dynamic availability = json.decode(value);

    return GooglePlayServicesAvailability.values.firstWhere(
        (GooglePlayServicesAvailability e) =>
            e.toString().split('.').last == availability);
  }

  static String encodeEnum(GooglePlayServicesAvailability value) {
    return value.toString().split('.').last;
  }
}
