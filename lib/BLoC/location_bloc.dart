import 'dart:async';

import 'package:restaurant_finder/BLoC/bloc.dart';

import '../DataLayer/location.dart';

class LocationBloc implements Bloc {
  Location _location;
  Location get selectedLocation => _location;
/* 1
 * Here a private StreamController is declared that will manage the 
 * stream and sink for this BLoC. StreamControllers use generics to tell 
 * the type system what kind of object will be emitted from the stream.
*/
  final _locationController = StreamController<Location>();
// 2 This line exposes a public getter to the StreamController’s stream.
  Stream<Location> get locationStream => _locationController.stream;
/* 3
 * This function represents the input for the BLoC. A Location model 
 * object will be provided as parameter that is cached in the object’s 
 * private _location property and then added to sink for the stream.
*/ 
  void selectLocation(Location location) {
    _location = location;
    _locationController.sink.add(location);
  }

//4 Finally, in clean up method, the StreamController is closed when this object is deallocated.
  @override
  void dispose() {
    _locationController.close();
  }
}
