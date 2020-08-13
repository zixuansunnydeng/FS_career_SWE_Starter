import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lecture_3/core/model/user.dart';
import 'package:provider/provider.dart';

class BookingsView extends StatefulWidget {
  @override
  _BookingsViewState createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  bool loggedin = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<Map<String, dynamic>> login(email, password) async {
    var param = {
      'email': email,
      'password': password,
    };
    var headers = {'Content-type': 'application/json'};
    var endpoint = 'http://52.91.147.61/login';
    var response =
        await post(endpoint, headers: headers, body: json.encode(param));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text('Bookings', style: TextStyle(color: Colors.white))),
        body: loggedin
            ? BookingsColumn()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'email',
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'password',
                      ),
                    ),
                    SizedBox(height: 16),
                    RaisedButton(
                      onPressed: () async {
                        // call login api
                        var response = await login(
                            emailController.text, passwordController.text);
                        print(response);
                        var output = response['status'];
                        if (output == 'Success') {
                          // do something
                          var userData = response['user'];
                          Provider.of<User>(context, listen: false).useremail =
                              userData['email'];
                          Provider.of<User>(context, listen: false).name =
                              userData['name'];
                          Provider.of<User>(context, listen: false)
                                  .reservations =
                              List<String>.from(userData['reservations']);
                          Provider.of<User>(context, listen: false)
                                  .bookingsImages =
                              List<String>.from(response['resImages']);
                          setState(() {
                            loggedin = true;
                          });
                        } else if (output == 'Incorrect email') {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Wrong Email'),
                                  content:
                                      Text('Please into the correct email'),
                                );
                              });
                        } else if (output == 'Wrong Password') {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Wrong Password'),
                                  content:
                                      Text('Please into the correct password'),
                                );
                              });
                        }
                      },
                      child:
                          Text('Log In', style: TextStyle(color: Colors.white)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.red,
                    ),
                  ],
                ),
              ));
  }
}

class BookingsColumn extends StatefulWidget {
  @override
  _BookingsColumnState createState() => _BookingsColumnState();
}

class _BookingsColumnState extends State<BookingsColumn> {
  @override
  Widget build(BuildContext context) {
    // list of restaurant names
    // 1. Api loadRestaurantData(resName) => Restaurant data
    // 2.
    var bookings = Provider.of<User>(context, listen: false).reservations;
    var bookingsImages =
        Provider.of<User>(context, listen: false).bookingsImages;
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(bookingsImages[index]),
                backgroundColor: Colors.black),
            title: Text(bookings[index]),
            subtitle: Row(
              children: [
                Icon(Icons.person, size: 15),
                Text(' 2, 4:30 PM Today'),
              ],
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title:
                          Text('Are you sure you want to cancel this booking?'),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              Provider.of<User>(context, listen: false)
                                  .reservations
                                  .remove(bookings[index]);
                            });
                            // TODO: clear bookings inside database
                            // Create a new API in the backend
                            // and call that API
                            Navigator.of(context).pop();
                          },
                          child: Text('Yes, cancel'),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("No"),
                        )
                      ],
                    );
                  });
            });
      },
    );
  }
}
