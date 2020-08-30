import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lecture_3/utils/helper.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<String> searchResults = [];
  TextEditingController searchController = TextEditingController();
  Timer _timer;
  final int _delayTime = 500;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(() {
      if (_timer != null && _timer.isActive) {
        _timer.cancel();
      }
      _timer = Timer(Duration(milliseconds: _delayTime), () async {
        if (searchController.text != '') {
          _toSearch(searchController.text);
        } else {
          setState(() {
            searchResults = [];
          });
        }
      });
    });
  }

  Future<void> _toSearch(String input) async {
    var param = {
      'input': input,
    };
    var headers = {'Content-type': 'application/json'};
    var endpoint = '$BASE_API_URL/getSearchResult';
    var response =
        await post(endpoint, headers: headers, body: json.encode(param));
    setState(() {
      searchResults = json.decode(response.body).cast<String>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
                controller: searchController,
                decoration: InputDecoration(hintText: 'search your favorites')),
            Container(
                height: 200,
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text(searchResults[index]));
                  },
                ))
          ],
        ),
      ),
    );
  }
}
