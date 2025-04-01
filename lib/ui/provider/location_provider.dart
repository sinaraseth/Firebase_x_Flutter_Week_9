import '../../model/location.dart';
import 'package:flutter/material.dart';
import '../../async_value.dart';
import '../../repository/location_repository.dart';

class LocationProvider extends ChangeNotifier {
   final LocationRepository _repository;
   AsyncValue<List<Location>>? locationState;
 
   LocationProvider(this._repository) {
     fetchUsers();
   }
 
   bool get isLoading =>
       locationState != null && locationState!.state == AsyncValueState.loading;
   bool get hasData =>
       locationState != null && locationState!.state == AsyncValueState.success;
 
   void fetchUsers() async {
     try {
       // 1- loading state
       locationState = AsyncValue.loading();
       notifyListeners();
 
       // 2 - Fetch users
       locationState = AsyncValue.success(await _repository.getLocation());
 
       print("SUCCESS: list size ${locationState!.data!.length.toString()}");
 
       // 3 - Handle errors
     } catch (error) {
       print("ERROR: $error");
       locationState = AsyncValue.error(error);
     }
 
     notifyListeners();
   }
 
   void addLocation(String capital_city, String country, int province) async {
     // 1- Call repo to add
     _repository.addLocation(capital_city: capital_city, country: country, province: province);
 
     // 2- Call repo to fetch
     fetchUsers();
   }
}
