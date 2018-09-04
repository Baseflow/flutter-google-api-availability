part of google_api_availability;

class Codec {
  static GooglePlayServicesAvailability decodePlayServicesAvailability(
      dynamic value) {
    final dynamic availability = json.decode(value.toString());

    return GooglePlayServicesAvailability.values.firstWhere(
        (GooglePlayServicesAvailability e) =>
            e.toString().split('.').last == availability);
  }

  static String encodeEnum(dynamic value) {
    return value.toString().split('.').last;
  }
}
