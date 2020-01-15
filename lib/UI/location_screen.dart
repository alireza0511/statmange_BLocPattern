
import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/location_bloc.dart';
import 'package:restaurant_finder/BLoC/location_query_bloc.dart';

import '../DataLayer/location.dart';

class LocationScreen extends StatelessWidget {
  /* Add a boolean field to LocationScreen to track whether the screen is 
   * a full screen dialog. The boolean is just a simple flag 
   * (that defaults to false) which will be used later to update the 
   * navigation behavior when a location is tapped.
   */
  final bool isFullScreenDialog;
  const LocationScreen({Key key, this.isFullScreenDialog = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    /** 1
     * First, the app instantiates a new LocationQueryBloc at the top of the build method.
     */
    final bloc = LocationQueryBloc();
    /** 2
     * The BLoC is then stored in a BlocProvider, which will manage its lifecycle.
    */
    return BlocProvider<LocationQueryBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Where do you want to eat?')),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a location'),
                /** 3
                 * Update the TextField’s onChanged closure to submit the text to 
                 * the LocationQueryBloc. This will kick off the chain of calling 
                 * Zomato and then emit the found locations to the stream.
                */
                onChanged: (query) => bloc.submitQuery(query),
              ),
            ),
            /** 4
             * Pass the bloc to the _buildResults method.
            */
            Expanded(
              child: _buildResults(bloc),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResults(LocationQueryBloc bloc) {
    return StreamBuilder<List<Location>>(
      stream: bloc.LocationStream,
      builder: (context, snapshot) {
        final results = snapshot.data;

        if (results == null) {
          return Center(child: Text('Enter a location'));
        }

        if (results.isEmpty) {
          return Center(child: Text('No Results'));
        }

        return _buildSearchResults(results);
      },
    );
  }

  Widget _buildSearchResults(List<Location> results) {
    /** */
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (BuildContext ctx, int index) => Divider(),
      itemBuilder: (cxt, index) {
        final location = results[index];
        return ListTile(
          title: Text(location.title),
          onTap: () {
            /** 
             * In the onTap closure, the app retrieves the LocationBloc that
             * is living at the root of the tree and tells it that the user has 
             * selected a location.
            */
            // 3
            final locationBloc = BlocProvider.of<LocationBloc>(cxt);
            locationBloc.selectLocation(location);

            if (isFullScreenDialog) {
              Navigator.of(cxt).pop();
            }
          },
        );
      },
    );
  }
}
