import 'dart:convert';
import 'dart:io';

import '../model/location.dart';
import '../repository/location_repository.dart';
import 'package:http/http.dart' as http;
import '../dto/location_dto.dart';

class FirebaselocationRepository extends LocationRepository {
  static const String baseUrl =
      'https://w8-firebase-section-default-rtdb.asia-southeast1.firebasedatabase.app/';
  static const String locationCollection = "location";
  static const String allLocationUlr = '$baseUrl/$locationCollection.json';
  Uri uri = Uri.parse(allLocationUlr);

  @override
  Future<Location> addLocation({
    required String capital_city,
    required String country,
    required int province,
  }) async {

    // Create a new data
    final newLocationData = {'capital_city': capital_city, 'country': country, 'province': province};
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newLocationData),
    );

    // Handle errors
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add user');
    }

    // Firebase returns the new ID in 'capital_city'
    final newId = json.decode(response.body)['capital_city'];

    // Return created user
    return Location(id: newId, capital_city: capital_city, country: country, province: province);
  }

  @override
  Future<List<Location>> getLocation() async {
    final http.Response response = await http.get(uri);

    // Handle errors
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load');
    }

    // Return all users
    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data == null) return [];
    return data.entries
        .map((entry) => LocationDto.fromJson(entry.key, entry.value))
        .toList();
  }

  @override
   Future<http.Response> deleteLocation({required String id}) async {
     Uri uriDelete = Uri.parse('$baseUrl/$locationCollection/$id.json');
     final http.Response response = await http.delete(
       uriDelete,
       headers: {'Content-Type': 'application/json'},
     );
 
     if (response.statusCode != HttpStatus.ok) {
       throw Exception('Failed to delete student');
     }
 
     return response;
   }
 
   @override
   Future<Location> updateLocation({
     required String id,
     required String capital_city,
     required String country,
     required int province,
   }) async {
     final updateLocation = {'capital_city': capital_city, 'country': country, 'province': province};
     Uri uriUpdate = Uri.parse('$baseUrl/$locationCollection/$id.json');
     final http.Response response = await http.put(
       uriUpdate,
       headers: {'Content-Type': 'application/json'},
       body: json.encode(updateLocation),
     );
 
     // Handle errors
     if (response.statusCode != HttpStatus.ok) {
       throw Exception('Failed to add user');
     }
 
     // Return created user
     return Location(id: id, capital_city: capital_city, country: country, province: province);
   }
}
