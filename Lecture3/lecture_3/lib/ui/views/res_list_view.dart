import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lecture_3/core/model/restaurant.dart';
import 'package:lecture_3/ui/views/details_view.dart';
import 'package:lecture_3/utils/helper.dart';

class ResListView extends StatefulWidget {
  final String category;
  ResListView({@required this.category});
  @override
  _ResListViewState createState() => _ResListViewState();
}

class _ResListViewState extends State<ResListView> {
  @override
  void initState() {
    super.initState();
    // load restaurant.json when start up
    loadRestaurantByCategory().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> loadRestaurantByCategory() async {
    var param = {
      "category": widget.category,
    };
    var headers = {'Content-type': 'application/json'};
    var endpoint = '$BASE_API_URL/getResByCategory';
    Response response =
        await post(endpoint, headers: headers, body: json.encode(param));
    for (var jsonRes in json.decode(response.body)) {
      var res = Restaurant(
          jsonRes['resName'],
          jsonRes['priceRange'],
          jsonRes['category1'],
          jsonRes['category2'],
          jsonRes['rating'].toDouble(),
          jsonRes['image_url'],
          jsonRes['address']);
      resList.add(res);
    }
  }

  List<Restaurant> resList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.red),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
              itemCount: resList.length,
              itemBuilder: (BuildContext context, int index) {
                return ResListCard(res: resList[index]);
              }),
        ));
  }
}

class ResListCard extends StatelessWidget {
  final Restaurant res;

  ResListCard({@required this.res});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: FlatButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsView(
                        res: res,
                      )));
        },
        padding: EdgeInsets.all(0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(res.resImage,
                  fit: BoxFit.cover, height: 200, width: double.infinity),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                child: Text(
                  res.resName,
                  maxLines: 1,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                        '${res.priceRange} • ${res.cuisineType1} • ${res.cuisineType2}'),
                    Expanded(child: SizedBox()),
                    Text('1.9 km'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/google_logo.jpg',
                        height: 20, width: 20),
                    SizedBox(width: 2),
                    Text('4.5'),
                    SizedBox(width: 2),
                    Icon(Icons.star, size: 20),
                    Icon(Icons.star, size: 20),
                    Icon(Icons.star, size: 20),
                    Icon(Icons.star, size: 20),
                    Icon(Icons.star_half, size: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
