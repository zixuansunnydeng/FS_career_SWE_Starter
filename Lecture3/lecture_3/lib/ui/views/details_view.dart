import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecture_3/core/model/restaurant.dart';

class DetailsView extends StatelessWidget {
  final String useremail;
  final Restaurant res;

  DetailsView({@required this.res, @required this.useremail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: <Widget>[
          Image.network(res.resImage, height: 200, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Row(
              children: <Widget>[
                Text(res.resName,
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
                  res.priceRange,
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
                Text('${res.rating}'),
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
            child: Text('${res.address}'),
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
                          res.resImage,
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
                        child: Image.network(res.resImage), onPressed: () {}),
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
                        child: Image.network(res.resImage), onPressed: () {}),
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
              onPressed: () {
                print('book');
                print(useremail);
              },
              child:
                  Text('Boot the table', style: TextStyle(color: Colors.white)),
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
