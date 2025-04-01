import 'package:database_connection/model/location.dart';

class LocationDto {
  static Location fromJson(String id, Map<String, dynamic> json) {
    return Location(
        id: id,
        capital_city: json['capital_city'],
        country: json['country'],
        province: json['province']
      );
  }

  static Map<String, dynamic> toJson(Location location) {
    return {
      'capital_city': location.capital_city,
      'country': location.country,
      'province': location.province
    };
  }
}
