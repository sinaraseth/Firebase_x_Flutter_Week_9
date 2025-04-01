import 'package:database_connection/model/location.dart';

abstract class LocationRepository {
  Future<Location> addLocation({
    required String capital_city,
    required String country,
    required int province,
  });
  Future<List<Location>> getLocation();
}
