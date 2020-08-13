import 'package:flutter/material.dart';
import 'package:lecture_3/core/model/restaurant.dart';
import 'package:lecture_3/ui/views/details_view.dart';

class ResCard extends StatelessWidget {
  final Restaurant res;
  ResCard({@required this.res});
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
                  fit: BoxFit.cover, height: 100, width: 250),
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
