import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repository/firebase_location_repository.dart';
import '../repository/location_repository.dart';
import 'ui/provider/location_provider.dart';
import 'ui/screen/app.dart';

void main() async {
  final LocationRepository locationRepository = FirebaselocationRepository();

  runApp(ChangeNotifierProvider(
    create: (context) => LocationProvider(locationRepository),
    child: const MaterialApp(debugShowCheckedModeBanner: false, home: App()),
  ));
}
