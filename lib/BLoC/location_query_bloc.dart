
import 'dart:async';

import '../DataLayer/location.dart';
import '../DataLayer/zomato_client.dart';
import 'bloc.dart';

class LocationQueryBloc implements Bloc {
  
  final _controller = StreamController<List<Location>>();
  final _client = ZomatoClient();
  Stream<List<Location>> get LocationStream => _controller.stream;

  void submitQuery(String query) async {
    /**
     * 1
     * in the BLoC’s input, the method accepts a string and uses 
     * the ZomatoClient class from the starter project to fetch locations from 
     * the API. This uses Dart’s async/await syntax to make the code a bit 
     * cleaner. The results are then published to the stream.
     */
    final results = await _client.fetchLocations(query);
    _controller.sink.add(results);
  }
  
  @override
  void dispose() {
    _controller.close();
  }

}