

import 'dart:async';

import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

import 'bloc.dart';

class RestaurantBloc implements Bloc {
  
  final Location location;
  final _client = ZomatoClient();
  final _controller = StreamController<List<Restaurant>>();
  
  Stream<List<Restaurant>> get stream => _controller.stream;
  RestaurantBloc(this.location);

  void submitQuery(String query) async{
    final results = await _client.fetchRestaurants(location, query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
    // TODO: implement dispose
  }

}