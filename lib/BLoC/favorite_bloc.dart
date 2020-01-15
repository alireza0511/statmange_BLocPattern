
import 'dart:async';

import 'package:restaurant_finder/DataLayer/restaurant.dart';

import 'bloc.dart';


class FavoriteBloc implements Bloc {
  
  var _restaurants = <Restaurant>[];
  List<Restaurant> get favorites => _restaurants;
  /* 
   * This BLoC uses a Broadcast StreamController instead of a regular 
   * StreamController. Broadcast streams allow multiple listeners, whereas 
   * regular streams only allow one. For the previous two blocs, multiple 
   * streams weren’t needed since there was only a one-to-one relationship. 
   * For the favoriting feature, the app needs to listen to the stream in 
   * two places, so broadcast is required. 
  */
  final _controller = StreamController<List<Restaurant>>.broadcast();
  Stream<List<Restaurant>> get favoritesStream => _controller.stream;

  void toggleRestaurant(Restaurant restaurant) {
    if (_restaurants.contains(restaurant)){
      _restaurants.remove(restaurant);
    } else {
      _restaurants.add(restaurant);
    }

    _controller.sink.add(_restaurants);
  }

  @override
  void dispose() {
    _controller.close();
  }

}