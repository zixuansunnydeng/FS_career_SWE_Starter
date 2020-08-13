import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lecture_3/core/model/restaurant.dart';
import 'package:lecture_3/core/model/user.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatefulWidget {
  final Restaurant res;

  DetailsView({@required this.res});

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  Future<String> makeBooking(String email, String resName) async {
    var param = {
      'email': email,
      'resName': resName,
    };
    var headers = {'Content-type': 'application/json'};
    var endpoint = 'http://52.91.147.61/book';
    var response =
        await post(endpoint, headers: headers, body: json.encode(param));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: <Widget>[
          Image.network(widget.res.resImage, height: 200, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Row(
              children: <Widget>[
                Text(widget.res.resName,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: double.minPositive,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                    size: 25,
                  ),
                  onPressed: () {},
                ),
                Expanded(child: SizedBox()),
                Text(
                  widget.res.priceRange,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
            child: Row(
              children: [
                Image.asset('assets/google_logo.jpg', height: 20, width: 20),
                SizedBox(width: 2),
                Text('${widget.res.rating}'),
                SizedBox(width: 2),
                Icon(Icons.star, size: 20),
                Icon(Icons.star, size: 20),
                Icon(Icons.star, size: 20),
                Icon(Icons.star, size: 20),
                Icon(Icons.star_half, size: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
            child: Text('${widget.res.address}'),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Popular Dishes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Container(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    FlatButton(
                        child: Image.network(
                          widget.res.resImage,
                        ),
                        onPressed: () {}),
                    Text('Prime Ribs',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    FlatButton(
                        child: Image.network(widget.res.resImage),
                        onPressed: () {}),
                    Text(
                      'Teriyaki',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    FlatButton(
                        child: Image.network(widget.res.resImage),
                        onPressed: () {}),
                    Text(
                      'Teriyaki',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: Provider.of<User>(context, listen: false)
                      .reservations
                      .contains(widget.res.resName)
                  ? null
                  : () async {
                      if (Provider.of<User>(context, listen: false).useremail ==
                          null) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Not Logged In'),
                                content:
                                    Text('Please log in first in bookings.'),
                              );
                            });
                      } else {
                        var email = Provider.of<User>(context, listen: false).useremail;
                        var output = await makeBooking(email, widget.res.resName);
                        if (output == 'Success') {
                          setState(() {
                            Provider.of<User>(context, listen: false)
                                .reservations
                                .add(widget.res.resName);
                            Provider.of<User>(context, listen: false)
                                .bookingsImages
                                .add(widget.res.resImage);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Success'),
                                  content: Text('You booking was successful'),
                                );
                              },
                            );
                          });
                        }
                      }
                    },
              child:
                  Text('Book the table', style: TextStyle(color: Colors.white)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
