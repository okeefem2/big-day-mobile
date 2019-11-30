import 'package:big_day_mobile/models/place_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  static const route = '/map';
  final PlaceLocation initialLocation;
  final bool allowSelection;

  const MapPage({
    Key key,
    this.initialLocation =
        const PlaceLocation(latitude: 37.422, longitude: -122.084),
    this.allowSelection = false,
  }) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng _location;

  void _selectLocation(LatLng pos) {
    setState(() {
      _location = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: <Widget>[
          if (widget.allowSelection)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _location == null
                  ? null
                  : () => Navigator.of(context).pop(_location),
            )
        ],
      ),
      // Assumes height and width of parent
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
          // This is also used in the static map, could be a good idea to have this be set
          // as a global config value
        ),
        onTap: widget.allowSelection ? _selectLocation : null,
        markers: {
          Marker(
            markerId: MarkerId(_location.toString()),
            position: _location != null
                ? _location
                : LatLng(widget.initialLocation.latitude,
                    widget.initialLocation.longitude),
          ),
        },
      ),
    );
  }
}
