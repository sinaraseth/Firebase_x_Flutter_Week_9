

import 'package:database_connection/model/location.dart';
import 'package:database_connection/ui/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationForm extends StatefulWidget {
   final Mode mode;
   //final String? id;
   final Location? location;
   const LocationForm({super.key, required this.mode, this.location});
 
   @override
   State<LocationForm> createState() => _LocationFormState();
 }
 
 class _LocationFormState extends State<LocationForm> {
   final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
 
   final TextEditingController _capital_cityController = TextEditingController();
   final TextEditingController _countryController = TextEditingController();
   final TextEditingController _provinceController = TextEditingController();
 
   @override
   void dispose() {
     _capital_cityController.dispose();
     _countryController.dispose();
     _provinceController.dispose();
     super.dispose();
   }
 
   @override
   void initState() {
     super.initState();
     if (widget.mode != Mode.add && widget.location != null) {
       _capital_cityController.text = widget.location!.capital_city;
       _countryController.text = widget.location!.country;
       _provinceController.text = widget.location!.province.toString();
     }
   }
 
   void _submitForm() {
     if (_globalKey.currentState!.validate()) {
       String capital_city = _capital_cityController.text;
       String country = _countryController.text;
       int province = int.tryParse(_provinceController.text) ?? 0;
       if (widget.mode == Mode.add) {
         final LocationProvider locationProvider = context.read<LocationProvider>();
         locationProvider.addLocation(capital_city, country, province);
         Navigator.pop(context);
       } else {
         final LocationProvider locationProvider = context.read<LocationProvider>();
         locationProvider.updateLocation(widget.location!.id, capital_city, country, province);
         Navigator.pop(context);
       }
     }
   }
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text(widget.mode == Mode.add ? 'Add Location' : 'Update Location'),
       ),
       body: Padding(
         padding: const EdgeInsets.all(16.0),
         child: Form(
           key: _globalKey,
           child: Column(
             children: [
               TextFormField(
                 controller: _capital_cityController,
                 decoration: const InputDecoration(hintText: 'Input capital city'),
                 validator: (String? value) {
                   if (value == null || value.isEmpty) {
                     return 'Please input some capital city';
                   }
                   return null;
                 },
               ),
               
               const SizedBox(height: 16),
               TextFormField(
                 controller: _countryController,
                 decoration: const InputDecoration(hintText: 'Input country'),
                 keyboardType: TextInputType.emailAddress,
                 validator: (String? value) {
                   if (value == null || value.isEmpty) {
                     return 'Please input some country';
                   }
                   return null;
                 },
               ),
               const SizedBox(height: 16),
               TextFormField(
                 controller: _provinceController,
                 decoration: const InputDecoration(hintText: 'Input province'),
                 keyboardType: TextInputType.number,
                 validator: (String? value) {
                   if (value == null || value.isEmpty) {
                     return 'Please input some province';
                   }
                   if (int.tryParse(value) == null) {
                     return 'Please enter a valid number';
                   }
                   return null;
                 },
               ),
               const SizedBox(height: 32),
               ElevatedButton(
                 onPressed: _submitForm,
                 child: const Text('Submit'),
               ),
             ],
           ),
         ),
       ),
     );
   }
 }