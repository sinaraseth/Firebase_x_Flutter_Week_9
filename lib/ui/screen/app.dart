import 'package:database_connection/model/location.dart';
import 'package:database_connection/ui/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
   const App({super.key});
 
   void _onAddPressed(BuildContext context) {
     final LocationProvider locationProvider = context.read<LocationProvider>();
     locationProvider.addLocation("Bangkok", "Thailand", 34);
   }
 
   @override
   Widget build(BuildContext context) {
     final locationProvider = Provider.of<LocationProvider>(context);
 
     Widget content = const Text('');
     if (locationProvider.isLoading) {
       content = const CircularProgressIndicator();
     } else if (locationProvider.hasData) {
       List<Location> locations = locationProvider.locationState!.data!;
 
       if (locations.isEmpty) {
         content = const Text("No data yet");
       } else {
         content = ListView.builder(
           itemCount: locations.length,
           itemBuilder:
               (context, index) => ListTile(
                 title: Text(locations[index].capital_city),
                 subtitle: Column(
                   children: [
                    Text(locations[index].country),
                    Text("${locations[index].province}"),
                   ],
                 ),
 
                 trailing: IconButton(
                   icon: const Icon(Icons.delete, color: Colors.red),
                   onPressed: () => {},
                 ),
               ),
         );
       }
     }
 
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.blue,
         actions: [
           IconButton(
             onPressed: () => _onAddPressed(context),
             icon: const Icon(Icons.add),
           ),
         ],
       ),
       body: Center(child: content),
     );
   }
 }