import '../../model/location.dart';
import '../../ui/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget/location_form.dart';
import '../../utils/animations_util.dart';

class App extends StatelessWidget {
  const App({super.key});

  void _onAddPressed(BuildContext context) async {
    Navigator.of(
      context,
    ).push(AnimationUtils.createTopToBottomRoute(
        const LocationForm(mode: Mode.add)));
  }

  void _onDeletePress(BuildContext context, String id) {
    final LocationProvider locationProvider = context.read<LocationProvider>();
    locationProvider.deleteLocation(id);
  }

  void _onUpdateLocation(BuildContext context, Location location) {
    Navigator.of(context).push(
      AnimationUtils.createTopToBottomRoute(
        LocationForm(mode: Mode.update, location: location),
      ),
    );
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
            itemBuilder: (context, index) => ListTile(
                  title: RichText(
                    text: TextSpan(
                      text: "Capital City: ",
                      style: const TextStyle(
                          color: Colors
                              .black), // Default style for "Capital City:"
                      children: [
                        TextSpan(
                          text: locations[index].capital_city,
                          style: const TextStyle(
                              fontWeight: FontWeight
                                  .bold), // Bold style for the city name
                        ),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Country: ",
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: locations[index].country,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Text("${locations[index].province} provinces"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            _onDeletePress(context, locations[index].id),
                      ),
                      IconButton(
                        onPressed: () =>
                            _onUpdateLocation(context, locations[index]),
                        icon: const Icon(Icons.edit, color: Colors.blue),
                      ),
                    ],
                  ),
                ));
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
