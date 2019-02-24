import 'package:flutter/material.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:spotify/spotify_io.dart' as spotify;

import 'package:tasty_tracks/pages/track/track_details.dart';
import 'package:tasty_tracks/pages/search/track_search_delegate.dart';

class SearchPage extends StatefulWidget {
  static final String routeName = '/search';
  final String pageTitle = 'Search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  _handleSelectedItem(Object selectedItem) {
    if (selectedItem != null) {
      // Navigate to details page for selected item
      if (selectedItem is spotify.TrackSimple) {
        Navigator.of(context)
            .pushNamed(TrackDetailsPage.routeName + ':${selectedItem.id}');
      } else if (selectedItem is spotify.AlbumSimple) {
        // TODO
        print('TODO Album details');
      } else if (selectedItem is spotify.Artist) {
        // TODO
        print('TODO Artist details');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FeatherIcons.search,
                    size: 18.0,
                  ),
                  Text('Search'),
                ],
              ),
              color: Colors.white,
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: TrackSearchDelegate(),
                ).then((selectedItem) {
                  _handleSelectedItem(selectedItem);
                });
              },
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('TODO Recent searches'),
          ],
        ),
      ),
    );
  }
}
