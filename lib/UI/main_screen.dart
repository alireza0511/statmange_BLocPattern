import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/location_bloc.dart';

import '../DataLayer/location.dart';
import 'location_screen.dart';
import 'restaurant_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    /**
     * StreamBuilders are the secret sauce to make the BLoC pattern 
     * very tasty. These widgets will automatically listen for events 
     * from the stream. When a new event is received, the builder closure 
     * will be executed, updating the widget tree. With StreamBuilder and 
     * the BLoC pattern, there is no need to call setState() once in this 
     * entire tutorial.
     */
    StreamBuilder<Location>(
      /** 1
       * For the stream property, use the of method to retrieve the 
       * LocationBloc and add its stream to this StreamBuilder.
      */
      stream: BlocProvider.of<LocationBloc>(context).locationStream,
      builder: (context, snapshot){
        final location = snapshot.data;
        /** 2
         * Initially the stream has no data, which is perfectly normal. 
         * If there isn’t any data in your stream, the app will return a 
         * LocationScreen. Otherwise, return just blank container for now.
        */
        if (location == null){
          return LocationScreen();
        }
        return RestaurantScreen(location: location);
      },
      );
    
  }
}