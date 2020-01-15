import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/favorite_bloc.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/UI/restaurant_tile.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: StreamBuilder<List<Restaurant>>(
        stream: bloc.favoritesStream,
        /**
         * This adds some initial data to the StreamBuilder. StreamBuilders 
         * will immediately fire their builder closure, even if there is no 
         * data. Instead of repainting the screen unnecessarily, this allows 
         * Flutter to make sure the snapshot always has data.
         */
        initialData: bloc.favorites,
        builder: (context, snapshot) {
          /**
           * Here the app checks the state of the stream and if it hasn’t connected 
           * yet, uses the explicit list of favorite restaurants instead of a 
           * new event from stream.
           */
          List<Restaurant> favorites =
              (snapshot.connectionState == ConnectionState.waiting)
                  ? bloc.favorites
                  : snapshot.data;

          if (favorites == null || favorites.isEmpty) {
            return Center(
              child: Text('No Favorites'),
            );
          }

          return ListView.separated(
            itemCount: favorites.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final restaurant = favorites[index];
              return RestaurantTile(restaurant: restaurant);
            },
          );
        },
      ),
    );
  }
}
