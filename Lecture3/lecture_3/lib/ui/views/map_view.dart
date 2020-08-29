import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:lecture_3/core/model/restaurant.dart';
import 'package:lecture_3/ui/views/subviews/res_card.dart';
import 'package:lecture_3/utils/helper.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  List<Restaurant> resList = [];
  Restaurant selectedRes;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    // load restaurant.json when start up
    loadRestaurant().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> loadRestaurant() async {
    // Use your own server api, make a GET request on /getRes
    var endpoint = '$BASE_API_URL/getRes';
    Response response = await get(endpoint);
    for (var jsonRes in json.decode(response.body)) {
      var res = Restaurant(
          jsonRes['resName'],
          jsonRes['priceRange'],
          jsonRes['category1'],
          jsonRes['category2'],
          jsonRes['rating'].toDouble(),
          jsonRes['image_url'],
          jsonRes['address'],
          jsonRes['lat'],
          jsonRes['lng']);
      resList.add(res);
      markers.add(
        Marker(
          markerId: MarkerId(res.resName),
          position: LatLng(res.lat, res.lng),
          onTap: () {
            setState(
              () {
                selectedRes = res;
              },
            );
          },
        ),
      );
    }
  }

  static final CameraPosition _dtToronto = CameraPosition(
    target: LatLng(43.6495, -79.3774),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _dtToronto,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: markers,
          ),
          selectedRes != null ? 
          Positioned(
            bottom: 10,
            left: 10,
            right: 50,
            child: ResCard(res: selectedRes),
          ) : Container()
        ],
      ),
    );
  }
}
