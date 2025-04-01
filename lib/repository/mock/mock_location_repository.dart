
 import 'package:database_connection/model/location.dart';
import 'package:database_connection/repository/location_repository.dart';

class MocklocationRepository extends LocationRepository {
   final List<Location> locations = [];
 
   @override
   Future<Location> addLocation({
     required String capital_city,
     required String country,
     required int province,
   }) {
     return Future.delayed(const Duration(seconds: 1), () {
       Location newLocation = Location(
         id: "03",
         capital_city: capital_city,
         country: 'Cambodia',
         province: 25,
       );
       locations.add(newLocation);
       return newLocation;
     });
   }
 
   @override
   Future<List<Location>> getLocation() {
     return Future.delayed(const Duration(seconds: 1), () => locations);
   }
 }